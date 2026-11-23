import type { FastifyInstance, FastifyReply } from "fastify";
import type { LambdaProvider, FunctionConfig } from "./provider.js";
import { lambdaExtraRoutesPlugin } from "./routes_extra.js";
import { lambdaEsmRoutesPlugin } from "./routes_esm.js";

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
      try { done(null, JSON.parse(body as string)); } catch (err) { done(err as Error); }
    },
  );

  // Lambda Invoke sends application/octet-stream — accept it as raw string
  fastify.addContentTypeParser(
    "application/octet-stream",
    { parseAs: "string" },
    (_req, body, done) => done(null, body),
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

  function handleError(err: unknown, reply: FastifyReply): FastifyReply {
    const msg = err instanceof Error ? err.message : String(err);
    if (msg.startsWith("ResourceNotFoundException")) {
      return reply.status(404).header("content-type", "application/json").send(jsonError("ResourceNotFoundException", msg));
    }
    if (msg.startsWith("ResourceConflictException")) {
      return reply.status(409).header("content-type", "application/json").send(jsonError("ResourceConflictException", msg));
    }
    return reply.status(500).header("content-type", "application/json").send(jsonError("ServiceException", msg));
  }

  // CreateFunction: POST /2015-03-31/functions
  fastify.post("/2015-03-31/functions", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
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
      return reply.status(201).header("content-type", "application/json").send(JSON.stringify(fn));
    } catch (err) { return handleError(err, reply); }
  });

  // ListFunctions: GET /2015-03-31/functions
  fastify.get("/2015-03-31/functions", async (_req, reply) => {
    return reply.status(200).header("content-type", "application/json").send(JSON.stringify(provider.listFunctions()));
  });

  // GetFunction: GET /2015-03-31/functions/:name
  fastify.get<{ Params: { functionName: string } }>("/2015-03-31/functions/:functionName", async (req, reply) => {
    try {
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(provider.getFunction(req.params.functionName)));
    } catch (err) { return handleError(err, reply); }
  });

  // DeleteFunction: DELETE /2015-03-31/functions/:name
  fastify.delete<{ Params: { functionName: string } }>("/2015-03-31/functions/:functionName", async (req, reply) => {
    try {
      provider.deleteFunction(req.params.functionName);
      return reply.status(204).send("");
    } catch (err) { return handleError(err, reply); }
  });

  // UpdateFunctionCode: PUT /2015-03-31/functions/:name/code
  fastify.put<{ Params: { functionName: string } }>("/2015-03-31/functions/:functionName/code", async (req, reply) => {
    try {
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(provider.updateFunctionCode(req.params.functionName)));
    } catch (err) { return handleError(err, reply); }
  });

  // UpdateFunctionConfiguration: PUT /2015-03-31/functions/:name/configuration
  fastify.put<{ Params: { functionName: string } }>("/2015-03-31/functions/:functionName/configuration", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
      const updHandler = body["Handler"] as string | undefined;
      const updRuntime = body["Runtime"] as FunctionConfig["runtime"] | undefined;
      const updDescription = body["Description"] as string | undefined;
      const env = body["Environment"] as { Variables?: Record<string, string> } | undefined;
      const result = provider.updateFunctionConfiguration(req.params.functionName, {
        ...(updHandler !== undefined && { handler: updHandler }),
        ...(updRuntime !== undefined && { runtime: updRuntime }),
        ...(updDescription !== undefined && { description: updDescription }),
        ...(env?.Variables !== undefined && { environment: env.Variables }),
      });
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(result));
    } catch (err) { return handleError(err, reply); }
  });

  await fastify.register(lambdaExtraRoutesPlugin, { provider });
  await fastify.register(lambdaEsmRoutesPlugin, { provider });
}
