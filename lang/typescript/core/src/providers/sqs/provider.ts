/**
 * SQS provider — in-memory queues.
 *
 * Mirrors `providers/sqs/provider.py`.
 */

import type { IProvider } from "../../interfaces/provider.js";
import { LocalQueue } from "./queue.js";

const FAKE_ACCOUNT = "000000000000";
const FAKE_REGION = "us-east-1";

export interface RedrivePolicy {
  deadLetterQueueName: string;
  maxReceiveCount?: number;
}

export interface QueueConfig {
  queueName: string;
  visibilityTimeout?: number;
  isFifo?: boolean;
  contentBasedDedup?: boolean;
  redrivePolicy?: RedrivePolicy;
  tags?: Record<string, string>;
}

export function buildQueueConfig(queueName: string, attrs: Record<string, string>): QueueConfig {
  return {
    queueName,
    visibilityTimeout: attrs["VisibilityTimeout"] !== undefined
      ? parseInt(attrs["VisibilityTimeout"], 10)
      : 30,
    isFifo: queueName.endsWith(".fifo"),
    contentBasedDedup: attrs["ContentBasedDeduplication"]?.toLowerCase() === "true",
  };
}

export class SqsProvider implements IProvider {
  readonly name = "sqs";

  private _configs: Map<string, QueueConfig>;
  private _preconfiguredNames: ReadonlySet<string>;
  private _queues = new Map<string, LocalQueue>();
  private _running = false;

  constructor(queues: QueueConfig[] = []) {
    this._configs = new Map(queues.map((q) => [q.queueName, q]));
    this._preconfiguredNames = new Set(queues.map((q) => q.queueName));
  }

  get queues(): Map<string, LocalQueue> {
    return this._queues;
  }

  get configs(): Map<string, QueueConfig> {
    return this._configs;
  }

  // ------------------------------------------------------------------
  // IProvider lifecycle
  // ------------------------------------------------------------------

  async start(): Promise<void> {
    // First pass: create all queues without DLQ links
    for (const config of this._configs.values()) {
      this._queues.set(config.queueName, this._makeQueue(config));
    }
    // Second pass: wire DLQ references
    for (const config of this._configs.values()) {
      if (config.redrivePolicy !== undefined) {
        const dlq = this._queues.get(config.redrivePolicy.deadLetterQueueName);
        if (dlq !== undefined) {
          const queue = this._queues.get(config.queueName)!;
          queue.deadLetterQueue = dlq;
          queue.maxReceiveCount = config.redrivePolicy.maxReceiveCount ?? 5;
        }
      }
    }
    this._running = true;
  }

  async stop(): Promise<void> {
    this._queues.clear();
    this._running = false;
  }

  async reset(): Promise<void> {
    // Remove dynamically-created queues; purge preconfigured ones
    for (const name of [...this._queues.keys()]) {
      if (!this._preconfiguredNames.has(name)) {
        this._queues.delete(name);
        this._configs.delete(name);
      }
    }
    for (const queue of this._queues.values()) {
      queue.messages = [];
    }
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  // ------------------------------------------------------------------
  // Queue management
  // ------------------------------------------------------------------

  getQueue(queueName: string): LocalQueue | undefined {
    return this._queues.get(queueName);
  }

  createQueueFromConfig(config: QueueConfig): LocalQueue {
    const existing = this._queues.get(config.queueName);
    if (existing !== undefined) return existing;
    const queue = this._makeQueue(config);
    this._queues.set(config.queueName, queue);
    this._configs.set(config.queueName, config);
    return queue;
  }

  async createQueue(queueName: string, attrs: Record<string, string> = {}): Promise<string> {
    const config = buildQueueConfig(queueName, attrs);
    this.createQueueFromConfig(config);
    return `http://localhost:4566/${FAKE_ACCOUNT}/${queueName}`;
  }

  async deleteQueue(queueName: string): Promise<void> {
    if (!this._queues.has(queueName)) throw new Error(`Queue not found: ${queueName}`);
    this._queues.delete(queueName);
    this._configs.delete(queueName);
  }

  async getQueueAttributes(queueName: string): Promise<Record<string, string>> {
    const queue = this._requireQueue(queueName);
    const attrs: Record<string, string> = {
      QueueArn: `arn:aws:sqs:${FAKE_REGION}:${FAKE_ACCOUNT}:${queueName}`,
      ApproximateNumberOfMessages: String(queue.messages.length),
      VisibilityTimeout: String(queue.visibilityTimeout),
      CreatedTimestamp: String(Math.floor(Date.now() / 1000)),
      LastModifiedTimestamp: String(Math.floor(Date.now() / 1000)),
    };
    if (queue.isFifo) {
      attrs["FifoQueue"] = "true";
      attrs["ContentBasedDeduplication"] = String(queue.contentBasedDedup);
    }
    return attrs;
  }

  async listQueues(): Promise<string[]> {
    return [...this._queues.keys()].sort();
  }

  async purgeQueue(queueName: string): Promise<void> {
    this._requireQueue(queueName).messages = [];
  }

  // ------------------------------------------------------------------
  // Internal
  // ------------------------------------------------------------------

  private _makeQueue(config: QueueConfig): LocalQueue {
    return new LocalQueue({
      queueName: config.queueName,
      ...(config.visibilityTimeout !== undefined && { visibilityTimeout: config.visibilityTimeout }),
      ...(config.isFifo !== undefined && { isFifo: config.isFifo }),
      ...(config.contentBasedDedup !== undefined && { contentBasedDedup: config.contentBasedDedup }),
    });
  }

  private _requireQueue(queueName: string): LocalQueue {
    const queue = this._queues.get(queueName);
    if (queue === undefined) throw new Error(`Queue not found: ${queueName}`);
    return queue;
  }

  queueUrl(queueName: string, port: number): string {
    return `http://localhost:${port}/${FAKE_ACCOUNT}/${queueName}`;
  }
}
