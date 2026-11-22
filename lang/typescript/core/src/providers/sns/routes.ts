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
