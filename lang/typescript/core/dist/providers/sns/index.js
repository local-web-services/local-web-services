"use strict";
/** SNS wire-protocol Fastify plugin. */
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.SnsStore = void 0;
exports.registerSns = registerSns;
const uuid_1 = require("uuid");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const qs = __importStar(require("querystring"));
const ACCOUNT_ID = "000000000000";
const REGION = "us-east-1";
class SnsStore {
    constructor() {
        this.topics = new Map();
        this.subscriptions = new Map();
    }
    reset() {
        this.topics.clear();
        this.subscriptions.clear();
    }
    createTopic(name, attrs = {}) {
        const arn = `arn:aws:sns:${REGION}:${ACCOUNT_ID}:${name}`;
        const existing = this.topics.get(arn);
        if (existing)
            return existing;
        const topic = { arn, name, attributes: { ...attrs }, subscriptions: [], tags: {} };
        this.topics.set(arn, topic);
        return topic;
    }
    deleteTopic(arn) {
        this.topics.delete(arn);
    }
    getTopic(arn) {
        return this.topics.get(arn);
    }
    listTopics() {
        return Array.from(this.topics.values());
    }
    subscribe(topicArn, protocol, endpoint) {
        const subscriptionArn = `${topicArn}:${(0, uuid_1.v4)()}`;
        const sub = { subscriptionArn, topicArn, protocol, endpoint, attributes: {} };
        this.subscriptions.set(subscriptionArn, sub);
        const topic = this.topics.get(topicArn);
        if (topic)
            topic.subscriptions.push(sub);
        return sub;
    }
    setSubscriptionAttribute(subscriptionArn, name, value) {
        const sub = this.subscriptions.get(subscriptionArn);
        if (sub)
            sub.attributes[name] = value;
    }
    unsubscribe(subscriptionArn) {
        const sub = this.subscriptions.get(subscriptionArn);
        if (sub) {
            const topic = this.topics.get(sub.topicArn);
            if (topic) {
                topic.subscriptions = topic.subscriptions.filter((s) => s.subscriptionArn !== subscriptionArn);
            }
            this.subscriptions.delete(subscriptionArn);
        }
    }
    publish(topicArn, message, subject) {
        void subject; // SNS → SQS fan-out not implemented; just return message ID
        const topic = this.topics.get(topicArn);
        if (!topic)
            throw new Error(`Topic not found: ${topicArn}`);
        return (0, uuid_1.v4)();
    }
    listSubscriptions() {
        return Array.from(this.subscriptions.values());
    }
    listSubscriptionsByTopic(topicArn) {
        return Array.from(this.subscriptions.values()).filter((s) => s.topicArn === topicArn);
    }
    getSubscription(subscriptionArn) {
        return this.subscriptions.get(subscriptionArn);
    }
    setTopicAttributes(topicArn, attributeName, attributeValue) {
        const topic = this.topics.get(topicArn);
        if (topic)
            topic.attributes[attributeName] = attributeValue;
    }
    tagResource(topicArn, tags) {
        const topic = this.topics.get(topicArn);
        if (topic) {
            for (const tag of tags)
                topic.tags[tag.Key] = tag.Value;
        }
    }
    untagResource(topicArn, tagKeys) {
        const topic = this.topics.get(topicArn);
        if (topic) {
            for (const key of tagKeys)
                delete topic.tags[key];
        }
    }
    listTagsForResource(topicArn) {
        const topic = this.topics.get(topicArn);
        if (!topic)
            return [];
        return Object.entries(topic.tags).map(([Key, Value]) => ({ Key, Value }));
    }
}
exports.SnsStore = SnsStore;
function xmlResponse(body, status = 200, reply) {
    reply.status(status).header("Content-Type", "text/xml").send(`<?xml version="1.0"?>${body}`);
}
function registerSns(app, state) {
    const store = new SnsStore();
    state.resetCallbacks.push(() => store.reset());
    app.addContentTypeParser("application/x-www-form-urlencoded", { parseAs: "string" }, (_req, body, done) => {
        done(null, qs.parse(body));
    });
    app.post("/", async (req, reply) => {
        const body = req.body;
        const action = body.Action ?? "";
        const ctx = (0, logging_1.createRequestContext)("sns", action);
        if (await (0, iam_1.applyIamAuth)(state, "sns", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "sns", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "sns", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            handleSnsAction(action, body, store, reply);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            xmlResponse(`<ErrorResponse><Error><Code>InvalidParameter</Code><Message>${msg}</Message></Error></ErrorResponse>`, 400, reply);
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    return store;
}
function handleSnsAction(action, body, store, reply) {
    switch (action) {
        case "CreateTopic": {
            const topic = store.createTopic(body.Name);
            xmlResponse(`<CreateTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <CreateTopicResult><TopicArn>${topic.arn}</TopicArn></CreateTopicResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</CreateTopicResponse>`, 200, reply);
            break;
        }
        case "DeleteTopic": {
            store.deleteTopic(body.TopicArn);
            xmlResponse(`<DeleteTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</DeleteTopicResponse>`, 200, reply);
            break;
        }
        case "ListTopics": {
            const topics = store.listTopics();
            const membersXml = topics
                .map((t) => `<member><TopicArn>${t.arn}</TopicArn></member>`)
                .join("\n");
            xmlResponse(`<ListTopicsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListTopicsResult><Topics>${membersXml}</Topics></ListTopicsResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</ListTopicsResponse>`, 200, reply);
            break;
        }
        case "GetTopicAttributes": {
            const topic = store.getTopic(body.TopicArn);
            const attrs = topic ? { TopicArn: topic.arn, ...topic.attributes } : {};
            const attrsXml = Object.entries(attrs)
                .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
                .join("\n");
            xmlResponse(`<GetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <GetTopicAttributesResult><Attributes>${attrsXml}</Attributes></GetTopicAttributesResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</GetTopicAttributesResponse>`, 200, reply);
            break;
        }
        case "Subscribe": {
            const sub = store.subscribe(body.TopicArn, body.Protocol, body.Endpoint);
            xmlResponse(`<SubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <SubscribeResult><SubscriptionArn>${sub.subscriptionArn}</SubscriptionArn></SubscribeResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</SubscribeResponse>`, 200, reply);
            break;
        }
        case "Unsubscribe": {
            store.unsubscribe(body.SubscriptionArn);
            xmlResponse(`<UnsubscribeResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</UnsubscribeResponse>`, 200, reply);
            break;
        }
        case "Publish": {
            const messageId = store.publish(body.TopicArn, body.Message, body.Subject);
            xmlResponse(`<PublishResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <PublishResult><MessageId>${messageId}</MessageId></PublishResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</PublishResponse>`, 200, reply);
            break;
        }
        case "ListSubscriptions": {
            const subscriptions = store.listSubscriptions();
            const membersXml = subscriptions
                .map((s) => `<member>
  <SubscriptionArn>${s.subscriptionArn}</SubscriptionArn>
  <TopicArn>${s.topicArn}</TopicArn>
  <Protocol>${s.protocol}</Protocol>
  <Endpoint>${s.endpoint ?? ""}</Endpoint>
  <Owner>${ACCOUNT_ID}</Owner>
</member>`)
                .join("\n");
            xmlResponse(`<ListSubscriptionsResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListSubscriptionsResult><Subscriptions>${membersXml}</Subscriptions></ListSubscriptionsResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</ListSubscriptionsResponse>`, 200, reply);
            break;
        }
        case "ListSubscriptionsByTopic": {
            const subscriptions = store.listSubscriptionsByTopic(body.TopicArn);
            const membersXml = subscriptions
                .map((s) => `<member>
  <SubscriptionArn>${s.subscriptionArn}</SubscriptionArn>
  <TopicArn>${s.topicArn}</TopicArn>
  <Protocol>${s.protocol}</Protocol>
  <Endpoint>${s.endpoint ?? ""}</Endpoint>
  <Owner>${ACCOUNT_ID}</Owner>
</member>`)
                .join("\n");
            xmlResponse(`<ListSubscriptionsByTopicResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListSubscriptionsByTopicResult><Subscriptions>${membersXml}</Subscriptions></ListSubscriptionsByTopicResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</ListSubscriptionsByTopicResponse>`, 200, reply);
            break;
        }
        case "GetSubscriptionAttributes": {
            const sub = store.getSubscription(body.SubscriptionArn);
            const baseAttrs = sub ? {
                SubscriptionArn: sub.subscriptionArn,
                TopicArn: sub.topicArn,
                Protocol: sub.protocol,
                Endpoint: sub.endpoint ?? "",
                ...sub.attributes,
            } : {};
            const attrsXml = Object.entries(baseAttrs)
                .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
                .join("\n  ");
            xmlResponse(`<GetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <GetSubscriptionAttributesResult><Attributes>${attrsXml}</Attributes></GetSubscriptionAttributesResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</GetSubscriptionAttributesResponse>`, 200, reply);
            break;
        }
        case "SetSubscriptionAttributes": {
            store.setSubscriptionAttribute(body.SubscriptionArn, body.AttributeName, body.AttributeValue);
            xmlResponse(`<SetSubscriptionAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</SetSubscriptionAttributesResponse>`, 200, reply);
            break;
        }
        case "ConfirmSubscription": {
            // Auto-confirm with a stable subscription ARN
            const topicArn = body.TopicArn;
            const confirmedArn = `${topicArn}:confirmed-${(0, uuid_1.v4)()}`;
            xmlResponse(`<ConfirmSubscriptionResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ConfirmSubscriptionResult><SubscriptionArn>${confirmedArn}</SubscriptionArn></ConfirmSubscriptionResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</ConfirmSubscriptionResponse>`, 200, reply);
            break;
        }
        case "ListTagsForResource": {
            const tags = store.listTagsForResource(body.ResourceArn);
            const tagsXml = tags
                .map((t) => `<member><Key>${t.Key}</Key><Value>${t.Value}</Value></member>`)
                .join("\n");
            xmlResponse(`<ListTagsForResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ListTagsForResourceResult><Tags>${tagsXml}</Tags></ListTagsForResourceResult>
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</ListTagsForResourceResponse>`, 200, reply);
            break;
        }
        case "TagResource": {
            // Form-encoded format: Tags.member.1.Key=..., Tags.member.1.Value=...
            const tags = [];
            if (Array.isArray(body.Tags)) {
                for (const t of body.Tags)
                    tags.push(t);
            }
            else {
                const indices = new Set();
                for (const key of Object.keys(body)) {
                    const match = /^Tags\.member\.(\d+)\.Key$/.exec(key);
                    if (match)
                        indices.add(match[1]);
                }
                for (const idx of Array.from(indices).sort()) {
                    const Key = body[`Tags.member.${idx}.Key`];
                    const Value = body[`Tags.member.${idx}.Value`] ?? "";
                    if (Key)
                        tags.push({ Key, Value });
                }
            }
            store.tagResource(body.ResourceArn, tags);
            xmlResponse(`<TagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</TagResourceResponse>`, 200, reply);
            break;
        }
        case "UntagResource": {
            // Form-encoded format: TagKeys.member.1=...
            const tagKeys = [];
            if (Array.isArray(body.TagKeys)) {
                for (const k of body.TagKeys)
                    tagKeys.push(k);
            }
            else {
                for (const [key, val] of Object.entries(body)) {
                    if (/^TagKeys\.member\.\d+$/.test(key))
                        tagKeys.push(val);
                }
            }
            store.untagResource(body.ResourceArn, tagKeys);
            xmlResponse(`<UntagResourceResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</UntagResourceResponse>`, 200, reply);
            break;
        }
        case "SetTopicAttributes": {
            store.setTopicAttributes(body.TopicArn, body.AttributeName, body.AttributeValue);
            xmlResponse(`<SetTopicAttributesResponse xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</SetTopicAttributesResponse>`, 200, reply);
            break;
        }
        case "AddPermission":
        case "RemovePermission": {
            xmlResponse(`<${action}Response xmlns="http://sns.amazonaws.com/doc/2010-03-31/">
  <ResponseMetadata><RequestId>${(0, uuid_1.v4)()}</RequestId></ResponseMetadata>
</${action}Response>`, 200, reply);
            break;
        }
        default: {
            xmlResponse(`<ErrorResponse><Error><Code>InvalidAction</Code><Message>Unknown action: ${action}</Message></Error></ErrorResponse>`, 400, reply);
        }
    }
}
//# sourceMappingURL=index.js.map