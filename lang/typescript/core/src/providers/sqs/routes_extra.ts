import { createHash } from "crypto";
import type { SqsProvider } from "./provider.js";

const REQUEST_ID = "00000000-0000-0000-0000-000000000000";

function parseBatchEntries(params: Record<string, string>, prefix: string): Record<string, string>[] {
  const entries: Record<string, string>[] = [];
  let i = 1;
  while (params[`${prefix}.${i}.Id`] !== undefined) {
    const entry: Record<string, string> = {};
    for (const [k, v] of Object.entries(params)) {
      if (k.startsWith(`${prefix}.${i}.`)) {
        entry[k.slice(`${prefix}.${i}.`.length)] = v;
      }
    }
    entries.push(entry);
    i++;
  }
  return entries;
}

function extractQueueNameFromUrl(url: string): string {
  return url.split("/").pop() ?? "";
}

function errorXml(code: string, message: string): string {
  return (
    `<ErrorResponse><Error>` +
    `<Type>Sender</Type><Code>${code}</Code><Message>${message}</Message>` +
    `</Error><RequestId>${REQUEST_ID}</RequestId></ErrorResponse>`
  );
}

type Reply = { code: (n: number) => { type: (t: string) => { send: (b: string) => void } } };

export async function handleXmlExtraAction(
  action: string,
  params: Record<string, string>,
  provider: SqsProvider,
  reply: Reply,
): Promise<boolean> {
  try {
    switch (action) {
      case "SendMessageBatch": {
        const url = params["QueueUrl"]!;
        const name = url.split("/").pop() ?? "";
        const queue = provider.getQueue(name);
        if (queue === undefined) {
          reply.code(400).type("text/xml").send(errorXml("AWS.SimpleQueueService.NonExistentQueue", `Queue not found: ${name}`));
          return true;
        }
        const entries = parseBatchEntries(params, "SendMessageBatchRequestEntry");
        const resultXml = (await Promise.all(entries.map(async (e) => {
          const msgId = await queue.sendMessage(e["MessageBody"] ?? "", {}, 0);
          const md5 = createHash("md5").update(e["MessageBody"] ?? "").digest("hex");
          return `<SendMessageBatchResultEntry><Id>${e["Id"]}</Id><MessageId>${msgId}</MessageId><MD5OfMessageBody>${md5}</MD5OfMessageBody></SendMessageBatchResultEntry>`;
        }))).join("");
        reply.code(200).type("text/xml").send(
          `<SendMessageBatchResponse><SendMessageBatchResult>${resultXml}</SendMessageBatchResult>` +
          `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></SendMessageBatchResponse>`,
        );
        return true;
      }
      case "DeleteMessageBatch": {
        const url = params["QueueUrl"]!;
        const name = url.split("/").pop() ?? "";
        const queue = provider.getQueue(name);
        const entries = parseBatchEntries(params, "DeleteMessageBatchRequestEntry");
        if (queue !== undefined) {
          await Promise.all(entries.map((e) => queue.deleteMessage(e["ReceiptHandle"] ?? "")));
        }
        const resultXml = entries.map((e) => `<DeleteMessageBatchResultEntry><Id>${e["Id"]}</Id></DeleteMessageBatchResultEntry>`).join("");
        reply.code(200).type("text/xml").send(
          `<DeleteMessageBatchResponse><DeleteMessageBatchResult>${resultXml}</DeleteMessageBatchResult>` +
          `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></DeleteMessageBatchResponse>`,
        );
        return true;
      }
      case "SetQueueAttributes": {
        const url = params["QueueUrl"]!;
        const attrs: Record<string, string> = {};
        for (const k of Object.keys(params)) {
          const m = k.match(/^Attribute\.(\d+)\.Name$/);
          if (m !== null) attrs[params[k]!] = params[`Attribute.${m[1]}.Value`] ?? "";
        }
        await provider.setQueueAttributes(extractQueueNameFromUrl(url), attrs);
        reply.code(200).type("text/xml").send(
          `<SetQueueAttributesResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></SetQueueAttributesResponse>`,
        );
        return true;
      }
      case "ListQueueTags": {
        const url = params["QueueUrl"]!;
        const tags = await provider.listQueueTags(extractQueueNameFromUrl(url));
        const tagXml = Object.entries(tags).map(([k, v]) => `<Tag><Key>${k}</Key><Value>${v}</Value></Tag>`).join("");
        reply.code(200).type("text/xml").send(
          `<ListQueueTagsResponse><ListQueueTagsResult>${tagXml}</ListQueueTagsResult><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></ListQueueTagsResponse>`,
        );
        return true;
      }
      case "TagQueue": {
        const url = params["QueueUrl"]!;
        const tags: Record<string, string> = {};
        for (const k of Object.keys(params)) {
          const m = k.match(/^Tag\.(\d+)\.Key$/);
          if (m !== null) tags[params[k]!] = params[`Tag.${m[1]}.Value`] ?? "";
        }
        await provider.tagQueue(extractQueueNameFromUrl(url), tags);
        reply.code(200).type("text/xml").send(
          `<TagQueueResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></TagQueueResponse>`,
        );
        return true;
      }
      case "UntagQueue": {
        const url = params["QueueUrl"]!;
        const keys = Object.keys(params).filter((k) => k.startsWith("TagKey.")).map((k) => params[k]!);
        await provider.untagQueue(extractQueueNameFromUrl(url), keys);
        reply.code(200).type("text/xml").send(
          `<UntagQueueResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></UntagQueueResponse>`,
        );
        return true;
      }
      case "ChangeMessageVisibility":
      case "ChangeMessageVisibilityBatch": {
        reply.code(200).type("text/xml").send(
          `<ChangeMessageVisibilityResponse><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></ChangeMessageVisibilityResponse>`,
        );
        return true;
      }
      case "ListDeadLetterSourceQueues": {
        reply.code(200).type("text/xml").send(
          `<ListDeadLetterSourceQueuesResponse><ListDeadLetterSourceQueuesResult></ListDeadLetterSourceQueuesResult><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></ListDeadLetterSourceQueuesResponse>`,
        );
        return true;
      }
      default:
        return false;
    }
  } catch (err) {
    reply.code(400).type("text/xml").send(errorXml("InternalError", String(err)));
    return true;
  }
}
