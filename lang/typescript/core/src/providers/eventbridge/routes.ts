import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { EventBridgeProvider } from "./provider.js";

export interface EventBridgeRoutesOptions {
  provider: EventBridgeProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function eventBridgeRoutesPlugin(
  fastify: FastifyInstance,
  opts: EventBridgeRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  fastify.addContentTypeParser(
    "application/x-amz-json-1.1",
    { parseAs: "string" },
    (_req, body, done) => {
      try {
        done(null, JSON.parse(body as string));
      } catch (err) {
        done(err as Error);
      }
    },
  );

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AWSEvents.";
    if (!target.startsWith(prefix)) {
      return reply
        .status(400)
        .header("content-type", "application/x-amz-json-1.1")
        .send(jsonError("InvalidAction", `Unknown target: ${target}`));
    }

    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;
    reply.header("content-type", "application/x-amz-json-1.1");

    try {
      switch (action) {
        case "CreateEventBus": {
          const result = provider.createEventBus(body["Name"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DeleteEventBus": {
          provider.deleteEventBus(body["Name"] as string);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListEventBuses": {
          const result = provider.listEventBuses(body["NamePrefix"] as string | undefined);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DescribeEventBus": {
          const result = provider.describeEventBus(body["Name"] as string);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "PutRule": {
          const result = provider.putRule(
            body["Name"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
            body["EventPattern"] as string | undefined,
            body["ScheduleExpression"] as string | undefined,
            (body["State"] as "ENABLED" | "DISABLED" | undefined) ?? "ENABLED",
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DeleteRule": {
          provider.deleteRule(
            body["Name"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
          );
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListRules": {
          const result = provider.listRules(
            (body["EventBusName"] as string | undefined) ?? "default",
            body["NamePrefix"] as string | undefined,
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "DescribeRule": {
          const result = provider.describeRule(
            body["Name"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "EnableRule": {
          provider.enableRule(
            body["Name"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
          );
          return reply.status(200).send(JSON.stringify({}));
        }

        case "DisableRule": {
          provider.disableRule(
            body["Name"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
          );
          return reply.status(200).send(JSON.stringify({}));
        }

        case "PutTargets": {
          const result = provider.putTargets(
            body["Rule"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
            (body["Targets"] as { Id: string; Arn: string }[]) ?? [],
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "RemoveTargets": {
          const result = provider.removeTargets(
            body["Rule"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
            (body["Ids"] as string[]) ?? [],
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "ListTargetsByRule": {
          const result = provider.listTargetsByRule(
            body["Rule"] as string,
            (body["EventBusName"] as string | undefined) ?? "default",
          );
          return reply.status(200).send(JSON.stringify(result));
        }

        case "PutEvents": {
          const entries = (body["Entries"] as Array<{
            EventBusName?: string;
            Source: string;
            DetailType: string;
            Detail: string;
          }>) ?? [];
          const result = provider.putEvents(entries);
          return reply.status(200).send(JSON.stringify(result));
        }

        case "TagResource": {
          const arn = body["ResourceARN"] as string;
          const tags = (body["Tags"] as { Key: string; Value: string }[]) ?? [];
          provider.tagResource(arn, tags);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "UntagResource": {
          const arn = body["ResourceARN"] as string;
          const keys = (body["TagKeys"] as string[]) ?? [];
          provider.untagResource(arn, keys);
          return reply.status(200).send(JSON.stringify({}));
        }

        case "ListTagsForResource": {
          const arn = body["ResourceARN"] as string;
          const tags = provider.listTagsForResource(arn);
          return reply.status(200).send(JSON.stringify({ Tags: tags }));
        }

        default:
          return reply
            .status(400)
            .send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("ResourceAlreadyExistsException")) {
        return reply.status(400).send(jsonError("ResourceAlreadyExistsException", msg));
      }
      if (msg.startsWith("ResourceNotFoundException")) {
        return reply.status(400).send(jsonError("ResourceNotFoundException", msg));
      }
      if (msg.startsWith("ValidationException")) {
        return reply.status(400).send(jsonError("ValidationException", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
