import type { FastifyInstance, FastifyReply, FastifyRequest } from "fastify";
import type { LambdaProvider, PolicyStatement } from "./provider.js";

export interface LambdaExtraRoutesOptions {
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

function randomSid(): string { return Math.random().toString(36).slice(2); }

type ArnParams = { Params: { arn: string } };
type ArnDeleteParams = { Params: { arn: string }; Querystring: { tagKeys?: string | string[] } };
type FnParams = { Params: { functionName: string } };
type FnSidParams = { Params: { functionName: string; sid: string } };

export async function lambdaExtraRoutesPlugin(
  fastify: FastifyInstance,
  opts: LambdaExtraRoutesOptions,
): Promise<void> {
  const { provider } = opts;

  const doTag = async (req: FastifyRequest<ArnParams>, reply: FastifyReply) => {
    const body = req.body as { Tags?: Record<string, string> };
    try {
      provider.tagFunction(req.params.arn, body.Tags ?? {});
      return reply.status(204).send("");
    } catch (err) { return handleErr(err, reply); }
  };
  fastify.post<ArnParams>("/2017-03-31/tags/:arn", doTag);
  fastify.post<ArnParams>("/2015-03-31/tags/:arn", doTag);

  const doUntag = async (req: FastifyRequest<ArnDeleteParams>, reply: FastifyReply) => {
    const raw = req.query.tagKeys;
    const keys = raw === undefined ? [] : Array.isArray(raw) ? raw : [raw];
    try {
      provider.untagFunction(req.params.arn, keys);
      return reply.status(204).send("");
    } catch (err) { return handleErr(err, reply); }
  };
  fastify.delete<ArnDeleteParams>("/2017-03-31/tags/:arn", doUntag);
  fastify.delete<ArnDeleteParams>("/2015-03-31/tags/:arn", doUntag);

  const doListTags = async (req: FastifyRequest<ArnParams>, reply: FastifyReply) => {
    try {
      const tags = provider.listFunctionTags(req.params.arn);
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify({ Tags: tags }));
    } catch (err) { return handleErr(err, reply); }
  };
  fastify.get<ArnParams>("/2017-03-31/tags/:arn", doListTags);
  fastify.get<ArnParams>("/2015-03-31/tags/:arn", doListTags);

  fastify.post<FnParams>("/2015-03-31/functions/:functionName/policy", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    const stmt: PolicyStatement = {
      Sid: (body["StatementId"] as string | undefined) ?? (body["Sid"] as string | undefined) ?? randomSid(),
      Effect: "Allow",
      Action: (body["Action"] as string | string[] | undefined) ?? "",
      Principal: body["Principal"] ?? "*",
      Resource: `arn:aws:lambda:us-east-1:000000000000:function:${req.params.functionName}`,
    };
    try {
      const result = provider.addPermission(req.params.functionName, stmt);
      return reply.status(201).header("content-type", "application/json").send(JSON.stringify(result));
    } catch (err) { return handleErr(err, reply); }
  });

  fastify.get<FnParams>("/2015-03-31/functions/:functionName/policy", async (req, reply) => {
    try {
      const result = provider.getPolicy(req.params.functionName);
      if (result === null) {
        return reply.status(404).header("content-type", "application/json").send(jsonError("ResourceNotFoundException", "No policy found for function."));
      }
      return reply.status(200).header("content-type", "application/json").send(JSON.stringify(result));
    } catch (err) { return handleErr(err, reply); }
  });

  fastify.delete<FnSidParams>("/2015-03-31/functions/:functionName/policy/:sid", async (req, reply) => {
    try {
      provider.removePermission(req.params.functionName, req.params.sid);
      return reply.status(204).send("");
    } catch (err) { return handleErr(err, reply); }
  });

  fastify.put<FnParams>("/2017-10-31/functions/:functionName/concurrency", async (req, reply) => {
    const body = req.body as Record<string, unknown>;
    return reply.status(200).header("content-type", "application/json").send(
      JSON.stringify({ FunctionName: req.params.functionName, ReservedConcurrentExecutions: (body["ReservedConcurrentExecutions"] as number | undefined) ?? 0 }),
    );
  });

  fastify.get<FnParams>("/2015-03-31/functions/:functionName/versions", async (_req, reply) =>
    reply.status(200).header("content-type", "application/json").send(JSON.stringify({ Versions: [] }))
  );

  const codeSigningStub = async (_req: FastifyRequest, reply: FastifyReply) =>
    reply.status(200).header("content-type", "application/json").send(JSON.stringify({ CodeSigningConfig: null }));
  fastify.get("/2015-03-31/functions/:functionName/code-signing-config", codeSigningStub);
  fastify.get("/2020-06-30/functions/:functionName/code-signing-config", codeSigningStub);
}
