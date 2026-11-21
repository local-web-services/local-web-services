/**
 * In-memory SQS queue.
 *
 * Node.js is single-threaded so explicit locking is not required; async
 * operations (long-poll wait) use Promises/timers.
 *
 * Mirrors `providers/sqs/queue.py`.
 */

import { createHash, randomUUID } from "node:crypto";

export interface MessageAttributes {
  [key: string]: { DataType: string; StringValue?: string; BinaryValue?: Buffer };
}

export interface Message {
  messageId: string;
  receiptHandle: string;
  body: string;
  messageAttributes: MessageAttributes;
  receiveCount: number;
  sentTimestamp: number;
  /** Epoch ms after which the message is visible again. */
  visibleAfter: number;
  /** FIFO deduplication ID. */
  deduplicationId?: string;
  /** FIFO group ID. */
  groupId?: string;
}

export interface LocalQueueOptions {
  queueName: string;
  visibilityTimeout?: number;
  isFifo?: boolean;
  contentBasedDedup?: boolean;
}

export class LocalQueue {
  readonly queueName: string;
  readonly visibilityTimeout: number;
  readonly isFifo: boolean;
  readonly contentBasedDedup: boolean;

  messages: Message[] = [];
  deadLetterQueue?: LocalQueue;
  maxReceiveCount = 1000;

  private _seenDeduplicationIds = new Map<string, number>();

  constructor(opts: LocalQueueOptions) {
    this.queueName = opts.queueName;
    this.visibilityTimeout = opts.visibilityTimeout ?? 30;
    this.isFifo = opts.isFifo ?? opts.queueName.endsWith(".fifo");
    this.contentBasedDedup = opts.contentBasedDedup ?? false;
  }

  // ------------------------------------------------------------------
  // Core operations
  // ------------------------------------------------------------------

  async sendMessage(
    body: string,
    attrs: MessageAttributes = {},
    delaySeconds = 0,
    deduplicationId?: string,
    groupId?: string,
  ): Promise<string> {
    const effectiveDeduplicationId =
      deduplicationId ?? (this.contentBasedDedup ? LocalQueue.md5OfBody(body) : undefined);

    if (this.isFifo && effectiveDeduplicationId !== undefined) {
      const existing = this._seenDeduplicationIds.get(effectiveDeduplicationId);
      if (existing !== undefined && Date.now() - existing < 300_000) {
        return existing.toString();
      }
    }

    const msgId = randomUUID();
    const msg: Message = {
      messageId: msgId,
      receiptHandle: randomUUID(),
      body,
      messageAttributes: attrs,
      receiveCount: 0,
      sentTimestamp: Date.now(),
      visibleAfter: Date.now() + delaySeconds * 1000,
      ...(effectiveDeduplicationId !== undefined && { deduplicationId: effectiveDeduplicationId }),
      ...(groupId !== undefined && { groupId }),
    };
    this.messages.push(msg);

    if (this.isFifo && effectiveDeduplicationId !== undefined) {
      this._seenDeduplicationIds.set(effectiveDeduplicationId, Date.now());
    }

    return msgId;
  }

  async receiveMessages(maxMessages = 1, waitTimeSeconds = 0): Promise<Message[]> {
    const deadline = Date.now() + waitTimeSeconds * 1000;
    const pollIntervalMs = 100;

    while (true) {
      const now = Date.now();
      const visible = this.messages.filter((m) => m.visibleAfter <= now);
      if (visible.length > 0) {
        const batch = visible.slice(0, maxMessages);
        for (const msg of batch) {
          msg.receiveCount += 1;
          msg.visibleAfter = now + this.visibilityTimeout * 1000;
          msg.receiptHandle = randomUUID();

          if (
            this.deadLetterQueue !== undefined &&
            msg.receiveCount > this.maxReceiveCount
          ) {
            await this.deadLetterQueue.sendMessage(msg.body, msg.messageAttributes);
            this.messages = this.messages.filter((m) => m.messageId !== msg.messageId);
          }
        }
        return batch;
      }

      if (Date.now() >= deadline) return [];
      await new Promise<void>((resolve) => setTimeout(resolve, pollIntervalMs));
    }
  }

  async deleteMessage(receiptHandle: string): Promise<void> {
    const idx = this.messages.findIndex((m) => m.receiptHandle === receiptHandle);
    if (idx !== -1) this.messages.splice(idx, 1);
  }

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

  static md5OfBody(body: string): string {
    return createHash("md5").update(body).digest("hex");
  }
}
