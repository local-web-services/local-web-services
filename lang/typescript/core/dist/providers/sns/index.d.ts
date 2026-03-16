/** SNS wire-protocol Fastify plugin. */
import type { FastifyInstance } from "fastify";
import type { ServerState } from "../../types";
interface Topic {
    arn: string;
    name: string;
    attributes: Record<string, string>;
    subscriptions: Subscription[];
    tags: Record<string, string>;
}
interface Subscription {
    subscriptionArn: string;
    topicArn: string;
    protocol: string;
    endpoint: string;
    attributes: Record<string, string>;
}
export declare class SnsStore {
    private topics;
    private subscriptions;
    reset(): void;
    createTopic(name: string, attrs?: Record<string, string>): Topic;
    deleteTopic(arn: string): void;
    getTopic(arn: string): Topic | undefined;
    listTopics(): Topic[];
    subscribe(topicArn: string, protocol: string, endpoint: string): Subscription;
    setSubscriptionAttribute(subscriptionArn: string, name: string, value: string): void;
    unsubscribe(subscriptionArn: string): void;
    publish(topicArn: string, message: string, subject?: string): string;
    listSubscriptions(): Subscription[];
    listSubscriptionsByTopic(topicArn: string): Subscription[];
    getSubscription(subscriptionArn: string): Subscription | undefined;
    setTopicAttributes(topicArn: string, attributeName: string, attributeValue: string): void;
    tagResource(topicArn: string, tags: Array<{
        Key: string;
        Value: string;
    }>): void;
    untagResource(topicArn: string, tagKeys: string[]): void;
    listTagsForResource(topicArn: string): Array<{
        Key: string;
        Value: string;
    }>;
}
export declare function registerSns(app: FastifyInstance, state: ServerState): SnsStore;
export {};
//# sourceMappingURL=index.d.ts.map