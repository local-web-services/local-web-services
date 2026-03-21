/** SNS wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import * as qs from "querystring";
import type { SqsStore } from "../sqs";

const ACCOUNT_ID = "000000000000";
const REGION = "us-east-1";

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

export class SnsStore {
  private topics: Map<string, Topic> = new Map();
  private subscriptions: Map<string, Subscription> = new Map();
  private sqsStore: SqsStore | null = null;

  setSqsStore(sqsStore: SqsStore): void {
    this.sqsStore = sqsStore;
  }

  reset(): void {
    this.topics.clear();
    this.subscriptions.clear();
  }

  createTopic(name: string, attrs: Record<string, string> = {}): Topic | null {
    const arn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${name}`;
    const existing = this.topics.get(arn);
    if (existing) return null;
    const topic: Topic = { arn, name, attributes: { ...attrs }, subscriptions: [], tags: {} };
    this.topics.set(arn, topic);
    return topic;
  }

  deleteTopic(arn: string): void {
    this.topics.delete(arn);
  }

  getTopic(arn: string): Topic | undefined {
    return this.topics.get(arn);
  }

  listTopics(): Topic[] {
    return Array.from(this.topics.values());
  }

  subscribe(topicArn: string, protocol: string, endpoint: string): Subscription {
    const subscriptionArn = `${topicArn}:${uuidv4()}`;
    const sub: Subscription = { subscriptionArn, topicArn, protocol, endpoint, attributes: {} };
    this.subscriptions.set(subscriptionArn, sub);
    const topic = this.topics.get(topicArn);
    if (topic) topic.subscriptions.push(sub);
    return sub;
  }

  setSubscriptionAttribute(subscriptionArn: string, name: string, value: string): void {
    const sub = this.subscriptions.get(subscriptionArn);
    if (sub) sub.attributes[name] = value;
  }

  unsubscribe(subscriptionArn: string): void {
    const sub = this.subscriptions.get(subscriptionArn);
    if (sub) {
      const topic = this.topics.get(sub.topicArn);
      if (topic) {
        topic.subscriptions = topic.subscriptions.filter(
          (s) => s.subscriptionArn !== subscriptionArn,
        );
      }
      this.subscriptions.delete(subscriptionArn);
    }
  }

  publish(topicArn: string, message: string, subject?: string): string {
    void subject;
    const topic = this.topics.get(topicArn);
    if (!topic) throw new Error(`Topic not found: ${topicArn}`);
    const messageId = uuidv4();
    if (this.sqsStore) {
      const envelope = JSON.stringify({
        Type: "Notification",
        MessageId: messageId,
        TopicArn: topicArn,
        Message: message,
        MessageAttributes: {},
      });
      for (const sub of topic.subscriptions) {
        if (sub.protocol === "sqs") {
          const queue = this.sqsStore.getQueue(sub.endpoint);
          if (queue) {
            queue.sendMessage(envelope);
          }
        }
      }
    }
    return messageId;
  }

  listSubscriptions(): Subscription[] {
    return Array.from(this.subscriptions.values());
  }

  listSubscriptionsByTopic(topicArn: string): Subscription[] {
    return Array.from(this.subscriptions.values()).filter((s) => s.topicArn === topicArn);
  }

  getSubscription(subscriptionArn: string): Subscription | undefined {
    return this.subscriptions.get(subscriptionArn);
  }

  setTopicAttributes(topicArn: string, attributeName: string, attributeValue: string): void {
    const topic = this.topics.get(topicArn);
    if (topic) topic.attributes[attributeName] = attributeValue;
  }

  tagResource(topicArn: string, tags: Array<{ Key: string; Value: string }>): void {
    const topic = this.topics.get(topicArn);
    if (topic) {
      for (const tag of tags) topic.tags[tag.Key] = tag.Value;
    }
  }

  untagResource(topicArn: string, tagKeys: string[]): void {
    const topic = this.topics.get(topicArn);
    if (topic) {
      for (const key of tagKeys) delete topic.tags[key];
    }
  }

  listTagsForResource(topicArn: string): Array<{ Key: string; Value: string }> {
    const topic = this.topics.get(topicArn);
    if (!topic) return [];
    return Object.entries(topic.tags).map(([Key, Value]) => ({ Key, Value }));
  }
}

function xmlResponse(body: string, status = 200, reply: FastifyReply): void {
  reply.status(status).header("Content-Type", "text/xml").send(`<?xml version="1.0"?>${body}`);
}

export function registerSns(app: FastifyInstance, state: ServerState): SnsStore {
  const store = new SnsStore();
  state.resetCallbacks.push(() => store.reset());
  state.arnExistsCheckers.set("sns", (arn: string) => store.getTopic(arn) !== undefined);

  app.addContentTypeParser(
    "application/x-www-form-urlencoded",
    { parseAs: "string" },
    (_req, body, done) => {
      done(null, qs.parse(body as string));
    },
  );

  app.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as Record<string, unknown>;
    const action = (body.Action as string) ?? "";
    const ctx = createRequestContext("sns", action);

    if (await applyIamAuth(state, "sns", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "sns", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "sns", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      handleSnsAction(action, body, store, reply);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      xmlResponse(
        `<ErrorResponse><Error><Code>InvalidParameter</Code><Message>${msg}</Message></Error></ErrorResponse>`,
        400,
        reply,
      );
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

function handleSnsAction(
  action: string,
  body: Record<string, unknown>,
  store: SnsStore,
  reply: FastifyReply,
): void {
  switch (action) {
    case "CreateTopic": {
      const topicName = body.Name as string;
      const topic = store.createTopic(topicName);
      if (topic === null) {
        xmlResponse(
          `<ErrorResponse><Error><Code>TopicLimitExceeded</Code><Message>Topic already exists with different attributes</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      xmlResponse(
        `<CreateTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <CreateTopicResult><TopicArn>${topic.arn}</TopicArn></CreateTopicResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</CreateTopicResponse>`,
        200,
        reply,
      );
      break;
    }

    case "DeleteTopic": {
      const topicArnToDelete = body.TopicArn as string;
      if (!store.getTopic(topicArnToDelete)) {
        xmlResponse(
          `<ErrorResponse><Error><Code>NotFound</Code><Message>Topic does not exist</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      store.deleteTopic(topicArnToDelete);
      xmlResponse(
        `<DeleteTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</DeleteTopicResponse>`,
        200,
        reply,
      );
      break;
    }

    case "ListTopics": {
      const topics = store.listTopics();
      const membersXml = topics
        .map((t) => `<member><TopicArn>${t.arn}</TopicArn></member>`)
        .join("\n");
      xmlResponse(
        `<ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListTopicsResult><Topics>${membersXml}</Topics></ListTopicsResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</ListTopicsResponse>`,
        200,
        reply,
      );
      break;
    }

    case "GetTopicAttributes": {
      const topic = store.getTopic(body.TopicArn as string);
      const attrs = topic ? { TopicArn: topic.arn, ...topic.attributes } : {};
      const attrsXml = Object.entries(attrs)
        .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
        .join("\n");
      xmlResponse(
        `<GetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <GetTopicAttributesResult><Attributes>${attrsXml}</Attributes></GetTopicAttributesResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</GetTopicAttributesResponse>`,
        200,
        reply,
      );
      break;
    }

    case "Subscribe": {
      const topicArnToSubscribe = body.TopicArn as string;
      if (!store.getTopic(topicArnToSubscribe)) {
        xmlResponse(
          `<ErrorResponse><Error><Code>NotFound</Code><Message>Topic does not exist</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      const sub = store.subscribe(
        topicArnToSubscribe,
        body.Protocol as string,
        body.Endpoint as string,
      );
      xmlResponse(
        `<SubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <SubscribeResult><SubscriptionArn>${sub.subscriptionArn}</SubscriptionArn></SubscribeResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</SubscribeResponse>`,
        200,
        reply,
      );
      break;
    }

    case "Unsubscribe": {
      if (!store.getSubscription(body.SubscriptionArn as string)) {
        xmlResponse(
          `<ErrorResponse><Error><Code>NotFound</Code><Message>Subscription does not exist</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      store.unsubscribe(body.SubscriptionArn as string);
      xmlResponse(
        `<UnsubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</UnsubscribeResponse>`,
        200,
        reply,
      );
      break;
    }

    case "Publish": {
      const topicArnToPublish = body.TopicArn as string;
      if (!store.getTopic(topicArnToPublish)) {
        xmlResponse(
          `<ErrorResponse><Error><Code>NotFound</Code><Message>Topic does not exist</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      const confirmedSubs = store.listSubscriptionsByTopic(topicArnToPublish);
      if (confirmedSubs.length === 0) {
        xmlResponse(
          `<ErrorResponse><Error><Code>KMSAccessDenied</Code><Message>No confirmed subscriptions exist for the topic</Message></Error></ErrorResponse>`,
          400,
          reply,
        );
        return;
      }
      const messageId = store.publish(
        topicArnToPublish,
        body.Message as string,
        body.Subject as string | undefined,
      );
      xmlResponse(
        `<PublishResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <PublishResult><MessageId>${messageId}</MessageId></PublishResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</PublishResponse>`,
        200,
        reply,
      );
      break;
    }

    case "ListSubscriptions": {
      const subscriptions = store.listSubscriptions();
      const membersXml = subscriptions
        .map(
          (s) => `<member>
  <SubscriptionArn>${s.subscriptionArn}</SubscriptionArn>
  <TopicArn>${s.topicArn}</TopicArn>
  <Protocol>${s.protocol}</Protocol>
  <Endpoint>${s.endpoint ?? ""}</Endpoint>
  <Owner>${ACCOUNT_ID}</Owner>
</member>`,
        )
        .join("\n");
      xmlResponse(
        `<ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListSubscriptionsResult><Subscriptions>${membersXml}</Subscriptions></ListSubscriptionsResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</ListSubscriptionsResponse>`,
        200,
        reply,
      );
      break;
    }

    case "ListSubscriptionsByTopic": {
      const subscriptions = store.listSubscriptionsByTopic(body.TopicArn as string);
      const membersXml = subscriptions
        .map(
          (s) => `<member>
  <SubscriptionArn>${s.subscriptionArn}</SubscriptionArn>
  <TopicArn>${s.topicArn}</TopicArn>
  <Protocol>${s.protocol}</Protocol>
  <Endpoint>${s.endpoint ?? ""}</Endpoint>
  <Owner>${ACCOUNT_ID}</Owner>
</member>`,
        )
        .join("\n");
      xmlResponse(
        `<ListSubscriptionsByTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListSubscriptionsByTopicResult><Subscriptions>${membersXml}</Subscriptions></ListSubscriptionsByTopicResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</ListSubscriptionsByTopicResponse>`,
        200,
        reply,
      );
      break;
    }

    case "GetSubscriptionAttributes": {
      const sub = store.getSubscription(body.SubscriptionArn as string);
      const baseAttrs: Record<string, string> = sub
        ? {
            SubscriptionArn: sub.subscriptionArn,
            TopicArn: sub.topicArn,
            Protocol: sub.protocol,
            Endpoint: sub.endpoint ?? "",
            ...sub.attributes,
          }
        : {};
      const attrsXml = Object.entries(baseAttrs)
        .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
        .join("\n  ");
      xmlResponse(
        `<GetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <GetSubscriptionAttributesResult><Attributes>${attrsXml}</Attributes></GetSubscriptionAttributesResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</GetSubscriptionAttributesResponse>`,
        200,
        reply,
      );
      break;
    }

    case "SetSubscriptionAttributes": {
      store.setSubscriptionAttribute(
        body.SubscriptionArn as string,
        body.AttributeName as string,
        body.AttributeValue as string,
      );
      xmlResponse(
        `<SetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</SetSubscriptionAttributesResponse>`,
        200,
        reply,
      );
      break;
    }

    case "ConfirmSubscription": {
      // Auto-confirm with a stable subscription ARN
      const topicArn = body.TopicArn as string;
      const confirmedArn = `${topicArn}:confirmed-${uuidv4()}`;
      xmlResponse(
        `<ConfirmSubscriptionResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ConfirmSubscriptionResult><SubscriptionArn>${confirmedArn}</SubscriptionArn></ConfirmSubscriptionResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</ConfirmSubscriptionResponse>`,
        200,
        reply,
      );
      break;
    }

    case "ListTagsForResource": {
      const tags = store.listTagsForResource(body.ResourceArn as string);
      const tagsXml = tags
        .map((t) => `<member><Key>${t.Key}</Key><Value>${t.Value}</Value></member>`)
        .join("\n");
      xmlResponse(
        `<ListTagsForResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListTagsForResourceResult><Tags>${tagsXml}</Tags></ListTagsForResourceResult>
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</ListTagsForResourceResponse>`,
        200,
        reply,
      );
      break;
    }

    case "TagResource": {
      // Form-encoded format: Tags.member.1.Key=..., Tags.member.1.Value=...
      const tags: Array<{ Key: string; Value: string }> = [];
      if (Array.isArray(body.Tags)) {
        for (const t of body.Tags as Array<{ Key: string; Value: string }>) tags.push(t);
      } else {
        const indices = new Set<string>();
        for (const key of Object.keys(body)) {
          const match = /^Tags\.member\.(\d+)\.Key$/.exec(key);
          if (match) indices.add(match[1]);
        }
        for (const idx of Array.from(indices).sort()) {
          const Key = body[`Tags.member.${idx}.Key`] as string;
          const Value = (body[`Tags.member.${idx}.Value`] as string) ?? "";
          if (Key) tags.push({ Key, Value });
        }
      }
      store.tagResource(body.ResourceArn as string, tags);
      xmlResponse(
        `<TagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</TagResourceResponse>`,
        200,
        reply,
      );
      break;
    }

    case "UntagResource": {
      // Form-encoded format: TagKeys.member.1=...
      const tagKeys: string[] = [];
      if (Array.isArray(body.TagKeys)) {
        for (const k of body.TagKeys as string[]) tagKeys.push(k);
      } else {
        for (const [key, val] of Object.entries(body)) {
          if (/^TagKeys\.member\.\d+$/.test(key)) tagKeys.push(val as string);
        }
      }
      store.untagResource(body.ResourceArn as string, tagKeys);
      xmlResponse(
        `<UntagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</UntagResourceResponse>`,
        200,
        reply,
      );
      break;
    }

    case "SetTopicAttributes": {
      store.setTopicAttributes(
        body.TopicArn as string,
        body.AttributeName as string,
        body.AttributeValue as string,
      );
      xmlResponse(
        `<SetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</SetTopicAttributesResponse>`,
        200,
        reply,
      );
      break;
    }

    case "AddPermission":
    case "RemovePermission": {
      xmlResponse(
        `<${action}Response xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${uuidv4()}</RequestId></ResponseMetadata>
</${action}Response>`,
        200,
        reply,
      );
      break;
    }

    default: {
      xmlResponse(
        `<ErrorResponse><Error><Code>InvalidAction</Code><Message>Unknown action: ${action}</Message></Error></ErrorResponse>`,
        400,
        reply,
      );
    }
  }
}
