/** In-memory SQS queue implementation. */
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
export declare class LocalQueue {
    name: string;
    url: string;
    visibilityTimeout: number;
    isFifo: boolean;
    contentBasedDedup: boolean;
    maxReceiveCount: number;
    dlq?: LocalQueue;
    private _messages;
    private _dedupCache;
    constructor(name: string, url: string, options?: {
        visibilityTimeout?: number;
        isFifo?: boolean;
        contentBasedDedup?: boolean;
        dlq?: LocalQueue;
        maxReceiveCount?: number;
    });
    get messages(): SqsMessage[];
    sendMessage(body: string, options?: {
        messageAttributes?: Record<string, unknown>;
        delaySeconds?: number;
        messageGroupId?: string;
        messageDedupId?: string;
    }): string;
    receiveMessages(maxMessages?: number, waitTimeSeconds?: number): SqsMessage[];
    deleteMessage(receiptHandle: string): void;
    changeMessageVisibility(receiptHandle: string, visibilityTimeoutSeconds: number): void;
    purge(): void;
    approximateMessageCount(): number;
    private _purgeDedupCache;
}
//# sourceMappingURL=queue.d.ts.map