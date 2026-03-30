/** SQS wire-protocol Fastify plugin. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { LocalQueue, type SqsMessage } from "./queue";
import type { ServerState } from "../../types";
import { isExhausted } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import * as qs from "querystring";

const ACCOUNT_ID = "000000000000";

// SQS XML response builders
function xmlResponse(content: string): string {
  return `<?xml version="1.0"?><${content}`;
}

function sendMessageResponse(msg: { MessageId: string; MD5OfMessageBody: string }): string {
  return xmlResponse(
    `SendMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <SendMessageResult>
    <MessageId>${msg.MessageId}</MessageId>
    <MD5OfMessageBody>${msg.MD5OfMessageBody}</MD5OfMessageBody>
  </SendMessageResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</SendMessageResponse>`,
  );
}

function receiveMessageResponse(messages: SqsMessage[], queueUrl: string): string {
  const msgsXml = messages
    .map(
      (m) => `    <Message>
      <MessageId>${m.messageId}</MessageId>
      <ReceiptHandle>${m.receiptHandle}</ReceiptHandle>
      <MD5OfBody>${md5(m.body)}</MD5OfBody>
      <Body>${escapeXml(m.body)}</Body>
      ${Object.entries(m.attributes)
        .map(([k, v]) => `<Attribute><Name>${k}</Name><Value>${v}</Value></Attribute>`)
        .join("\n      ")}
    </Message>`,
    )
    .join("\n");

  void queueUrl;
  return xmlResponse(
    `ReceiveMessageResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ReceiveMessageResult>
${msgsXml}
  </ReceiveMessageResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</ReceiveMessageResponse>`,
  );
}

function simpleResponse(action: string): string {
  return xmlResponse(
    `${action}Response xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</${action}Response>`,
  );
}

function createQueueResponse(url: string): string {
  return xmlResponse(
    `CreateQueueResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <CreateQueueResult>
    <QueueUrl>${url}</QueueUrl>
  </CreateQueueResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</CreateQueueResponse>`,
  );
}

function getQueueUrlResponse(url: string): string {
  return xmlResponse(
    `GetQueueUrlResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <GetQueueUrlResult>
    <QueueUrl>${url}</QueueUrl>
  </GetQueueUrlResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</GetQueueUrlResponse>`,
  );
}

function listQueuesResponse(urls: string[]): string {
  const urlsXml = urls.map((u) => `    <QueueUrl>${u}</QueueUrl>`).join("\n");
  return xmlResponse(
    `ListQueuesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <ListQueuesResult>
${urlsXml}
  </ListQueuesResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</ListQueuesResponse>`,
  );
}

function getQueueAttributesResponse(attrs: Record<string, string>): string {
  const attrsXml = Object.entries(attrs)
    .map(([k, v]) => `    <Attribute><Name>${k}</Name><Value>${v}</Value></Attribute>`)
    .join("\n");
  return xmlResponse(
    `GetQueueAttributesResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <GetQueueAttributesResult>
${attrsXml}
  </GetQueueAttributesResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</GetQueueAttributesResponse>`,
  );
}

function errorXmlResponse(code: string, message: string): string {
  return xmlResponse(
    `ErrorResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <Error>
    <Code>${code}</Code>
    <Message>${escapeXml(message)}</Message>
  </Error>
  <RequestId>00000000-0000-0000-0000-000000000000</RequestId>
</ErrorResponse>`,
  );
}

function escapeXml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

function md5(str: string): string {
  const { createHash } = require("crypto") as typeof import("crypto");
  return createHash("md5").update(str).digest("hex");
}

export class SqsStore {
  private queues: Map<string, LocalQueue> = new Map();
  private queueTags: Map<string, Record<string, string>> = new Map();
  private port: number;

  constructor(port: number) {
    this.port = port;
  }

  reset(): void {
    this.queues.clear();
    this.queueTags.clear();
  }

  getQueueTags(nameOrUrl: string): Record<string, string> {
    const queue = this.getQueue(nameOrUrl);
    if (!queue) return {};
    return this.queueTags.get(queue.name) ?? {};
  }

  setQueueTags(nameOrUrl: string, tags: Record<string, string>): void {
    const queue = this.getQueue(nameOrUrl);
    if (queue) {
      const existing = this.queueTags.get(queue.name) ?? {};
      this.queueTags.set(queue.name, { ...existing, ...tags });
    }
  }

  removeQueueTags(nameOrUrl: string, tagKeys: string[]): void {
    const queue = this.getQueue(nameOrUrl);
    if (queue) {
      const existing = this.queueTags.get(queue.name) ?? {};
      for (const key of tagKeys) delete existing[key];
      this.queueTags.set(queue.name, existing);
    }
  }

  queueUrl(name: string): string {
    return `http://127.0.0.1:${this.port}/${ACCOUNT_ID}/${name}`;
  }

  createQueue(name: string, attributes: Record<string, string> = {}): LocalQueue {
    const isFifo = attributes["FifoQueue"] === "true" || name.endsWith(".fifo");
    const visTimeout = parseInt(attributes["VisibilityTimeout"] ?? "30", 10);
    const contentBasedDedup = attributes["ContentBasedDeduplication"] === "true";

    const url = this.queueUrl(name);
    const queue = new LocalQueue(name, url, {
      isFifo,
      visibilityTimeout: visTimeout,
      contentBasedDedup,
    });

    this.queues.set(name, queue);
    return queue;
  }

  getQueue(nameOrUrl: string): LocalQueue | undefined {
    // Support queue name, queue URL, and queue ARN
    if (nameOrUrl.includes("/")) {
      // URL format: http://host:port/000000000000/QueueName
      const parts = nameOrUrl.split("/");
      const name = parts[parts.length - 1];
      return this.queues.get(name);
    }
    if (nameOrUrl.startsWith("arn:aws:sqs:")) {
      // ARN format: arn:aws:sqs:region:account:QueueName
      const parts = nameOrUrl.split(":");
      const name = parts[parts.length - 1];
      return this.queues.get(name);
    }
    return this.queues.get(nameOrUrl);
  }

  listQueues(prefix?: string): LocalQueue[] {
    const all = Array.from(this.queues.values());
    if (prefix) return all.filter((q) => q.name.startsWith(prefix));
    return all;
  }

  deleteQueue(nameOrUrl: string): void {
    const queue = this.getQueue(nameOrUrl);
    if (queue) this.queues.delete(queue.name);
  }
}

export function registerSqs(app: FastifyInstance, state: ServerState, port: number): SqsStore {
  const store = new SqsStore(port);

  state.resetCallbacks.push(() => store.reset());
  // Register ARN existence checker: arn:aws:sqs:region:account:queuename
  state.arnExistsCheckers.set("sqs", (arn: string) => {
    const parts = arn.split(":");
    const queueName = parts[parts.length - 1];
    return store.getQueue(queueName) !== undefined;
  });

  // SQS uses two content types: form-encoded (legacy) and JSON (newer SDK v3)
  app.addContentTypeParser(
    "application/x-www-form-urlencoded",
    { parseAs: "string" },
    (_req, body, done) => {
      done(null, qs.parse(body as string));
    },
  );

  // Handle path-based routing: POST /{AccountId}/{QueueName}
  // and root POST for action-based dispatch
  app.post("/*", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as Record<string, unknown>;
    const path = req.url;

    // Detect whether the SDK is using JSON protocol (new SDK v3) or form-encoded (legacy)
    const contentType = req.headers["content-type"] ?? "";
    const isJsonProtocol =
      contentType.includes("application/x-amz-json-1.0") || !!req.headers["x-amz-target"];

    // Determine action
    let action = (body.Action as string) ?? "";

    // JSON Content-Type target header pattern: e.g. AmazonSQS.SendMessage
    const amzTarget = req.headers["x-amz-target"] as string | undefined;
    if (amzTarget && !action) {
      action = amzTarget.split(".")[1] ?? "";
    }

    // If path contains queue URL pattern, derive action from path + method
    const queueUrlMatch = /^\/\d+\/(.+)$/.exec(path);
    if (queueUrlMatch && !action) {
      // Legacy path-based requests
      action = (body.Action as string) ?? "SendMessage";
    }

    const ctx = createRequestContext("sqs", action);

    if (await applyIamAuth(state, "sqs", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "sqs", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "sqs", action, req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    // Check message capacity for SendMessage operations
    if (action === "SendMessage" && isExhausted(state.capacityConfigs["sqs"] ?? { slots: null })) {
      if (isJsonProtocol) {
        reply
          .status(429)
          .header("Content-Type", "application/x-amz-json-1.0")
          .send(
            JSON.stringify({
              __type: "OverLimit",
              message: "No message slot available",
            }),
          );
      } else {
        reply
          .status(400)
          .header("Content-Type", "text/xml")
          .send(errorXmlResponse("OverLimit", "No message slot available"));
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    try {
      await handleSqsAction(action, body, path, store, reply, isJsonProtocol);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (isJsonProtocol) {
        reply
          .status(400)
          .header("Content-Type", "application/x-amz-json-1.0")
          .send(
            JSON.stringify({ __type: "AWS.SimpleQueueService.NonExistentQueue", message: msg }),
          );
      } else {
        reply
          .status(400)
          .header("Content-Type", "text/xml")
          .send(errorXmlResponse("AWS.SimpleQueueService.NonExistentQueue", msg));
      }
    }

    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  return store;
}

async function handleSqsAction(
  action: string,
  body: Record<string, unknown>,
  path: string,
  store: SqsStore,
  reply: FastifyReply,
  isJsonProtocol = false,
): Promise<void> {
  const xmlReply = (content: string, status = 200) => {
    reply.status(status).header("Content-Type", "text/xml").send(content);
  };

  const jsonReply = (data: unknown, status = 200) => {
    reply.status(status).header("Content-Type", "application/x-amz-json-1.0").send(data);
  };

  // Send error in the appropriate format
  const errorReply = (code: string, message: string, status = 400) => {
    if (isJsonProtocol) {
      jsonReply({ __type: code, message }, status);
    } else {
      xmlReply(errorXmlResponse(code, message), status);
    }
  };

  switch (action) {
    case "CreateQueue": {
      const name = body.QueueName as string;
      if (store.getQueue(name)) {
        errorReply(
          "QueueAlreadyExists",
          "A queue already exists with the same name and a different value for attribute MessageRetentionPeriod",
        );
        return;
      }
      const attrs = extractAttributes(body);
      const queue = store.createQueue(name, attrs);
      if (isJsonProtocol) {
        jsonReply({ QueueUrl: queue.url });
      } else {
        xmlReply(createQueueResponse(queue.url));
      }
      break;
    }

    case "GetQueueUrl": {
      const name = body.QueueName as string;
      const url = store.queueUrl(name);
      if (isJsonProtocol) {
        jsonReply({ QueueUrl: url });
      } else {
        xmlReply(getQueueUrlResponse(url));
      }
      break;
    }

    case "ListQueues": {
      const prefix = body.QueueNamePrefix as string | undefined;
      const queues = store.listQueues(prefix);
      if (isJsonProtocol) {
        jsonReply({ QueueUrls: queues.map((q) => q.url) });
      } else {
        xmlReply(listQueuesResponse(queues.map((q) => q.url)));
      }
      break;
    }

    case "DeleteQueue": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      if (!store.getQueue(queueUrl)) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", "The queue does not exist.");
        return;
      }
      store.deleteQueue(queueUrl);
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("DeleteQueue"));
      }
      break;
    }

    case "SendMessage": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
        return;
      }
      const msgBody = body.MessageBody as string;
      const messageId = queue.sendMessage(msgBody, {
        delaySeconds: parseInt(String(body.DelaySeconds ?? "0"), 10),
        messageGroupId: body.MessageGroupId as string | undefined,
        messageDedupId: body.MessageDeduplicationId as string | undefined,
      });
      if (isJsonProtocol) {
        jsonReply({ MessageId: messageId, MD5OfMessageBody: md5(msgBody) });
      } else {
        xmlReply(sendMessageResponse({ MessageId: messageId, MD5OfMessageBody: md5(msgBody) }));
      }
      break;
    }

    case "SendMessageBatch": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
        return;
      }

      const entries = extractBatchEntries(body, "SendMessageBatchRequestEntry");
      const successEntries: Array<Record<string, unknown>> = [];
      const successXml: string[] = [];

      for (const entry of entries) {
        const messageId = queue.sendMessage((entry.MessageBody as string) ?? "", {
          delaySeconds: parseInt(String(entry.DelaySeconds ?? "0"), 10),
        });
        const md5Val = md5((entry.MessageBody as string) ?? "");
        successEntries.push({ Id: entry.Id, MessageId: messageId, MD5OfMessageBody: md5Val });
        successXml.push(
          `<SendMessageBatchResultEntry>
            <Id>${entry.Id}</Id>
            <MessageId>${messageId}</MessageId>
            <MD5OfMessageBody>${md5Val}</MD5OfMessageBody>
          </SendMessageBatchResultEntry>`,
        );
      }

      if (isJsonProtocol) {
        jsonReply({ Successful: successEntries, Failed: [] });
      } else {
        xmlReply(
          xmlResponse(
            `SendMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <SendMessageBatchResult>
    ${successXml.join("\n    ")}
  </SendMessageBatchResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</SendMessageBatchResponse>`,
          ),
        );
      }
      break;
    }

    case "ReceiveMessage": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
        return;
      }
      const maxMessages = parseInt(String(body.MaxNumberOfMessages ?? "1"), 10);
      const waitTime = parseInt(String(body.WaitTimeSeconds ?? "0"), 10);
      const messages = queue.receiveMessages(maxMessages, waitTime);
      // Real AWS returns empty Messages array when no messages are available
      // (including when all messages are in-flight) — do not return an error here.
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
      } else {
        xmlReply(receiveMessageResponse(messages, queueUrl));
      }
      break;
    }

    case "DeleteMessage": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", "The queue does not exist.");
        return;
      }
      const receiptHandle = body.ReceiptHandle as string;
      if (!queue.isMessageInFlight(receiptHandle)) {
        errorReply("ReceiptHandleIsInvalid", "The input receipt handle is invalid.");
        return;
      }
      queue.deleteMessage(receiptHandle);
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("DeleteMessage"));
      }
      break;
    }

    case "DeleteMessageBatch": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      const entries = extractBatchEntries(body, "DeleteMessageBatchRequestEntry");
      const successItems: Array<Record<string, unknown>> = [];
      const successXml: string[] = [];

      for (const entry of entries) {
        if (queue) queue.deleteMessage(entry.ReceiptHandle as string);
        successItems.push({ Id: entry.Id });
        successXml.push(
          `<DeleteMessageBatchResultEntry><Id>${entry.Id}</Id></DeleteMessageBatchResultEntry>`,
        );
      }

      if (isJsonProtocol) {
        jsonReply({ Successful: successItems, Failed: [] });
      } else {
        xmlReply(
          xmlResponse(
            `DeleteMessageBatchResponse xmlns="http://queue.amazonaws.com/doc/2012-11-05/">
  <DeleteMessageBatchResult>
    ${successXml.join("\n    ")}
  </DeleteMessageBatchResult>
  <ResponseMetadata><RequestId>00000000-0000-0000-0000-000000000000</RequestId></ResponseMetadata>
</DeleteMessageBatchResponse>`,
          ),
        );
      }
      break;
    }

    case "PurgeQueue": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", "The queue does not exist.");
        return;
      }
      queue.purge();
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("PurgeQueue"));
      }
      break;
    }

    case "GetQueueAttributes": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", `Queue ${queueUrl} not found`);
        return;
      }
      const attrs: Record<string, string> = {
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
      } else {
        xmlReply(getQueueAttributesResponse(attrs));
      }
      break;
    }

    case "SetQueueAttributes": {
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("SetQueueAttributes"));
      }
      break;
    }

    case "ChangeMessageVisibility": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      if (!queue) {
        errorReply("AWS.SimpleQueueService.NonExistentQueue", "The queue does not exist.");
        return;
      }
      const receiptHandle = body.ReceiptHandle as string;
      if (!queue.isMessageInFlight(receiptHandle)) {
        errorReply("ReceiptHandleIsInvalid", "The input receipt handle is invalid.");
        return;
      }
      queue.changeMessageVisibility(
        receiptHandle,
        parseInt(String(body.VisibilityTimeout ?? "0"), 10),
      );
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("ChangeMessageVisibility"));
      }
      break;
    }

    case "ChangeMessageVisibilityBatch": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const queue = store.getQueue(queueUrl);
      const entries = extractBatchEntries(body, "ChangeMessageVisibilityBatchRequestEntry");
      const successItems: Array<Record<string, unknown>> = [];
      for (const entry of entries) {
        if (queue) {
          queue.changeMessageVisibility(
            entry.ReceiptHandle as string,
            parseInt(String(entry.VisibilityTimeout ?? "0"), 10),
          );
        }
        successItems.push({ Id: entry.Id });
      }
      if (isJsonProtocol) {
        jsonReply({ Successful: successItems, Failed: [] });
      } else {
        xmlReply(simpleResponse("ChangeMessageVisibilityBatch"));
      }
      break;
    }

    case "ListQueueTags": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const tags = store.getQueueTags(queueUrl);
      if (isJsonProtocol) {
        jsonReply({ Tags: tags });
      } else {
        xmlReply(simpleResponse("ListQueueTags"));
      }
      break;
    }

    case "TagQueue": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const tags = (body.Tags as Record<string, string>) ?? {};
      store.setQueueTags(queueUrl, tags);
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("TagQueue"));
      }
      break;
    }

    case "UntagQueue": {
      const queueUrl = (body.QueueUrl as string) ?? extractQueueUrlFromPath(path);
      const tagKeys = (body.TagKeys as string[]) ?? [];
      store.removeQueueTags(queueUrl, tagKeys);
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse("UntagQueue"));
      }
      break;
    }

    case "ListDeadLetterSourceQueues": {
      if (isJsonProtocol) {
        jsonReply({ queueUrls: [] });
      } else {
        xmlReply(simpleResponse("ListDeadLetterSourceQueues"));
      }
      break;
    }

    case "AddPermission":
    case "RemovePermission": {
      if (isJsonProtocol) {
        jsonReply({});
      } else {
        xmlReply(simpleResponse(action));
      }
      break;
    }

    default: {
      if (isJsonProtocol) {
        jsonReply({ __type: "InvalidAction", message: `Unknown action: ${action}` }, 400);
      } else {
        reply
          .status(400)
          .header("Content-Type", "text/xml")
          .send(errorXmlResponse("InvalidAction", `Unknown action: ${action}`));
      }
    }
  }
}

function extractAttributes(body: Record<string, unknown>): Record<string, string> {
  const attrs: Record<string, string> = {};
  // Form-encoded: Attribute.1.Name=... Attribute.1.Value=...
  for (const [key, val] of Object.entries(body)) {
    const match = /^Attribute\.(\d+)\.Name$/.exec(key);
    if (match) {
      const idx = match[1];
      const name = val as string;
      const value = body[`Attribute.${idx}.Value`] as string;
      if (name && value !== undefined) attrs[name] = value;
    }
  }
  // Also handle Attributes map (JSON API)
  if (body.Attributes && typeof body.Attributes === "object") {
    Object.assign(attrs, body.Attributes);
  }
  return attrs;
}

function extractBatchEntries(
  body: Record<string, unknown>,
  prefix: string,
): Array<Record<string, unknown>> {
  const entries: Array<Record<string, unknown>> = [];
  // Form-encoded: SendMessageBatchRequestEntry.1.Id=...
  const indices = new Set<string>();
  for (const key of Object.keys(body)) {
    const match = new RegExp(`^${prefix}\\.(\\d+)\\.Id$`).exec(key);
    if (match) indices.add(match[1]);
  }
  for (const idx of Array.from(indices).sort()) {
    const entry: Record<string, unknown> = {};
    for (const [key, val] of Object.entries(body)) {
      const match = new RegExp(`^${prefix}\\.${idx}\\.(.+)$`).exec(key);
      if (match) entry[match[1]] = val;
    }
    entries.push(entry);
  }
  // JSON API
  if (Array.isArray(body.Entries)) {
    return body.Entries as Array<Record<string, unknown>>;
  }
  return entries;
}

function extractQueueUrlFromPath(path: string): string {
  // Path: /000000000000/QueueName
  return `http://127.0.0.1${path}`;
}
