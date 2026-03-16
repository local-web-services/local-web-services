"use strict";
/** SQS wire-protocol Fastify plugin. */
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
exports.SqsStore = void 0;
exports.registerSqs = registerSqs;
const queue_1 = require("./queue");
const chaos_1 = require("../../middleware/chaos");
const fake_1 = require("../../middleware/fake");
const iam_1 = require("../../middleware/iam");
const logging_1 = require("../../middleware/logging");
const qs = __importStar(require("querystring"));
const ACCOUNT_ID = "000000000000";
// SQS XML response builders
function xmlResponse(content) {
    return `<?xml version="1.0"?><${content}`;
}
function sendMessageResponse(msg) {
    return xmlResponse(`SendMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <SendMessageResult>
    <MessageId>${msg.MessageId}</MessageId>
    <MD5OfMessageBody>${msg.MD5OfMessageBody}</MD5OfMessageBody>
  </SendMessageResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</SendMessageResponse>`);
}
function receiveMessageResponse(messages, queueUrl) {
    const msgsXml = messages
        .map((m) => `    <Message>
      <MessageId>${m.messageId}</MessageId>
      <ReceiptHandle>${m.receiptHandle}</ReceiptHandle>
      <MD5OfBody>${md5(m.body)}</MD5OfBody>
      <Body>${escapeXml(m.body)}</Body>
      ${Object.entries(m.attributes)
        .map(([k, v]) => `<Attribute><Name>${k}</Name><Value>${v}</Value></Attribute>`)
        .join("\n      ")}
    </Message>`)
        .join("\n");
    void queueUrl;
    return xmlResponse(`ReceiveMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ReceiveMessageResult>
${msgsXml}
  </ReceiveMessageResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</ReceiveMessageResponse>`);
}
function simpleResponse(action) {
    return xmlResponse(`${action}Response xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</${action}Response>`);
}
function createQueueResponse(url) {
    return xmlResponse(`CreateQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <CreateQueueResult>
    <QueueUrl>${url}</QueueUrl>
  </CreateQueueResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</CreateQueueResponse>`);
}
function getQueueUrlResponse(url) {
    return xmlResponse(`GetQueueUrlResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <GetQueueUrlResult>
    <QueueUrl>${url}</QueueUrl>
  </GetQueueUrlResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</GetQueueUrlResponse>`);
}
function listQueuesResponse(urls) {
    const urlsXml = urls.map((u) => `    <QueueUrl>${u}</QueueUrl>`).join("\n");
    return xmlResponse(`ListQueuesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ListQueuesResult>
${urlsXml}
  </ListQueuesResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</ListQueuesResponse>`);
}
function getQueueAttributesResponse(attrs) {
    const attrsXml = Object.entries(attrs)
        .map(([k, v]) => `    <Attribute><Name>${k}</Name><Value>${v}</Value></Attribute>`)
        .join("\n");
    return xmlResponse(`GetQueueAttributesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <GetQueueAttributesResult>
${attrsXml}
  </GetQueueAttributesResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</GetQueueAttributesResponse>`);
}
function errorXmlResponse(code, message) {
    return xmlResponse(`ErrorResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <Error>
    <Code>${code}</Code>
    <Message>${escapeXml(message)}</Message>
  </Error>
  <RequestId>00000000-0000-0000-0000-000000000000</RequestId>
</ErrorResponse>`);
}
function escapeXml(str) {
    return str
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&apos;");
}
function md5(str) {
    const { createHash } = require("crypto");
    return createHash("md5").update(str).digest("hex");
}
class SqsStore {
    constructor(port) {
        this.queues = new Map();
        this.queueTags = new Map();
        this.port = port;
    }
    reset() {
        this.queues.clear();
        this.queueTags.clear();
    }
    getQueueTags(nameOrUrl) {
        const queue = this.getQueue(nameOrUrl);
        if (!queue)
            return {};
        return this.queueTags.get(queue.name) ?? {};
    }
    setQueueTags(nameOrUrl, tags) {
        const queue = this.getQueue(nameOrUrl);
        if (queue) {
            const existing = this.queueTags.get(queue.name) ?? {};
            this.queueTags.set(queue.name, { ...existing, ...tags });
        }
    }
    removeQueueTags(nameOrUrl, tagKeys) {
        const queue = this.getQueue(nameOrUrl);
        if (queue) {
            const existing = this.queueTags.get(queue.name) ?? {};
            for (const key of tagKeys)
                delete existing[key];
            this.queueTags.set(queue.name, existing);
        }
    }
    queueUrl(name) {
        return `http://127.0.0.1:${this.port}/${ACCOUNT_ID}/${name}`;
    }
    createQueue(name, attributes = {}) {
        const isFifo = attributes["FifoQueue"] === "true" || name.endsWith(".fifo");
        const visTimeout = parseInt(attributes["VisibilityTimeout"] ?? "30", 10);
        const contentBasedDedup = attributes["ContentBasedDeduplication"] === "true";
        const url = this.queueUrl(name);
        const queue = new queue_1.LocalQueue(name, url, {
            isFifo,
            visibilityTimeout: visTimeout,
            contentBasedDedup,
        });
        this.queues.set(name, queue);
        return queue;
    }
    getQueue(nameOrUrl) {
        // Support both queue name and queue URL
        if (nameOrUrl.includes("/")) {
            // URL format: http://host:port/000000000000/QueueName
            const parts = nameOrUrl.split("/");
            const name = parts[parts.length - 1];
            return this.queues.get(name);
        }
        return this.queues.get(nameOrUrl);
    }
    listQueues(prefix) {
        const all = Array.from(this.queues.values());
        if (prefix)
            return all.filter((q) => q.name.startsWith(prefix));
        return all;
    }
    deleteQueue(nameOrUrl) {
        const queue = this.getQueue(nameOrUrl);
        if (queue)
            this.queues.delete(queue.name);
    }
}
exports.SqsStore = SqsStore;
function registerSqs(app, state, port) {
    const store = new SqsStore(port);
    state.resetCallbacks.push(() => store.reset());
    // SQS uses two content types: form-encoded (legacy) and JSON (newer SDK v3)
    app.addContentTypeParser("application/x-www-form-urlencoded", { parseAs: "string" }, (_req, body, done) => {
        done(null, qs.parse(body));
    });
    // Handle path-based routing: POST /{AccountId}/{QueueName}
    // and root POST for action-based dispatch
    app.post("/*", async (req, reply) => {
        const body = req.body;
        const path = req.url;
        // Detect whether the SDK is using JSON protocol (new SDK v3) or form-encoded (legacy)
        const contentType = req.headers["content-type"] ?? "";
        const isJsonProtocol = contentType.includes("application/x-amz-json-1.0") || !!req.headers["x-amz-target"];
        // Determine action
        let action = body.Action ?? "";
        // JSON Content-Type target header pattern: e.g. AmazonSQS.SendMessage
        const amzTarget = req.headers["x-amz-target"];
        if (amzTarget && !action) {
            action = amzTarget.split(".")[1] ?? "";
        }
        // If path contains queue URL pattern, derive action from path + method
        const queueUrlMatch = /^\/\d+\/(.+)$/.exec(path);
        if (queueUrlMatch && !action) {
            // Legacy path-based requests
            action = body.Action ?? "SendMessage";
        }
        const ctx = (0, logging_1.createRequestContext)("sqs", action);
        if (await (0, iam_1.applyIamAuth)(state, "sqs", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, chaos_1.applyChaos)(state, "sqs", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        if (await (0, fake_1.applyFake)(state, "sqs", action, req, reply)) {
            (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
            return;
        }
        try {
            await handleSqsAction(action, body, path, store, reply, isJsonProtocol);
        }
        catch (err) {
            const msg = err instanceof Error ? err.message : String(err);
            if (isJsonProtocol) {
                reply
                    .status(400)
                    .header("Content-Type", "application/x-amz-json-1.0")
                    .send(JSON.stringify({ __type: "AWS.SimpleQueueService.NonExistentQueue", message: msg }));
            }
            else {
                reply
                    .status(400)
                    .header("Content-Type", "text/xml")
                    .send(errorXmlResponse("AWS.SimpleQueueService.NonExistentQueue", msg));
            }
        }
        (0, logging_1.recordLog)(state, ctx, req.method, req.url, reply.statusCode);
    });
    return store;
}
async function handleSqsAction(action, body, path, store, reply, isJsonProtocol = false) {
    const xmlReply = (content, status = 200) => {
        reply.status(status).header("Content-Type", "text/xml").send(content);
    };
    const jsonReply = (data, status = 200) => {
        reply.status(status).header("Content-Type", "application/x-amz-json-1.0").send(data);
    };
    // Send error in the appropriate format
    const errorReply = (code, message, status = 400) => {
        if (isJsonProtocol) {
            jsonReply({ __type: code, message }, status);
        }
        else {
            xmlReply(errorXmlResponse(code, message), status);
        }
    };
    switch (action) {
        case "CreateQueue": {
            const name = body.QueueName;
            const attrs = extractAttributes(body);
            const queue = store.createQueue(name, attrs);
            if (isJsonProtocol) {
                jsonReply({ QueueUrl: queue.url });
            }
            else {
                xmlReply(createQueueResponse(queue.url));
            }
            break;
        }
        case "GetQueueUrl": {
            const name = body.QueueName;
            const url = store.queueUrl(name);
            if (isJsonProtocol) {
                jsonReply({ QueueUrl: url });
            }
            else {
                xmlReply(getQueueUrlResponse(url));
            }
            break;
        }
        case "ListQueues": {
            const prefix = body.QueueNamePrefix;
            const queues = store.listQueues(prefix);
            if (isJsonProtocol) {
                jsonReply({ QueueUrls: queues.map((q) => q.url) });
            }
            else {
                xmlReply(listQueuesResponse(queues.map((q) => q.url)));
            }
            break;
        }
        case "DeleteQueue": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            store.deleteQueue(queueUrl);
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("DeleteQueue"));
            }
            break;
        }
        case "SendMessage": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (!queue) {
                errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
                return;
            }
            const msgBody = body.MessageBody;
            const messageId = queue.sendMessage(msgBody, {
                delaySeconds: parseInt(String(body.DelaySeconds ?? "0"), 10),
                messageGroupId: body.MessageGroupId,
                messageDedupId: body.MessageDeduplicationId,
            });
            if (isJsonProtocol) {
                jsonReply({ MessageId: messageId, MD5OfMessageBody: md5(msgBody) });
            }
            else {
                xmlReply(sendMessageResponse({ MessageId: messageId, MD5OfMessageBody: md5(msgBody) }));
            }
            break;
        }
        case "SendMessageBatch": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (!queue) {
                errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
                return;
            }
            const entries = extractBatchEntries(body, "SendMessageBatchRequestEntry");
            const successEntries = [];
            const successXml = [];
            for (const entry of entries) {
                const messageId = queue.sendMessage(entry.MessageBody ?? "", {
                    delaySeconds: parseInt(String(entry.DelaySeconds ?? "0"), 10),
                });
                const md5Val = md5(entry.MessageBody ?? "");
                successEntries.push({ Id: entry.Id, MessageId: messageId, MD5OfMessageBody: md5Val });
                successXml.push(`<SendMessageBatchResultEntry>
            <Id>${entry.Id}</Id>
            <MessageId>${messageId}</MessageId>
            <MD5OfMessageBody>${md5Val}</MD5OfMessageBody>
          </SendMessageBatchResultEntry>`);
            }
            if (isJsonProtocol) {
                jsonReply({ Successful: successEntries, Failed: [] });
            }
            else {
                xmlReply(xmlResponse(`SendMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <SendMessageBatchResult>
    ${successXml.join("\n    ")}
  </SendMessageBatchResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</SendMessageBatchResponse>`));
            }
            break;
        }
        case "ReceiveMessage": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (!queue) {
                errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
                return;
            }
            const maxMessages = parseInt(String(body.MaxNumberOfMessages ?? "1"), 10);
            const waitTime = parseInt(String(body.WaitTimeSeconds ?? "0"), 10);
            const messages = queue.receiveMessages(maxMessages, waitTime);
            if (isJsonProtocol) {
                jsonReply({
                    Messages: messages.map((m) => ({
                        MessageId: m.messageId,
                        ReceiptHandle: m.receiptHandle,
                        MD5OfBody: md5(m.body),
                        Body: m.body,
                        Attributes: m.attributes,
                    })),
                });
            }
            else {
                xmlReply(receiveMessageResponse(messages, queueUrl));
            }
            break;
        }
        case "DeleteMessage": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (queue) {
                queue.deleteMessage(body.ReceiptHandle);
            }
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("DeleteMessage"));
            }
            break;
        }
        case "DeleteMessageBatch": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            const entries = extractBatchEntries(body, "DeleteMessageBatchRequestEntry");
            const successItems = [];
            const successXml = [];
            for (const entry of entries) {
                if (queue)
                    queue.deleteMessage(entry.ReceiptHandle);
                successItems.push({ Id: entry.Id });
                successXml.push(`<DeleteMessageBatchResultEntry><Id>${entry.Id}</Id></DeleteMessageBatchResultEntry>`);
            }
            if (isJsonProtocol) {
                jsonReply({ Successful: successItems, Failed: [] });
            }
            else {
                xmlReply(xmlResponse(`DeleteMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <DeleteMessageBatchResult>
    ${successXml.join("\n    ")}
  </DeleteMessageBatchResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</DeleteMessageBatchResponse>`));
            }
            break;
        }
        case "PurgeQueue": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (queue)
                queue.purge();
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("PurgeQueue"));
            }
            break;
        }
        case "GetQueueAttributes": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (!queue) {
                errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
                return;
            }
            const attrs = {
                QueueArn: `arn:aws:sqs:us-east-1:${ACCOUNT_ID}:${queue.name}`,
                ApproximateNumberOfMessages: String(queue.approximateMessageCount()),
                ApproximateNumberOfMessagesNotVisible: "0",
                VisibilityTimeout: String(queue.visibilityTimeout),
                CreatedTimestamp: String(Math.floor(Date.now() / 1000)),
                LastModifiedTimestamp: String(Math.floor(Date.now() / 1000)),
                FifoQueue: String(queue.isFifo),
            };
            if (isJsonProtocol) {
                jsonReply({ Attributes: attrs });
            }
            else {
                xmlReply(getQueueAttributesResponse(attrs));
            }
            break;
        }
        case "SetQueueAttributes": {
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("SetQueueAttributes"));
            }
            break;
        }
        case "ChangeMessageVisibility": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            if (queue) {
                queue.changeMessageVisibility(body.ReceiptHandle, parseInt(String(body.VisibilityTimeout ?? "0"), 10));
            }
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("ChangeMessageVisibility"));
            }
            break;
        }
        case "ChangeMessageVisibilityBatch": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const queue = store.getQueue(queueUrl);
            const entries = extractBatchEntries(body, "ChangeMessageVisibilityBatchRequestEntry");
            const successItems = [];
            for (const entry of entries) {
                if (queue) {
                    queue.changeMessageVisibility(entry.ReceiptHandle, parseInt(String(entry.VisibilityTimeout ?? "0"), 10));
                }
                successItems.push({ Id: entry.Id });
            }
            if (isJsonProtocol) {
                jsonReply({ Successful: successItems, Failed: [] });
            }
            else {
                xmlReply(simpleResponse("ChangeMessageVisibilityBatch"));
            }
            break;
        }
        case "ListQueueTags": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const tags = store.getQueueTags(queueUrl);
            if (isJsonProtocol) {
                jsonReply({ Tags: tags });
            }
            else {
                xmlReply(simpleResponse("ListQueueTags"));
            }
            break;
        }
        case "TagQueue": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const tags = body.Tags ?? {};
            store.setQueueTags(queueUrl, tags);
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("TagQueue"));
            }
            break;
        }
        case "UntagQueue": {
            const queueUrl = body.QueueUrl ?? extractQueueUrlFromPath(path);
            const tagKeys = body.TagKeys ?? [];
            store.removeQueueTags(queueUrl, tagKeys);
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse("UntagQueue"));
            }
            break;
        }
        case "ListDeadLetterSourceQueues": {
            if (isJsonProtocol) {
                jsonReply({ queueUrls: [] });
            }
            else {
                xmlReply(simpleResponse("ListDeadLetterSourceQueues"));
            }
            break;
        }
        case "AddPermission":
        case "RemovePermission": {
            if (isJsonProtocol) {
                jsonReply({});
            }
            else {
                xmlReply(simpleResponse(action));
            }
            break;
        }
        default: {
            if (isJsonProtocol) {
                jsonReply({ __type: "InvalidAction", message: `Unknown action: ${action}` }, 400);
            }
            else {
                reply
                    .status(400)
                    .header("Content-Type", "text/xml")
                    .send(errorXmlResponse("InvalidAction", `Unknown action: ${action}`));
            }
        }
    }
}
function extractAttributes(body) {
    const attrs = {};
    // Form-encoded: Attribute.1.Name=... Attribute.1.Value=...
    for (const [key, val] of Object.entries(body)) {
        const match = /^Attribute\.(\d+)\.Name$/.exec(key);
        if (match) {
            const idx = match[1];
            const name = val;
            const value = body[`Attribute.${idx}.Value`];
            if (name && value !== undefined)
                attrs[name] = value;
        }
    }
    // Also handle Attributes map (JSON API)
    if (body.Attributes && typeof body.Attributes === "object") {
        Object.assign(attrs, body.Attributes);
    }
    return attrs;
}
function extractBatchEntries(body, prefix) {
    const entries = [];
    // Form-encoded: SendMessageBatchRequestEntry.1.Id=...
    const indices = new Set();
    for (const key of Object.keys(body)) {
        const match = new RegExp(`^${prefix}\\.(\\d+)\\.Id$`).exec(key);
        if (match)
            indices.add(match[1]);
    }
    for (const idx of Array.from(indices).sort()) {
        const entry = {};
        for (const [key, val] of Object.entries(body)) {
            const match = new RegExp(`^${prefix}\\.${idx}\\.(.+)$`).exec(key);
            if (match)
                entry[match[1]] = val;
        }
        entries.push(entry);
    }
    // JSON API
    if (Array.isArray(body.Entries)) {
        return body.Entries;
    }
    return entries;
}
function extractQueueUrlFromPath(path) {
    // Path: /000000000000/QueueName
    return `http://127.0.0.1${path}`;
}
//# sourceMappingURL=index.js.map