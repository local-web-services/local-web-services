/** SQS wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import { LocalQueue } from "./queue";
import type { ServerState } from "../../types";
export declare class SqsStore {
    private queues;
    private queueTags;
    private port;
    constructor(port: number);
    reset(): void;
    getQueueTags(nameOrUrl: string): Record<string, string>;
    setQueueTags(nameOrUrl: string, tags: Record<string, string>): void;
    removeQueueTags(nameOrUrl: string, tagKeys: string[]): void;
    queueUrl(name: string): string;
    createQueue(name: string, attributes?: Record<string, string>): LocalQueue;
    getQueue(nameOrUrl: string): LocalQueue | undefined;
    listQueues(prefix?: string): LocalQueue[];
    deleteQueue(nameOrUrl: string): void;
}
export declare function registerSqs(app: FastifyInstance, state: ServerState, port: number): SqsStore;
//# sourceMappingURL=index.d.ts.map