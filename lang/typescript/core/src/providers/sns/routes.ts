import formbody from "@fastify/formbody";
import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { makeLoggingHooks } from "../_shared/logging.js";
import type { SnsProvider } from "./provider.js";

const REQUEST_ID = "00000000-0000-0000-0000-000000000000";

export interface SnsRoutesOptions {
  provider: SnsProvider;
}

function errorXml(code: string, message: string): string {
  return (
    `<ErrorResponse><Error>` +
    `<Type>Sender</Type><Code>${code}</Code><Message>${message}</Message>` +
    `</Error><RequestId>${REQUEST_ID}</RequestId></ErrorResponse>`
  );
}

function wrap(outer: string, result: string): string {
  return (
    `<${outer}Response><${outer}Result>${result}</${outer}Result>` +
    `<ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></${outer}Response>`
  );
}

function emptyResponse(action: string): string {
  return `<${action}Response><ResponseMetadata><RequestId>${REQUEST_ID}</RequestId></ResponseMetadata></${action}Response>`;
}

function subXml(s: { SubscriptionArn: string; TopicArn: string; Protocol: string; Endpoint: string; Owner: string }): string {
  return (
    `<member>` +
    `<SubscriptionArn>${s.SubscriptionArn}</SubscriptionArn>` +
    `<TopicArn>${s.TopicArn}</TopicArn>` +
    `<Protocol>${s.Protocol}</Protocol>` +
    `<Endpoint>${s.Endpoint}</Endpoint>` +
    `<Owner>${s.Owner}</Owner>` +
    `</member>`
  );
}

export async function snsRoutesPlugin(
  fastify: FastifyInstance,
  opts: SnsRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  await fastify.register(formbody);

  const { onRequest, onResponse } = makeLoggingHooks("sns");
  fastify.addHook("onRequest", onRequest);
  fastify.addHook("onResponse", onResponse);

  fastify.all("/", dispatch);
  fastify.all("/*", dispatch);

  async function dispatch(req: FastifyRequest, reply: FastifyReply): Promise<void> {
    const params = (req.body as Record<string, string>) ?? {};
    const action = params["Action"] ?? "";

    reply.header("content-type", "text/xml");

    try {
      switch (action) {
        case "CreateTopic": {
          const name = params["TopicName"]!;
          const arn = provider.createTopic(name);
          return reply.status(200).send(wrap("CreateTopic", `<TopicArn>${arn}</TopicArn>`));
        }
        case "DeleteTopic": {
          provider.deleteTopic(params["TopicArn"]!);
          return reply.status(200).send(emptyResponse("DeleteTopic"));
        }
        case "ListTopics": {
          const arns = provider.listTopics();
          const members = arns.map((a) => `<member><TopicArn>${a}</TopicArn></member>`).join("");
          return reply.status(200).send(wrap("ListTopics", `<Topics>${members}</Topics>`));
        }
        case "Publish": {
          const topicArn = params["TopicArn"]!;
          const message = params["Message"]!;
          const subject = params["Subject"];
          const msgId = provider.publish(topicArn, message, subject);
          return reply.status(200).send(wrap("Publish", `<MessageId>${msgId}</MessageId>`));
        }
        case "Subscribe": {
          const topicArn = params["TopicArn"]!;
          const protocol = params["Protocol"]!;
          const endpoint = params["Endpoint"] ?? "";
          const subArn = provider.subscribe(topicArn, protocol, endpoint);
          return reply.status(200).send(
            wrap("Subscribe", `<SubscriptionArn>${subArn}</SubscriptionArn>`),
          );
        }
        case "Unsubscribe": {
          provider.unsubscribe(params["SubscriptionArn"]!);
          return reply.status(200).send(emptyResponse("Unsubscribe"));
        }
        case "ListSubscriptions": {
          const subs = provider.listSubscriptions();
          const xml = subs.map(subXml).join("");
          return reply.status(200).send(wrap("ListSubscriptions", `<Subscriptions>${xml}</Subscriptions>`));
        }
        case "ListSubscriptionsByTopic": {
          const subs = provider.listSubscriptionsByTopic(params["TopicArn"]!);
          const xml = subs.map(subXml).join("");
          return reply.status(200).send(wrap("ListSubscriptionsByTopic", `<Subscriptions>${xml}</Subscriptions>`));
        }
        case "GetTopicAttributes": {
          const attrs = provider.getTopicAttributes(params["TopicArn"]!);
          const attrsXml = Object.entries(attrs)
            .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
            .join("");
          return reply.status(200).send(
            wrap("GetTopicAttributes", `<Attributes>${attrsXml}</Attributes>`),
          );
        }
        case "SetTopicAttributes": {
          return reply.status(200).send(emptyResponse("SetTopicAttributes"));
        }
        case "TagResource": {
          const resourceArn = params["ResourceArn"]!;
          const name = resourceArn.split(":").pop() ?? "";
          const topicArn = provider.topicArnFromName(name);
          const tags: Record<string, string> = {};
          let i = 1;
          while (params[`Tags.member.${i}.Key`] !== undefined) {
            tags[params[`Tags.member.${i}.Key`]!] = params[`Tags.member.${i}.Value`] ?? "";
            i++;
          }
          provider.tagTopic(topicArn, tags);
          return reply.status(200).send(emptyResponse("TagResource"));
        }
        case "UntagResource": {
          const resourceArn = params["ResourceArn"]!;
          const name = resourceArn.split(":").pop() ?? "";
          const topicArn = provider.topicArnFromName(name);
          const keys: string[] = [];
          let j = 1;
          while (params[`TagKeys.member.${j}`] !== undefined) {
            keys.push(params[`TagKeys.member.${j}`]!);
            j++;
          }
          provider.untagTopic(topicArn, keys);
          return reply.status(200).send(emptyResponse("UntagResource"));
        }
        case "ListTagsForResource": {
          const resourceArn = params["ResourceArn"]!;
          const name = resourceArn.split(":").pop() ?? "";
          const topicArn = provider.topicArnFromName(name);
          const tagMap = provider.listTopicTags(topicArn);
          const tagsXml = Object.entries(tagMap)
            .map(([k, v]) => `<member><Key>${k}</Key><Value>${v}</Value></member>`)
            .join("");
          return reply.status(200).send(wrap("ListTagsForResource", `<Tags>${tagsXml}</Tags>`));
        }
        case "GetSubscriptionAttributes": {
          const attrs = provider.getSubscriptionAttributes(params["SubscriptionArn"]!);
          const attrsXml = Object.entries(attrs)
            .map(([k, v]) => `<entry><key>${k}</key><value>${v}</value></entry>`)
            .join("");
          return reply.status(200).send(wrap("GetSubscriptionAttributes", `<Attributes>${attrsXml}</Attributes>`));
        }
        case "SetSubscriptionAttributes": {
          provider.setSubscriptionAttribute(
            params["SubscriptionArn"]!,
            params["AttributeName"]!,
            params["AttributeValue"] ?? "",
          );
          return reply.status(200).send(emptyResponse("SetSubscriptionAttributes"));
        }
        case "ConfirmSubscription": {
          const subArn = provider.confirmSubscription(params["TopicArn"]!);
          return reply.status(200).send(wrap("ConfirmSubscription", `<SubscriptionArn>${subArn}</SubscriptionArn>`));
        }
        case "PublishBatch": {
          const entries: { Id: string; Message: string; Subject?: string }[] = [];
          let i = 1;
          while (params[`PublishBatchRequestEntries.member.${i}.Id`] !== undefined) {
            const id = params[`PublishBatchRequestEntries.member.${i}.Id`]!;
            const message = params[`PublishBatchRequestEntries.member.${i}.Message`] ?? "";
            const subject = params[`PublishBatchRequestEntries.member.${i}.Subject`];
            entries.push({ Id: id, Message: message, ...(subject !== undefined && { Subject: subject }) });
            i++;
          }
          const result = provider.publishBatch(params["TopicArn"]!, entries);
          const successXml = result.Successful.map(
            (s) => `<member><Id>${s.Id}</Id><MessageId>${s.MessageId}</MessageId></member>`,
          ).join("");
          return reply.status(200).send(
            wrap("PublishBatch", `<Successful>${successXml}</Successful><Failed/>`),
          );
        }
        default:
          return reply.status(400).send(
            errorXml("InvalidAction", `lws: SNS operation '${action}' is not yet implemented`),
          );
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("NotFoundException")) {
        return reply.status(400).send(errorXml("NotFound", msg));
      }
      return reply.status(400).send(errorXml("InternalError", msg));
    }
  }
}
