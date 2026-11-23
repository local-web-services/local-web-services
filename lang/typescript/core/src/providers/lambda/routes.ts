import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { LambdaProvider, FunctionConfig } from "./provider.js";

export interface LambdaRoutesOptions {
  provider: LambdaProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

export async function lambdaRoutesPlugin(
  fastify: FastifyInstance,
  opts: LambdaRoutesOptions,
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

  // Lambda Invoke uses a REST path, not X-Amz-Target
  fastify.post<{ Params: { functionName: string } }>(
    "/2015-03-31/functions/:functionName/invocations",
    async (req, reply) => {
      const { functionName } = req.params;
      const invocationType = (req.headers["x-amz-invocation-type"] as string | undefined) ?? "RequestResponse";
      const payload =
        typeof req.body === "string"
          ? req.body
          : req.body !== null && req.body !== undefined
            ? JSON.stringify(req.body)
            : "{}";
      try {
        const result = await provider.invoke(functionName, payload, invocationType as "RequestResponse" | "Event" | "DryRun");
        reply.header("content-type", "application/json");
        reply.header("x-amz-function-error", "");
        return reply.status(result.StatusCode).send(result.Payload);
      } catch (err) {
        const msg = err instanceof Error ? err.message : String(err);
        if (msg.startsWith("ResourceNotFoundException")) {
          return reply.status(404).header("content-type", "application/json").send(jsonError("ResourceNotFoundException", msg));
        }
        return reply.status(500).header("content-type", "application/json").send(jsonError("InternalServerError", msg));
      }
    },
  );

  // All other Lambda ops use POST / with X-Amz-Target
  fastify.post("/", async (req: FastifyRequest, reply: FastifyReply) => {
    const target = (req.headers["x-amz-target"] as string | undefined) ?? "";
    const prefix = "AWSLambda.";
    reply.header("content-type", "application/x-amz-json-1.1");

    if (!target.startsWith(prefix)) {
      return reply.status(400).send(jsonError("InvalidAction", `Unknown target: ${target}`));
    }
    const action = target.slice(prefix.length);
    const body = req.body as Record<string, unknown>;

    try {
      switch (action) {
        case "CreateFunction": {
          const description = body["Description"] as string | undefined;
          const config: FunctionConfig = {
            functionName: body["FunctionName"] as string,
            handler: body["Handler"] as string,
            runtime: (body["Runtime"] as FunctionConfig["runtime"]) ?? "nodejs20.x",
            ...(description !== undefined && { description }),
          };
          const env = body["Environment"] as { Variables?: Record<string, string> } | undefined;
          if (env?.Variables) config.environment = env.Variables;
          const fn = provider.createFunction(config);
          return reply.status(201).send(JSON.stringify(fn));
        }
        case "DeleteFunction": {
          const name = body["FunctionName"] as string;
          provider.deleteFunction(name);
          return reply.status(204).send("");
        }
        case "ListFunctions": {
          const result = provider.listFunctions();
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GetFunction": {
          const name = body["FunctionName"] as string;
          const result = provider.getFunction(name);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "GetFunctionConfiguration": {
          const name = body["FunctionName"] as string;
          const result = provider.getFunctionConfiguration(name);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "UpdateFunctionCode": {
          const name = body["FunctionName"] as string;
          const result = provider.updateFunctionCode(name);
          return reply.status(200).send(JSON.stringify(result));
        }
        case "UpdateFunctionConfiguration": {
          const name = body["FunctionName"] as string;
          const updHandler = body["Handler"] as string | undefined;
          const updRuntime = body["Runtime"] as FunctionConfig["runtime"] | undefined;
          const updDescription = body["Description"] as string | undefined;
          const env = body["Environment"] as { Variables?: Record<string, string> } | undefined;
          const result = provider.updateFunctionConfiguration(name, {
            ...(updHandler !== undefined && { handler: updHandler }),
            ...(updRuntime !== undefined && { runtime: updRuntime }),
            ...(updDescription !== undefined && { description: updDescription }),
            ...(env?.Variables !== undefined && { environment: env.Variables }),
          });
          return reply.status(200).send(JSON.stringify(result));
        }
        default:
          return reply.status(400).send(jsonError("InvalidAction", `Unsupported action: ${action}`));
      }
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      if (msg.startsWith("ResourceNotFoundException")) {
        return reply.status(404).send(jsonError("ResourceNotFoundException", msg));
      }
      if (msg.startsWith("ResourceConflictException")) {
        return reply.status(409).send(jsonError("ResourceConflictException", msg));
      }
      return reply.status(500).send(jsonError("InternalServerError", msg));
    }
  });
}
