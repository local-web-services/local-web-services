import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import { makeLoggingHooks } from "../_shared/logging.js";
import type { SsmProvider } from "./provider.js";

export interface SsmRoutesOptions {
  provider: SsmProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function ssmRoutesPlugin(
  fastify: FastifyInstance,
  opts: SsmRoutesOptions,
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

  const { onRequest, onResponse } = makeLoggingHooks("ssm");
  fastify.addHook("onRequest", onRequest);
  fastify.addHook("onResponse", onResponse);

  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AmazonSSM.";
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
        case "PutParameter": {
          const name = body["Name"] as string;
          const value = body["Value"] as string;
          const type = (body["Type"] as string | undefined) ?? "String";
          const overwrite = (body["Overwrite"] as boolean | undefined) ?? false;
          const version = provider.putParameter(name, value, type, overwrite);
          return reply.status(200).send(JSON.stringify({ Version: version, Tier: "Standard" }));
        }
        case "GetParameter": {
          const name = body["Name"] as string;
          const param = provider.getParameter(name);
          return reply.status(200).send(JSON.stringify({ Parameter: param }));
        }
        case "GetParameters": {
          const names = body["Names"] as string[];
          const result = provider.getParameters(names);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GetParametersByPath": {
          const path = body["Path"] as string;
          const recursive = (body["Recursive"] as boolean | undefined) ?? false;
          const params = provider.getParametersByPath(path, recursive);
          return reply.status(200).send(JSON.stringify({ Parameters: params }));
        }
        case "DeleteParameter": {
          const name = body["Name"] as string;
          provider.deleteParameter(name);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "DescribeParameters": {
          const params = provider.describeParameters();
          return reply.status(200).send(JSON.stringify({ Parameters: params }));
        }
        case "AddTagsToResource": {
          const arn = body["ResourceId"] as string;
          const tags = (body["Tags"] as { Key: string; Value: string }[]) ?? [];
          provider.tagResource(arn, tags);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "RemoveTagsFromResource": {
          const arn = body["ResourceId"] as string;
          const keys = (body["TagKeys"] as string[]) ?? [];
          provider.untagResource(arn, keys);
          return reply.status(200).send(JSON.stringify({}));
        }
        case "ListTagsForResource": {
          const arn = body["ResourceId"] as string;
          const tags = provider.listTagsForResource(arn);
          return reply.status(200).send(JSON.stringify({ TagList: tags }));
        }
        default:
          return reply.status(400).send(
            jsonError("InvalidAction", `lws: SSM operation '${action}' is not yet implemented`),
          );
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("ParameterAlreadyExists")) {
        return reply.status(400).send(jsonError("ParameterAlreadyExists", msg));
      }
      if (msg.startsWith("ParameterNotFound")) {
        return reply.status(400).send(jsonError("ParameterNotFound", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
