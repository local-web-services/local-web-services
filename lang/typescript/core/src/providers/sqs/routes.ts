/**
 * SQS wire-protocol Fastify plugin.
 *
 * Handles both protocols that the AWS SDK can use:
 *   - JSON 1.0  (`X-Amz-Target: AmazonSQS.<Action>`)
 *   - Query/XML  (form-encoded body, `Action=<Action>`)
 *
 * Mirrors `providers/sqs/routes.py`.
 */

import formbody from "@fastify/formbody";
import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { AwsChaosConfig } from "../../providers/_shared/chaos.js";
import { chaosPreHandler } from "../../providers/_shared/chaos.js";
import { makeLoggingHooks } from "../../providers/_shared/logging.js";
import type { ProviderContext } from "../../providers/_shared/providerContext.js";
import { LocalQueue } from "./queue.js";
import type { SqsProvider } from "./provider.js";

const FAKE_ACCOUNT = "000000000000";
const REQUEST_ID = "00000000-0000-0000-0000-000000000000";

// ------------------------------------------------------------------
// XML helpers
// ------------------------------------------------------------------

function errorXml(code: string, message: string): string {
  return (
    `<ErrorResponse><Error>` +
    `<Type>Sender</Type><Code>${code}</Code><Message>${message}</Message>` +
    `</Error><RequestId>${REQUEST_ID}</RequestId></ErrorResponse>`
  );
}

function queueUrl(port: number, queueName: string): string {
  return `http://localhost:${port}/${FAKE_ACCOUNT}/${queueName}`;
}

function extractQueueNameFromUrl(url: string): string {
  return url.split("/").pop() ?? "";
}

// ------------------------------------------------------------------
// JSON helpers
// ------------------------------------------------------------------

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

// ------------------------------------------------------------------
// Fastify plugin
// ------------------------------------------------------------------

export interface SqsRoutesOptions {
  provider: SqsProvider;
  port: number;
  chaos?: AwsChaosConfig;
  context?: ProviderContext;
}

export async function sqsRoutesPlugin(
  fastify: FastifyInstance,
  opts: SqsRoutesOptions,
): Promise<void> {
  const { provider, port } = opts;

  // Register form-body parser for the query/XML protocol
  await fastify.register(formbody);

  // --- Logging hooks ---
  const { onRequest, onResponse } = makeLoggingHooks("sqs");
  fastify.addHook("onRequest", onRequest);
  fastify.addHook("onResponse", onResponse);

  // --- Chaos hook (runs after logging, before route) ---
  if (opts.chaos !== undefined) {
    fastify.addHook("preHandler", chaosPreHandler(opts.chaos, "xml_iam"));
  }

  // --- Single catch-all route ---
  fastify.all("/", dispatch);
  fastify.all("/*", dispatch);

  async function dispatch(request: FastifyRequest, reply: FastifyReply): Promise<void> {
    // JSON 1.0 protocol
    const target = (request.headers as Record<string, string>)["x-amz-target"] ?? "";
    if (target.startsWith("AmazonSQS.")) {
      const action = target.slice("AmazonSQS.".length);
      await handleJsonAction(action, request.body as Record<string, unknown>, port, provider, reply);
      return;
    }

    // Query / XML protocol
    const params =
      (request.body as Record<string, string>) ??
      Object.fromEntries(new URLSearchParams(request.url.split("?")[1] ?? "").entries());
    const action = (params["Action"] as string | undefined) ?? "";
    await handleXmlAction(action, params, port, provider, reply);
  }
}

// ------------------------------------------------------------------
// JSON protocol handlers
// ------------------------------------------------------------------

async function handleJsonAction(
  action: string,
  body: Record<string, unknown>,
  port: number,
  provider: SqsProvider,
  reply: { code: (n: number) => { type: (t: string) => { send: (b: string) => void } } },
): Promise<void> {
  try {
    switch (action) {
      case "CreateQueue": {
        const queueName = body["QueueName"] as string;
        const attrs = (body["Attributes"] as Record<string, string> | undefined) ?? {};
        const url = await provider.createQueue(queueName, attrs);
        reply.code(200).type("application/json").send(JSON.stringify({ QueueUrl: url }));
        break;
      }
      case "DeleteQueue": {
        const url = body["QueueUrl"] as string;
        await provider.deleteQueue(extractQueueNameFromUrl(url));
        reply.code(200).type("application/json").send("{}");
        break;
      }
      case "GetQueueUrl": {
        const name = body["QueueName"] as string;
        if (!provider.queues.has(name)) {
          reply
            .code(400)
            .type("application/json")
            .send(jsonError("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        reply
          .code(200)
          .type("application/json")
          .send(JSON.stringify({ QueueUrl: queueUrl(port, name) }));
        break;
      }
      case "SendMessage": {
        const url = body["QueueUrl"] as string;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue === undefined) {
          reply
            .code(400)
            .type("application/json")
            .send(jsonError("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        const msgId = await queue.sendMessage(
          body["MessageBody"] as string,
          (body["MessageAttributes"] as Record<string, unknown> | undefined) as never,
          (body["DelaySeconds"] as number | undefined) ?? 0,
        );
        reply
          .code(200)
          .type("application/json")
          .send(
            JSON.stringify({ MessageId: msgId, MD5OfMessageBody: LocalQueue.md5OfBody(body["MessageBody"] as string) }),
          );
        break;
      }
      case "ReceiveMessage": {
        const url = body["QueueUrl"] as string;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue === undefined) {
          reply
            .code(400)
            .type("application/json")
            .send(jsonError("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        const maxMessages = (body["MaxNumberOfMessages"] as number | undefined) ?? 1;
        const waitSeconds = (body["WaitTimeSeconds"] as number | undefined) ?? 0;
        const msgs = await queue.receiveMessages(maxMessages, waitSeconds);
        const shaped = msgs.map((m) => ({
          MessageId: m.messageId,
          ReceiptHandle: m.receiptHandle,
          Body: m.body,
          MD5OfBody: LocalQueue.md5OfBody(m.body),
          Attributes: {
            ApproximateReceiveCount: String(m.receiveCount),
            SentTimestamp: String(m.sentTimestamp),
          },
          MessageAttributes: m.messageAttributes,
        }));
        reply.code(200).type("application/json").send(JSON.stringify({ Messages: shaped }));
        break;
      }
      case "DeleteMessage": {
        const url = body["QueueUrl"] as string;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue !== undefined) {
          await queue.deleteMessage(body["ReceiptHandle"] as string);
        }
        reply.code(200).type("application/json").send("{}");
        break;
      }
      case "ListQueues": {
        const names = await provider.listQueues();
        const urls = names.map((n) => queueUrl(port, n));
        reply.code(200).type("application/json").send(JSON.stringify({ QueueUrls: urls }));
        break;
      }
      case "GetQueueAttributes": {
        const url = body["QueueUrl"] as string;
        const name = extractQueueNameFromUrl(url);
        const attrs = await provider.getQueueAttributes(name);
        reply.code(200).type("application/json").send(JSON.stringify({ Attributes: attrs }));
        break;
      }
      case "PurgeQueue": {
        const url = body["QueueUrl"] as string;
        await provider.purgeQueue(extractQueueNameFromUrl(url));
        reply.code(200).type("application/json").send("{}");
        break;
      }
      default:
        reply
          .code(400)
          .type("application/json")
          .send(
            jsonError(
              "UnknownOperationException",
              `lws: SQS operation '${action}' is not yet implemented`,
            ),
          );
    }
  } catch (err) {
    reply
      .code(400)
      .type("application/json")
      .send(jsonError("InternalError", String(err)));
  }
}

// ------------------------------------------------------------------
// XML / Query protocol handlers
// ------------------------------------------------------------------

async function handleXmlAction(
  action: string,
  params: Record<string, string>,
  port: number,
  provider: SqsProvider,
  reply: { code: (n: number) => { type: (t: string) => { send: (b: string) => void } } },
): Promise<void> {
  try {
    switch (action) {
      case "CreateQueue": {
        const name = params["QueueName"]!;
        await provider.createQueue(name, params);
        const url = queueUrl(port, name);
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<CreateQueueResponse><CreateQueueResult><QueueUrl>${url}</QueueUrl></CreateQueueResult>` +
            `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></CreateQueueResponse>`,
          );
        break;
      }
      case "DeleteQueue": {
        const url = params["QueueUrl"]!;
        await provider.deleteQueue(extractQueueNameFromUrl(url));
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<DeleteQueueResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></DeleteQueueResponse>`,
          );
        break;
      }
      case "GetQueueUrl": {
        const name = params["QueueName"]!;
        if (!provider.queues.has(name)) {
          reply
            .code(400)
            .type("text/xml")
            .send(errorXml("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        const url = queueUrl(port, name);
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<GetQueueUrlResponse><GetQueueUrlResult><QueueUrl>${url}</QueueUrl></GetQueueUrlResult>` +
            `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></GetQueueUrlResponse>`,
          );
        break;
      }
      case "SendMessage": {
        const url = params["QueueUrl"]!;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue === undefined) {
          reply
            .code(400)
            .type("text/xml")
            .send(errorXml("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        const body = params["MessageBody"]!;
        const msgId = await queue.sendMessage(body, {}, parseInt(params["DelaySeconds"] ?? "0", 10));
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<SendMessageResponse><SendMessageResult>` +
            `<MD5OfMessageBody>${LocalQueue.md5OfBody(body)}</MD5OfMessageBody>` +
            `<MessageId>${msgId}</MessageId>` +
            `</SendMessageResult><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></SendMessageResponse>`,
          );
        break;
      }
      case "ReceiveMessage": {
        const url = params["QueueUrl"]!;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue === undefined) {
          reply
            .code(400)
            .type("text/xml")
            .send(errorXml("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return;
        }
        const maxMessages = parseInt(params["MaxNumberOfMessages"] ?? "1", 10);
        const waitSeconds = parseInt(params["WaitTimeSeconds"] ?? "0", 10);
        const msgs = await queue.receiveMessages(maxMessages, waitSeconds);
        const msgXml = msgs
          .map(
            (m) =>
              `<Message><MessageId>${m.messageId}</MessageId>` +
              `<ReceiptHandle>${m.receiptHandle}</ReceiptHandle>` +
              `<MD5OfBody>${LocalQueue.md5OfBody(m.body)}</MD5OfBody>` +
              `<Body>${m.body}</Body>` +
              `<Attribute><Name>ApproximateReceiveCount</Name><Value>${m.receiveCount}</Value></Attribute>` +
              `</Message>`,
          )
          .join("");
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<ReceiveMessageResponse><ReceiveMessageResult>${msgXml}</ReceiveMessageResult>` +
            `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></ReceiveMessageResponse>`,
          );
        break;
      }
      case "DeleteMessage": {
        const url = params["QueueUrl"]!;
        const name = extractQueueNameFromUrl(url);
        const queue = provider.getQueue(name);
        if (queue !== undefined) await queue.deleteMessage(params["ReceiptHandle"]!);
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<DeleteMessageResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></DeleteMessageResponse>`,
          );
        break;
      }
      case "ListQueues": {
        const names = await provider.listQueues();
        const urlsXml = names.map((n) => `<QueueUrl>${queueUrl(port, n)}</QueueUrl>`).join("");
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<ListQueuesResponse><ListQueuesResult>${urlsXml}</ListQueuesResult>` +
            `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></ListQueuesResponse>`,
          );
        break;
      }
      case "PurgeQueue": {
        const url = params["QueueUrl"]!;
        await provider.purgeQueue(extractQueueNameFromUrl(url));
        reply
          .code(200)
          .type("text/xml")
          .send(
            `<PurgeQueueResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></PurgeQueueResponse>`,
          );
        break;
      }
      default:
        reply
          .code(400)
          .type("text/xml")
          .send(
            errorXml(
              "InvalidAction",
              `lws: SQS operation '${action}' is not yet implemented`,
            ),
          );
    }
  } catch (err) {
    reply.code(400).type("text/xml").send(errorXml("InternalError", String(err)));
  }
}
