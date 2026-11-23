import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { LambdaProvider } from "./provider.js";

export interface LambdaEsmRoutesOptions {
  provider: LambdaProvider;
}

function jsonError(type: string, message: string): string {
  return JSON.stringify({ __type: type, message });
}

function handleErr(err: unknown, reply: FastifyReply): FastifyReply {
  const msg = err instanceof Error ? err.message : String(err);
  if (msg.startsWith("ResourceNotFoundException")) {
    return reply.status(404).header("content-type", "application/json").send(jsonError("ResourceNotFoundException", msg));
  }
  if (msg.startsWith("ResourceConflictException")) {
    return reply.status(409).header("content-type", "application/json").send(jsonError("ResourceConflictException", msg));
  }
  return reply.status(500).header("content-type", "application/json").send(jsonError("ServiceException", msg));
}

type EsmParams = { Params: { uuid: string } };
type FnParams = { Params: { functionName: string } };

export async function lambdaEsmRoutesPlugin(
  fastify: FastifyInstance,
  opts: LambdaEsmRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  // CreateEventSourceMapping — POST /2015-03-31/event-source-mappings
  fastify.post("/2015-03-31/event-source-mappings", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
      const mapping = provider.createEventSourceMapping({
        EventSourceArn: (body["EventSourceArn"] as string) ?? "",
        FunctionName: (body["FunctionName"] as string) ?? "",
        ...(body["BatchSize"] !== undefined && { BatchSize: body["BatchSize"] as number }),
        ...(body["StartingPosition"] !== undefined && { StartingPosition: body["StartingPosition"] as string }),
      });
      return reply.status(202).header("content-type", "application/json").send(JSON.stringify(mapping));
    } catch (err) { return handleErr(err, reply); }
  });

  // ListEventSourceMappings — GET /2015-03-31/event-source-mappings
  fastify.get("/2015-03-31/event-source-mappings", async (_req, reply) =>
    reply.status(200).header("content-type", "application/json").send(JSON.stringify(provider.listEventSourceMappings()))
  );

  // GetEventSourceMapping — GET /2015-03-31/event-source-mappings/:uuid
  fastify.get<EsmParams>("/2015-03-31/event-source-mappings/:uuid", async (req, reply) => {
    try {
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(provider.getEventSourceMapping(req.params.uuid)));
    } catch (err) { return handleErr(err, reply); }
  });

  // UpdateEventSourceMapping — PUT /2015-03-31/event-source-mappings/:uuid
  fastify.put<EsmParams>("/2015-03-31/event-source-mappings/:uuid", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
      const mapping = provider.updateEventSourceMapping(req.params.uuid, {
        ...(body["BatchSize"] !== undefined && { BatchSize: body["BatchSize"] as number }),
      });
      return reply.status(202).header("content-type", "application/json").send(JSON.stringify(mapping));
    } catch (err) { return handleErr(err, reply); }
  });

  // DeleteEventSourceMapping — DELETE /2015-03-31/event-source-mappings/:uuid
  fastify.delete<EsmParams>("/2015-03-31/event-source-mappings/:uuid", async (req, reply) => {
    try {
      return reply.status(202).header("content-type", "application/json").send(JSON.stringify(provider.deleteEventSourceMapping(req.params.uuid)));
    } catch (err) { return handleErr(err, reply); }
  });

  // CreateFunctionUrlConfig — POST /2021-10-31/functions/:functionName/url
  fastify.post<FnParams>("/2021-10-31/functions/:functionName/url", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
      const config = provider.createFunctionUrlConfig(
        req.params.functionName,
        (body["AuthType"] as string | undefined) ?? "NONE",
        body["Cors"] as Record<string, unknown> | undefined,
      );
      return reply.status(201).header("content-type", "application/json").send(JSON.stringify(config));
    } catch (err) { return handleErr(err, reply); }
  });

  // GetFunctionUrlConfig — GET /2021-10-31/functions/:functionName/url
  fastify.get<FnParams>("/2021-10-31/functions/:functionName/url", async (req, reply) => {
    try {
      const config = provider.getFunctionUrlConfig(req.params.functionName);
      if (config === undefined) {
        return reply.status(404).header("content-type", "application/json").send(jsonError("ResourceNotFoundException", "Function URL config not found."));
      }
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(config));
    } catch (err) { return handleErr(err, reply); }
  });

  // UpdateFunctionUrlConfig — PUT /2021-10-31/functions/:functionName/url
  fastify.put<FnParams>("/2021-10-31/functions/:functionName/url", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    try {
      const config = provider.updateFunctionUrlConfig(req.params.functionName, {
        ...(body["AuthType"] !== undefined && { AuthType: body["AuthType"] as string }),
        ...(body["Cors"] !== undefined && { Cors: body["Cors"] as Record<string, unknown> }),
      });
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(config));
    } catch (err) { return handleErr(err, reply); }
  });

  // DeleteFunctionUrlConfig — DELETE /2021-10-31/functions/:functionName/url
  fastify.delete<FnParams>("/2021-10-31/functions/:functionName/url", async (req: FastifyRequest<FnParams>, reply) => {
    try {
      provider.deleteFunctionUrlConfig(req.params.functionName);
      return reply.status(204).send("");
    } catch (err) { return handleErr(err, reply); }
  });
}
