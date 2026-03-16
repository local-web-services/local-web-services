/** In-memory SQS queue implementation. */

import { v4 as uuidv4 } from "uuid";
import * as crypto from "crypto";

export interface SqsMessage {
  messageId: string;
  body: string;
  attributes: Record<string, string>;
  messageAttributes: Record<string, unknown>;
  receiptHandle: string;
  receiveCount: number;
  sentTimestamp: number;
  visibilityTimeoutUntil: number;
  messageGroupId?: string;
  messageDedupId?: string;
}

export class LocalQueue {
  name: string;
  url: string;
  visibilityTimeout: number;
  isFifo: boolean;
  contentBasedDedup: boolean;
  maxReceiveCount: number;
  dlq?: LocalQueue;

  private _messages: SqsMessage[] = [];
  private _dedupCache: Map<string, number> = new Map();

  constructor(
    name: string,
    url: string,
    options: {
      visibilityTimeout?: number;
      isFifo?: boolean;
      contentBasedDedup?: boolean;
      dlq?: LocalQueue;
      maxReceiveCount?: number;
    } = {}
  ) {
    this.name = name;
    this.url = url;
    this.visibilityTimeout = options.visibilityTimeout ?? 30;
    this.isFifo = options.isFifo ?? false;
    this.contentBasedDedup = options.contentBasedDedup ?? false;
    this.dlq = options.dlq;
    this.maxReceiveCount = options.maxReceiveCount ?? 0;
  }

  get messages(): SqsMessage[] {
    return this._messages;
  }

  sendMessage(
    body: string,
    options: {
      messageAttributes?: Record<string, unknown>;
      delaySeconds?: number;
      messageGroupId?: string;
      messageDedupId?: string;
    } = {}
  ): string {
    this._purgeDedupCache();

    let dedupId = options.messageDedupId;
    if (!dedupId && this.isFifo && this.contentBasedDedup) {
      dedupId = crypto.createHash("sha256").update(body).digest("hex");
    }

    if (dedupId) {
      const existing = this._messages.find((m) => m.messageDedupId === dedupId);
      if (existing) return existing.messageId;
    }

    const messageId = uuidv4();
    const now = Date.now();
    const delayMs = (options.delaySeconds ?? 0) * 1000;

    const msg: SqsMessage = {
      messageId,
      body,
      attributes: { ApproximateReceiveCount: "0" },
      messageAttributes: options.messageAttributes ?? {},
      receiptHandle: uuidv4(),
      receiveCount: 0,
      sentTimestamp: now,
      visibilityTimeoutUntil: delayMs > 0 ? now + delayMs : 0,
      messageGroupId: options.messageGroupId,
      messageDedupId: dedupId,
    };

    this._messages.push(msg);

    if (dedupId) {
      this._dedupCache.set(dedupId, now + 5 * 60 * 1000); // 5-minute dedup window
    }

    return messageId;
  }

  receiveMessages(maxMessages: number = 1, waitTimeSeconds: number = 0): SqsMessage[] {
    void waitTimeSeconds; // long polling not supported in-memory (sync)
    const now = Date.now();
    const visible = this._messages.filter(
      (m) => m.visibilityTimeoutUntil === 0 || m.visibilityTimeoutUntil <= now
    );

    const toReturn = visible.slice(0, maxMessages);
    const visTimeout = this.visibilityTimeout * 1000;

    for (const msg of toReturn) {
      msg.receiptHandle = uuidv4();
      msg.receiveCount += 1;
      msg.attributes["ApproximateReceiveCount"] = String(msg.receiveCount);
      msg.visibilityTimeoutUntil = now + visTimeout;

      // DLQ routing
      if (this.dlq && this.maxReceiveCount > 0 && msg.receiveCount >= this.maxReceiveCount) {
        this.dlq.sendMessage(msg.body, { messageAttributes: msg.messageAttributes });
        this._messages = this._messages.filter((m) => m.messageId !== msg.messageId);
      }
    }

    return toReturn.filter((m) => this._messages.includes(m));
  }

  deleteMessage(receiptHandle: string): boolean {
    const before = this._messages.length;
    this._messages = this._messages.filter((m) => m.receiptHandle !== receiptHandle);
    return this._messages.length < before;
  }

  isMessageInFlight(receiptHandle: string): boolean {
    const now = Date.now();
    const msg = this._messages.find((m) => m.receiptHandle === receiptHandle);
    if (!msg) return false;
    return msg.visibilityTimeoutUntil > now;
  }

  changeMessageVisibility(receiptHandle: string, visibilityTimeoutSeconds: number): boolean {
    const msg = this._messages.find((m) => m.receiptHandle === receiptHandle);
    if (!msg) return false;
    msg.visibilityTimeoutUntil =
      visibilityTimeoutSeconds === 0 ? 0 : Date.now() + visibilityTimeoutSeconds * 1000;
    return true;
  }

  purge(): void {
    this._messages = [];
    this._dedupCache.clear();
  }

  approximateMessageCount(): number {
    const now = Date.now();
    return this._messages.filter((m) => m.visibilityTimeoutUntil === 0 || m.visibilityTimeoutUntil <= now).length;
  }

  private _purgeDedupCache(): void {
    const now = Date.now();
    for (const [key, expiry] of this._dedupCache) {
      if (expiry <= now) this._dedupCache.delete(key);
    }
  }
}
