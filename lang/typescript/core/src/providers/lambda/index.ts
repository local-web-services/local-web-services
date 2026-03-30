/** Lambda wire-protocol Fastify plugin — in-process mock. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState } from "../../types";
import { isExhausted } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";
import { v4 as uuidv4 } from "uuid";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

// ── Store ─────────────────────────────────────────────────────────────────────

interface LambdaFunction {
  name: string;
  arn: string;
  runtime: string;
  role: string;
  handler: string;
  description: string;
  timeout: number;
  memorySize: number;
  state: string;
  codeSize: number;
  codeSha256: string;
  version: string;
  environment: Record<string, string>;
  tags: Record<string, string>;
  lastModified: string;
  revisionId: string;
  packageType: string;
}

interface EventSourceMapping {
  uuid: string;
  eventSourceArn: string;
  functionArn: string;
  state: string;
  batchSize: number;
  startingPosition: string;
  lastModified: number;
}

export class LambdaStore {
  private functions: Map<string, LambdaFunction> = new Map();
  private eventSourceMappings: Map<string, EventSourceMapping> = new Map();
  private permissions: Map<string, Array<Record<string, unknown>>> = new Map();

  reset(): void {
    this.functions.clear();
    this.eventSourceMappings.clear();
    this.permissions.clear();
  }

  createFunction(
    name: string,
    runtime: string,
    role: string,
    handler: string,
    description: string,
    timeout: number,
    memorySize: number,
    environment: Record<string, string>,
    tags: Record<string, string>,
    packageType: string,
  ): LambdaFunction {
    const fn: LambdaFunction = {
      name,
      arn: `arn:aws:lambda:${REGION}:${ACCOUNT_ID}:function:${name}`,
      runtime: runtime || "python3.9",
      role,
      handler: handler || "handler.handler",
      description: description || "",
      timeout: timeout || 30,
      memorySize: memorySize || 128,
      state: "Active",
      codeSize: 1024,
      codeSha256: Buffer.from(name).toString("base64"),
      version: "$LATEST",
      environment,
      tags,
      lastModified: new Date().toISOString(),
      revisionId: uuidv4(),
      packageType: packageType || "Zip",
    };
    this.functions.set(name, fn);
    return fn;
  }

  getFunction(name: string): LambdaFunction | undefined {
    return this.functions.get(name);
  }

  deleteFunction(name: string): void {
    if (!this.functions.has(name)) {
      throw new Error(`ResourceNotFoundException: Function ${name} not found`);
    }
    this.functions.delete(name);
  }

  listFunctions(): LambdaFunction[] {
    return Array.from(this.functions.values());
  }

  updateFunctionCode(name: string): LambdaFunction {
    const fn = this.functions.get(name);
    if (!fn) throw new Error(`ResourceNotFoundException: Function ${name} not found`);
    fn.lastModified = new Date().toISOString();
    fn.revisionId = uuidv4();
    return fn;
  }

  updateFunctionConfiguration(
    name: string,
    updates: {
      timeout?: number;
      memorySize?: number;
      description?: string;
      environment?: Record<string, string>;
      runtime?: string;
      handler?: string;
      role?: string;
    },
  ): LambdaFunction {
    const fn = this.functions.get(name);
    if (!fn) throw new Error(`ResourceNotFoundException: Function ${name} not found`);
    if (updates.timeout !== undefined) fn.timeout = updates.timeout;
    if (updates.memorySize !== undefined) fn.memorySize = updates.memorySize;
    if (updates.description !== undefined) fn.description = updates.description;
    if (updates.environment !== undefined) fn.environment = updates.environment;
    if (updates.runtime !== undefined) fn.runtime = updates.runtime;
    if (updates.handler !== undefined) fn.handler = updates.handler;
    if (updates.role !== undefined) fn.role = updates.role;
    fn.lastModified = new Date().toISOString();
    fn.revisionId = uuidv4();
    return fn;
  }

  createEventSourceMapping(
    eventSourceArn: string,
    functionArn: string,
    batchSize: number,
    startingPosition: string,
  ): EventSourceMapping {
    const mapping: EventSourceMapping = {
      uuid: uuidv4(),
      eventSourceArn,
      functionArn,
      state: "Enabled",
      batchSize: batchSize || 10,
      startingPosition: startingPosition || "TRIM_HORIZON",
      lastModified: Date.now() / 1000,
    };
    this.eventSourceMappings.set(mapping.uuid, mapping);
    return mapping;
  }

  getEventSourceMapping(uuid: string): EventSourceMapping | undefined {
    return this.eventSourceMappings.get(uuid);
  }

  deleteEventSourceMapping(uuid: string): EventSourceMapping {
    const mapping = this.eventSourceMappings.get(uuid);
    if (!mapping)
      throw new Error(`ResourceNotFoundException: Event source mapping ${uuid} not found`);
    this.eventSourceMappings.delete(uuid);
    return mapping;
  }

  listEventSourceMappings(functionName?: string): EventSourceMapping[] {
    const all = Array.from(this.eventSourceMappings.values());
    if (!functionName) return all;
    return all.filter(
      (m) =>
        m.functionArn.includes(functionName) || m.functionArn.endsWith(`:function:${functionName}`),
    );
  }

  addPermission(functionName: string, statement: Record<string, unknown>): void {
    const perms = this.permissions.get(functionName) ?? [];
    perms.push(statement);
    this.permissions.set(functionName, perms);
  }

  removePermission(functionName: string, statementId: string): boolean {
    const perms = this.permissions.get(functionName) ?? [];
    const idx = perms.findIndex((s) => s.StatementId === statementId || s.Sid === statementId);
    if (idx === -1) return false;
    perms.splice(idx, 1);
    this.permissions.set(functionName, perms);
    return true;
  }

  getPolicy(functionName: string): string {
    const perms = this.permissions.get(functionName) ?? [];
    return JSON.stringify({ Version: "2012-10-17", Statement: perms });
  }

  tagFunction(name: string, tags: Record<string, string>): void {
    const fn = this.functions.get(name);
    if (fn) {
      Object.assign(fn.tags, tags);
    }
  }

  untagFunction(name: string, tagKeys: string[]): boolean {
    const fn = this.functions.get(name);
    if (!fn) return false;
    for (const key of tagKeys) {
      if (!(key in fn.tags)) return false;
    }
    for (const key of tagKeys) delete fn.tags[key];
    return true;
  }
}

function functionToConfig(fn: LambdaFunction): Record<string, unknown> {
  return {
    FunctionName: fn.name,
    FunctionArn: fn.arn,
    Runtime: fn.runtime,
    Role: fn.role,
    Handler: fn.handler,
    Description: fn.description,
    Timeout: fn.timeout,
    MemorySize: fn.memorySize,
    State: fn.state,
    CodeSize: fn.codeSize,
    CodeSha256: fn.codeSha256,
    Version: fn.version,
    LastModified: fn.lastModified,
    RevisionId: fn.revisionId,
    PackageType: fn.packageType,
    Environment: { Variables: fn.environment },
    Architectures: ["x86_64"],
  };
}

function mappingToResponse(m: EventSourceMapping): Record<string, unknown> {
  return {
    UUID: m.uuid,
    EventSourceArn: m.eventSourceArn,
    FunctionArn: m.functionArn,
    State: m.state,
    BatchSize: m.batchSize,
    StartingPosition: m.startingPosition,
    LastModified: m.lastModified,
    StateTransitionReason: "User action",
  };
}

// ── Plugin ────────────────────────────────────────────────────────────────────

export function registerLambda(app: FastifyInstance, state: ServerState): LambdaStore {
  const store = new LambdaStore();
  state.resetCallbacks.push(() => store.reset());

  // Lambda uses REST-style routes (not X-Amz-Target)
  app.addContentTypeParser(
    ["application/octet-stream"],
    { parseAs: "buffer" },
    (_req, body, done) => done(null, body),
  );

  // ── Functions ──────────────────────────────────────────────────────────────

  app.post("/2015-03-31/functions", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("lambda", "CreateFunction");
    if (await applyIamAuth(state, "lambda", "CreateFunction", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "lambda", "CreateFunction", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "lambda", "CreateFunction", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const body = (req.body as Record<string, unknown>) ?? {};
    const env = (body.Environment as Record<string, unknown>) ?? {};
    const envVars = (env.Variables as Record<string, string>) ?? {};
    const functionName = body.FunctionName as string;
    if (store.getFunction(functionName)) {
      reply
        .status(409)
        .header("Content-Type", "application/json")
        .send({
          __type: "ResourceConflictException",
          message: `Function already exist: ${functionName}`,
        });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    try {
      const fn = store.createFunction(
        functionName,
        body.Runtime as string,
        body.Role as string,
        body.Handler as string,
        (body.Description as string) ?? "",
        (body.Timeout as number) ?? 30,
        (body.MemorySize as number) ?? 128,
        envVars,
        (body.Tags as Record<string, string>) ?? {},
        (body.PackageType as string) ?? "Zip",
      );
      reply.status(201).header("Content-Type", "application/json").send(functionToConfig(fn));
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      reply
        .status(400)
        .header("Content-Type", "application/json")
        .send({ __type: "InvalidParameterValueException", message: msg });
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/2015-03-31/functions", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("lambda", "ListFunctions");
    if (await applyIamAuth(state, "lambda", "ListFunctions", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    reply
      .header("Content-Type", "application/json")
      .send({ Functions: store.listFunctions().map(functionToConfig) });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get("/2015-03-31/functions/:name", async (req: FastifyRequest, reply: FastifyReply) => {
    const { name } = req.params as { name: string };
    const ctx = createRequestContext("lambda", "GetFunction");
    if (await applyIamAuth(state, "lambda", "GetFunction", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const fn = store.getFunction(name);
    if (!fn) {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
    } else {
      reply.header("Content-Type", "application/json").send({
        Configuration: functionToConfig(fn),
        Code: { RepositoryType: "S3", Location: `https://s3.amazonaws.com/lws-lambda/${name}.zip` },
        Tags: fn.tags,
      });
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.delete("/2015-03-31/functions/:name", async (req: FastifyRequest, reply: FastifyReply) => {
    const { name } = req.params as { name: string };
    const ctx = createRequestContext("lambda", "DeleteFunction");
    if (await applyIamAuth(state, "lambda", "DeleteFunction", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    const injectedKey = `lambda:function:${name}`;
    if (state.injectedStates.get(injectedKey) === "has_active_executions") {
      reply
        .status(400)
        .header("Content-Type", "application/json")
        .send({
          __type: "ResourceConflictException",
          message: `Function ${name} has active executions and cannot be deleted`,
        });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    try {
      store.deleteFunction(name);
      reply.status(204).send();
    } catch {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.put("/2015-03-31/functions/:name/code", async (req: FastifyRequest, reply: FastifyReply) => {
    const { name } = req.params as { name: string };
    const ctx = createRequestContext("lambda", "UpdateFunctionCode");
    try {
      const fn = store.updateFunctionCode(name);
      reply.header("Content-Type", "application/json").send(functionToConfig(fn));
    } catch {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.put(
    "/2015-03-31/functions/:name/configuration",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      const ctx = createRequestContext("lambda", "UpdateFunctionConfiguration");
      const body = (req.body as Record<string, unknown>) ?? {};
      try {
        const fn = store.updateFunctionConfiguration(name, {
          timeout: body.Timeout as number | undefined,
          memorySize: body.MemorySize as number | undefined,
          description: body.Description as string | undefined,
          runtime: body.Runtime as string | undefined,
          handler: body.Handler as string | undefined,
          role: body.Role as string | undefined,
        });
        reply.header("Content-Type", "application/json").send(functionToConfig(fn));
      } catch {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.get(
    "/2015-03-31/functions/:name/configuration",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      const ctx = createRequestContext("lambda", "GetFunctionConfiguration");
      const fn = store.getFunction(name);
      if (!fn) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
      } else {
        reply.header("Content-Type", "application/json").send(functionToConfig(fn));
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // ── Invocations ────────────────────────────────────────────────────────────

  app.post(
    "/2015-03-31/functions/:name/invocations",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      const ctx = createRequestContext("lambda", "Invoke");
      if (await applyIamAuth(state, "lambda", "Invoke", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyChaos(state, "lambda", "Invoke", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyFake(state, "lambda", "Invoke", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (isExhausted(state.capacityConfigs["lambda"] ?? { slots: null })) {
        reply
          .status(429)
          .header("Content-Type", "application/json")
          .send({ __type: "TooManyRequestsException", message: "No invocation slot available" });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (!store.getFunction(name)) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const invType = (req.headers["x-amz-invocation-type"] as string) ?? "RequestResponse";
      if (invType === "Event") {
        reply.status(202).send();
      } else {
        const payload = Buffer.from(
          JSON.stringify({ statusCode: 200, body: "lws-mock-response" }),
        ).toString("base64");
        reply.status(200).header("Content-Type", "application/json").send(payload);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // ── Event source mappings ──────────────────────────────────────────────────

  app.post(
    "/2015-03-31/event-source-mappings",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const ctx = createRequestContext("lambda", "CreateEventSourceMapping");
      const body = (req.body as Record<string, unknown>) ?? {};
      const mapping = store.createEventSourceMapping(
        body.EventSourceArn as string,
        body.FunctionArn as string,
        body.BatchSize as number,
        body.StartingPosition as string,
      );
      reply.status(202).header("Content-Type", "application/json").send(mappingToResponse(mapping));
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.get("/2015-03-31/event-source-mappings", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("lambda", "ListEventSourceMappings");
    const fnName = (req.query as Record<string, string>).FunctionName;
    reply.header("Content-Type", "application/json").send({
      EventSourceMappings: store.listEventSourceMappings(fnName).map(mappingToResponse),
    });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  app.get(
    "/2015-03-31/event-source-mappings/:uuid",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { uuid } = req.params as { uuid: string };
      const ctx = createRequestContext("lambda", "GetEventSourceMapping");
      const mapping = store.getEventSourceMapping(uuid);
      if (!mapping) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({
            __type: "ResourceNotFoundException",
            message: `Event source mapping ${uuid} not found`,
          });
      } else {
        reply.header("Content-Type", "application/json").send(mappingToResponse(mapping));
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.delete(
    "/2015-03-31/event-source-mappings/:uuid",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { uuid } = req.params as { uuid: string };
      const ctx = createRequestContext("lambda", "DeleteEventSourceMapping");
      try {
        const mapping = store.deleteEventSourceMapping(uuid);
        reply
          .status(202)
          .header("Content-Type", "application/json")
          .send(mappingToResponse(mapping));
      } catch {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({
            __type: "ResourceNotFoundException",
            message: `Event source mapping ${uuid} not found`,
          });
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.put(
    "/2015-03-31/event-source-mappings/:uuid",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { uuid } = req.params as { uuid: string };
      const ctx = createRequestContext("lambda", "UpdateEventSourceMapping");
      const mapping = store.getEventSourceMapping(uuid);
      if (!mapping) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({
            __type: "ResourceNotFoundException",
            message: `Event source mapping ${uuid} not found`,
          });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const body = (req.body as Record<string, unknown>) ?? {};
      if (body.Enabled === false) mapping.state = "Disabled";
      else if (body.Enabled === true) mapping.state = "Enabled";
      mapping.lastModified = Date.now() / 1000;
      reply.header("Content-Type", "application/json").send(mappingToResponse(mapping));
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // ── Permissions ────────────────────────────────────────────────────────────

  app.post(
    "/2015-03-31/functions/:name/policy",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      const ctx = createRequestContext("lambda", "AddPermission");
      if (!store.getFunction(name)) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const body = (req.body as Record<string, unknown>) ?? {};
      store.addPermission(name, body);
      const statement = JSON.stringify(body);
      reply.header("Content-Type", "application/json").send({ Statement: statement });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.delete(
    "/2015-03-31/functions/:name/policy/:statementId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name, statementId } = req.params as { name: string; statementId: string };
      const ctx = createRequestContext("lambda", "RemovePermission");
      if (!store.getFunction(name)) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      const removed = store.removePermission(name, statementId);
      if (!removed) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({
            __type: "ResourceNotFoundException",
            message: `Statement ${statementId} not found in resource policy`,
          });
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  app.get(
    "/2015-03-31/functions/:name/policy",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      const ctx = createRequestContext("lambda", "GetPolicy");
      reply.header("Content-Type", "application/json").send({
        Policy: store.getPolicy(name),
        RevisionId: uuidv4(),
      });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // ── Tags ───────────────────────────────────────────────────────────────────

  app.get("/2017-03-31/tags/*", async (req: FastifyRequest, reply: FastifyReply) => {
    // Extract function name from ARN in path: /2017-03-31/tags/arn:aws:lambda:...:function:name
    const rawUrl = req.url;
    const prefix = "/2017-03-31/tags/";
    const encodedArn = rawUrl.startsWith(prefix) ? rawUrl.slice(prefix.length) : "";
    const arn = decodeURIComponent(encodedArn.split("?")[0]);
    const arnParts = arn.split(":");
    const functionName = arnParts[arnParts.length - 1];
    const fn = store.getFunction(functionName);
    if (!fn) {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({
          __type: "ResourceNotFoundException",
          message: `Function ${functionName} not found`,
        });
      return;
    }
    reply.header("Content-Type", "application/json").send({ Tags: fn.tags });
  });

  app.post("/2017-03-31/tags/*", async (req: FastifyRequest, reply: FastifyReply) => {
    // Extract function name from ARN in path: /2017-03-31/tags/arn:aws:lambda:...:function:name
    const rawUrl = req.url;
    const prefix = "/2017-03-31/tags/";
    const encodedArn = rawUrl.startsWith(prefix) ? rawUrl.slice(prefix.length) : "";
    const arn = decodeURIComponent(encodedArn.split("?")[0]);
    const arnParts = arn.split(":");
    const functionName = arnParts[arnParts.length - 1];
    if (!store.getFunction(functionName)) {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({
          __type: "ResourceNotFoundException",
          message: `Function ${functionName} not found`,
        });
      return;
    }
    const body = (req.body as Record<string, unknown>) ?? {};
    const tags = (body.Tags as Record<string, string>) ?? {};
    store.tagFunction(functionName, tags);
    reply.status(204).send();
  });

  app.delete("/2017-03-31/tags/*", async (req: FastifyRequest, reply: FastifyReply) => {
    // Extract function name from ARN in path: /2017-03-31/tags/arn:aws:lambda:...:function:name
    const rawUrl = req.url;
    const prefix = "/2017-03-31/tags/";
    const encodedArn = rawUrl.startsWith(prefix) ? rawUrl.slice(prefix.length) : "";
    const arn = decodeURIComponent(encodedArn.split("?")[0]);
    const arnParts = arn.split(":");
    const functionName = arnParts[arnParts.length - 1];
    if (!store.getFunction(functionName)) {
      reply
        .status(404)
        .header("Content-Type", "application/json")
        .send({
          __type: "ResourceNotFoundException",
          message: `Function ${functionName} not found`,
        });
      return;
    }
    const tagKeys = ((req.query as Record<string, unknown>).tagKeys ?? []) as string[];
    const normalizedKeys = Array.isArray(tagKeys) ? tagKeys : [tagKeys];
    const removed = store.untagFunction(functionName, normalizedKeys);
    if (!removed) {
      reply.status(400).header("Content-Type", "application/json").send({
        __type: "InvalidParameterValueException",
        message: `Tag key(s) not found on resource`,
      });
      return;
    }
    reply.status(204).send();
  });

  // ── Concurrency ────────────────────────────────────────────────────────────

  app.put(
    "/2017-10-31/functions/:name/concurrency",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { name } = req.params as { name: string };
      if (!store.getFunction(name)) {
        reply
          .status(404)
          .header("Content-Type", "application/json")
          .send({ __type: "ResourceNotFoundException", message: `Function ${name} not found` });
        return;
      }
      const body = (req.body as Record<string, unknown>) ?? {};
      reply.header("Content-Type", "application/json").send({
        ReservedConcurrentExecutions: body.ReservedConcurrentExecutions ?? 0,
      });
    },
  );

  app.delete(
    "/2017-10-31/functions/:name/concurrency",
    async (_req: FastifyRequest, reply: FastifyReply) => {
      reply.status(204).send();
    },
  );

  app.get(
    "/2017-10-31/functions/:name/concurrency",
    async (_req: FastifyRequest, reply: FastifyReply) => {
      reply.header("Content-Type", "application/json").send({ ReservedConcurrentExecutions: 0 });
    },
  );

  return store;
}
