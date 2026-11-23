import type { IProvider } from "../../interfaces/provider.js";
import { randomUUID } from "crypto";

const FAKE_REGION = "us-east-1";
const FAKE_ACCOUNT = "000000000000";

export interface TopicConfig {
  name: string;
}

interface TopicRecord {
  name: string;
  subscriptions: SubscriptionRecord[];
  tags: Record<string, string>;
}

interface SubscriptionRecord {
  SubscriptionArn: string;
  TopicArn: string;
  Protocol: string;
  Endpoint: string;
  Owner: string;
  attributes: Record<string, string>;
}

export interface PublishedMessage {
  MessageId: string;
  Message: string;
  Subject: string;
  Timestamp: string;
}

export class SnsProvider implements IProvider {
  readonly name = "sns";

  private _topics = new Map<string, TopicRecord>();
  private _messages = new Map<string, PublishedMessage[]>();
  private _subscriptions = new Map<string, SubscriptionRecord>();
  private _preconfiguredArns: ReadonlySet<string>;
  private _running = false;

  constructor(configs: TopicConfig[] = []) {
    const preArns: string[] = [];
    for (const c of configs) {
      const arn = this._topicArn(c.name);
      preArns.push(arn);
      this._topics.set(arn, { name: c.name, subscriptions: [], tags: {} });
      this._messages.set(arn, []);
    }
    this._preconfiguredArns = new Set(preArns);
  }

  async start(): Promise<void> {
    this._running = true;
  }

  async stop(): Promise<void> {
    this._topics.clear();
    this._messages.clear();
    this._subscriptions.clear();
    this._running = false;
  }

  async healthCheck(): Promise<boolean> {
    return this._running;
  }

  async reset(): Promise<void> {
    for (const arn of [...this._topics.keys()]) {
      if (!this._preconfiguredArns.has(arn)) {
        this._topics.delete(arn);
        this._messages.delete(arn);
      }
    }
    for (const arn of this._preconfiguredArns) {
      this._messages.set(arn, []);
    }
    this._subscriptions.clear();
  }

  createTopic(name: string): string {
    const arn = this._topicArn(name);
    if (!this._topics.has(arn)) {
      this._topics.set(arn, { name, subscriptions: [], tags: {} });
      this._messages.set(arn, []);
    }
    return arn;
  }

  deleteTopic(arn: string): void {
    if (!this._topics.has(arn)) {
      throw new Error(`NotFoundException: Topic ${arn} not found`);
    }
    this._topics.delete(arn);
    this._messages.delete(arn);
  }

  listTopics(): string[] {
    return [...this._topics.keys()].sort();
  }

  publish(topicArn: string, message: string, subject?: string): string {
    if (!this._topics.has(topicArn)) {
      throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    }
    const msgId = randomUUID();
    this._messages.get(topicArn)!.push({
      MessageId: msgId,
      Message: message,
      Subject: subject ?? "",
      Timestamp: new Date().toISOString(),
    });
    return msgId;
  }

  subscribe(topicArn: string, protocol: string, endpoint: string): string {
    if (!this._topics.has(topicArn)) {
      throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    }
    const subArn = `${topicArn}:${randomUUID()}`;
    const sub: SubscriptionRecord = {
      SubscriptionArn: subArn,
      TopicArn: topicArn,
      Protocol: protocol,
      Endpoint: endpoint,
      Owner: FAKE_ACCOUNT,
      attributes: {
        SubscriptionArn: subArn,
        TopicArn: topicArn,
        Protocol: protocol,
        Endpoint: endpoint,
        RawMessageDelivery: "false",
        FilterPolicy: "",
      },
    };
    this._subscriptions.set(subArn, sub);
    this._topics.get(topicArn)!.subscriptions.push(sub);
    return subArn;
  }

  unsubscribe(subscriptionArn: string): void {
    const sub = this._subscriptions.get(subscriptionArn);
    if (sub !== undefined) {
      const topic = this._topics.get(sub.TopicArn);
      if (topic !== undefined) {
        topic.subscriptions = topic.subscriptions.filter((s) => s.SubscriptionArn !== subscriptionArn);
      }
      this._subscriptions.delete(subscriptionArn);
    }
  }

  listSubscriptions(): SubscriptionRecord[] {
    return [...this._subscriptions.values()];
  }

  listSubscriptionsByTopic(topicArn: string): SubscriptionRecord[] {
    return this._topics.get(topicArn)?.subscriptions ?? [];
  }

  getTopicAttributes(topicArn: string): Record<string, string> {
    if (!this._topics.has(topicArn)) {
      throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    }
    return {
      TopicArn: topicArn,
      DisplayName: "",
      SubscriptionsConfirmed: "0",
      SubscriptionsPending: "0",
      SubscriptionsDeleted: "0",
    };
  }

  getPublishedMessages(topicArn: string): PublishedMessage[] {
    return this._messages.get(topicArn) ?? [];
  }

  tagTopic(topicArn: string, tags: Record<string, string>): void {
    const topic = this._topics.get(topicArn);
    if (topic === undefined) throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    Object.assign(topic.tags, tags);
  }

  untagTopic(topicArn: string, tagKeys: string[]): void {
    const topic = this._topics.get(topicArn);
    if (topic === undefined) throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    for (const key of tagKeys) delete topic.tags[key];
  }

  listTopicTags(topicArn: string): Record<string, string> {
    const topic = this._topics.get(topicArn);
    if (topic === undefined) throw new Error(`NotFoundException: Topic ${topicArn} not found`);
    return { ...topic.tags };
  }

  getSubscriptionAttributes(subscriptionArn: string): Record<string, string> {
    const sub = this._subscriptions.get(subscriptionArn);
    if (sub === undefined) throw new Error(`NotFoundException: Subscription ${subscriptionArn} not found`);
    return { ...sub.attributes };
  }

  setSubscriptionAttribute(subscriptionArn: string, attributeName: string, attributeValue: string): void {
    const sub = this._subscriptions.get(subscriptionArn);
    if (sub === undefined) throw new Error(`NotFoundException: Subscription ${subscriptionArn} not found`);
    sub.attributes[attributeName] = attributeValue;
  }

  publishBatch(
    topicArn: string,
    entries: { Id: string; Message: string; Subject?: string }[],
  ): { Successful: { Id: string; MessageId: string }[]; Failed: [] } {
    const successful: { Id: string; MessageId: string }[] = [];
    for (const entry of entries) {
      const msgId = this.publish(topicArn, entry.Message, entry.Subject);
      successful.push({ Id: entry.Id, MessageId: msgId });
    }
    return { Successful: successful, Failed: [] };
  }

  confirmSubscription(topicArn: string): string {
    const existing = [...this._subscriptions.values()].find((s) => s.TopicArn === topicArn);
    if (existing !== undefined) return existing.SubscriptionArn;
    return this.subscribe(topicArn, "http", "");
  }

  topicArnFromName(name: string): string {
    return this._topicArn(name);
  }

  private _topicArn(name: string): string {
    return `arn:aws:sns:${FAKE_REGION}:${FAKE_ACCOUNT}:${name}`;
  }
}
