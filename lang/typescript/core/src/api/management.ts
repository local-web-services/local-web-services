/** Management API — /_ldk/* endpoints. */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import type { ServerState, ChaosRule, FakeRule, IamPolicy, CapacityConfig } from "../types";
import { defaultCapacityConfigs } from "../types";
import { WebSocketServer, type WebSocket } from "ws";

// Normalize operation name: "StartExecution" == "start-execution" == "startexecution"
function normalizeOp(op: string): string {
  return op.replace(/[-_]/g, "").toLowerCase();
}

export function registerManagementApi(
  app: FastifyInstance,
  state: ServerState,
  wsServer: WebSocketServer,
): void {
  // GET /_ldk/status
  app.get("/_ldk/status", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({ running: true, providers: [] });
  });

  // POST /_ldk/reset
  app.post("/_ldk/reset", async (_req: FastifyRequest, reply: FastifyReply) => {
    state.chaosRules.clear();
    state.fakeRules.clear();
    state.iamConfig = { enforce: false, identities: {}, resource_policies: {} };
    state.logBuffer = [];

    const defaultConfigs = defaultCapacityConfigs();
    for (const service of Object.keys(state.capacityConfigs)) {
      state.capacityConfigs[service] = { slots: null };
    }
    for (const service of Object.keys(defaultConfigs)) {
      if (!(service in state.capacityConfigs)) {
        state.capacityConfigs[service] = { slots: null };
      }
    }

    for (const cb of state.resetCallbacks) {
      try {
        await Promise.resolve(cb());
      } catch {
        // ignore
      }
    }

    reply.send({ status: "ok" });
  });

  // GET /_ldk/resources
  app.get("/_ldk/resources", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({ resources: {} });
  });

  // GET /_ldk/logs
  app.get("/_ldk/logs", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({ logs: state.logBuffer });
  });

  // GET /_ldk/chaos
  const ALL_SERVICES = [
    "dynamodb",
    "sqs",
    "s3",
    "sns",
    "stepfunctions",
    "events",
    "cognito-idp",
    "ssm",
    "secretsmanager",
  ];
  app.get("/_ldk/chaos", async (_req: FastifyRequest, reply: FastifyReply) => {
    const result: Record<string, unknown> = {};
    for (const service of ALL_SERVICES) {
      const rules = state.chaosRules.get(service);
      const rule = rules?.get("*") ?? {};
      result[service] = {
        enabled: !!rules,
        error_rate: rule.error_rate ?? 0,
        latency_min_ms: rule.latency_min_ms ?? rule.latency_ms ?? 0,
        latency_max_ms: rule.latency_max_ms ?? rule.latency_ms ?? 0,
      };
    }
    reply.send(result);
  });

  // GET /_ldk/iam-auth
  app.get("/_ldk/iam-auth", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({
      mode: state.iamConfig.enforce ? "enforce" : "disabled",
      default_identity: state.iamConfig.default_identity ?? null,
      identities: state.iamConfig.identities,
      resource_policies: state.iamConfig.resource_policies,
    });
  });

  // POST /_ldk/chaos
  // SDK sends: { "service": { "enabled": bool, "error_rate": 0.5, "latency_min_ms": 100, ... } }
  app.post("/_ldk/chaos", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as Record<string, Record<string, unknown>>;

    for (const [service, config] of Object.entries(body)) {
      const enabled = config.enabled !== false;

      if (!enabled) {
        state.chaosRules.delete(service);
        continue;
      }

      // enabled: true with no other keys = mark service as enabled with empty rules
      if (Object.keys(config).filter((k) => k !== "enabled").length === 0) {
        if (!state.chaosRules.has(service)) {
          state.chaosRules.set(service, new Map());
        }
        continue;
      }

      const errorRate = config.error_rate as number | undefined;
      const latencyMinMs = config.latency_min_ms as number | undefined;
      const latencyMaxMs = config.latency_max_ms as number | undefined;
      const connectionResetRate = config.connection_reset_rate as number | undefined;
      const timeoutRate = config.timeout_rate as number | undefined;
      const errorCode = config.error_code as string | undefined;

      if (!state.chaosRules.has(service)) {
        state.chaosRules.set(service, new Map());
      }
      const serviceRules = state.chaosRules.get(service)!;

      const rule: ChaosRule = {};
      if (errorRate !== undefined && errorRate > 0) rule.error_rate = errorRate;
      if (latencyMinMs !== undefined && latencyMinMs > 0) {
        rule.latency_min_ms = latencyMinMs;
        rule.latency_ms = latencyMinMs;
      }
      if (latencyMaxMs !== undefined && latencyMaxMs > 0) rule.latency_max_ms = latencyMaxMs;
      if (connectionResetRate !== undefined && connectionResetRate > 0) {
        rule.connection_reset = Math.random() < connectionResetRate;
      }
      if (timeoutRate !== undefined && timeoutRate > 0) {
        rule.timeout = Math.random() < timeoutRate;
      }
      if (errorCode) rule.error_code = errorCode;

      // Apply to all operations (*) unless specific operations are configured
      serviceRules.set("*", rule);
    }

    reply.send({ status: "ok" });
  });

  // GET /_ldk/capacity
  app.get("/_ldk/capacity", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send(state.capacityConfigs);
  });

  // POST /_ldk/capacity
  app.post("/_ldk/capacity", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as Record<string, { slots: number | null }>;
    for (const [service, config] of Object.entries(body)) {
      if (service in state.capacityConfigs) {
        state.capacityConfigs[service] = config as CapacityConfig;
      }
    }
    reply.send({ status: "ok" });
  });

  // POST /_ldk/aws-fake
  // SDK sends: { "service": { "enabled": bool, "rules": [{ "operation": "...", "match_headers": {}, "response": { "status": 200, "content_type": "...", "delay_ms": 0, "body": "..." } }] } }
  app.post("/_ldk/aws-fake", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as Record<
      string,
      { enabled?: boolean; rules?: Array<Record<string, unknown>> }
    >;

    for (const [service, config] of Object.entries(body)) {
      const enabled = config.enabled !== false;
      const rules = config.rules ?? [];

      if (!enabled || rules.length === 0) {
        state.fakeRules.delete(service);
        continue;
      }

      if (!state.fakeRules.has(service)) {
        state.fakeRules.set(service, new Map());
      }
      const serviceRules = state.fakeRules.get(service)!;

      for (const rule of rules) {
        const operationRaw = rule.operation as string;
        const response = (rule.response ?? {}) as Record<string, unknown>;
        const matchHeaders = (rule.match_headers ?? {}) as Record<string, string>;

        const fakeRule: FakeRule = {
          status: (response.status as number) ?? 200,
          body: response.body,
          delay_ms: (response.delay_ms as number) ?? 0,
          content_type: response.content_type as string | undefined,
          headers: response.content_type
            ? { "Content-Type": response.content_type as string }
            : undefined,
          match_headers: Object.keys(matchHeaders).length > 0 ? matchHeaders : undefined,
        };

        // Check if the body looks like an AWS error
        if (typeof fakeRule.body === "string" && (fakeRule.body as string).includes('"__type"')) {
          try {
            const parsed = JSON.parse(fakeRule.body as string) as Record<string, unknown>;
            if (parsed.__type) {
              fakeRule.error_code = parsed.__type as string;
              fakeRule.error_message = parsed.message as string | undefined;
              fakeRule.http_status = fakeRule.status;
            }
          } catch {
            // keep as-is
          }
        }

        // Store with normalized key (also store by original for exact match)
        serviceRules.set(operationRaw, fakeRule);
        // Also store normalized version
        const normalized = normalizeOp(operationRaw);
        serviceRules.set(`__norm_${normalized}`, fakeRule);
      }
    }

    reply.send({ status: "ok" });
  });

  // POST /_ldk/iam-auth
  // SDK sends: { "mode": "enforce"|"audit"|"disabled", "default_identity": "name", "identities": { "name": { "inline_policies": [...] } } }
  app.post("/_ldk/iam-auth", async (req: FastifyRequest, reply: FastifyReply) => {
    const body = req.body as {
      mode?: string;
      default_identity?: string;
      enforce?: boolean;
      identities?: Record<
        string,
        {
          inline_policies?: IamPolicy[];
          boundary_policy?: IamPolicy;
          permission_boundary?: IamPolicy;
        }
      >;
      resource_policies?: Record<string, IamPolicy>;
    };

    if (body.mode !== undefined) {
      state.iamConfig.enforce = body.mode === "enforce";
      // Store default_identity for lookup
      if (body.default_identity) {
        state.iamConfig.default_identity = body.default_identity;
      }
    }
    if (body.enforce !== undefined) state.iamConfig.enforce = body.enforce;

    if (body.identities) {
      for (const [name, identity] of Object.entries(body.identities)) {
        state.iamConfig.identities[name] = {
          inline_policies: identity.inline_policies,
          permission_boundary: identity.boundary_policy ?? identity.permission_boundary,
        };
      }
    }
    if (body.resource_policies) state.iamConfig.resource_policies = body.resource_policies;

    reply.send({ status: "ok" });
  });

  // POST /_ldk/lifecycle
  app.post("/_ldk/lifecycle", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({ status: "ok" });
  });

  // POST /_ldk/shutdown
  app.post("/_ldk/shutdown", async (_req: FastifyRequest, reply: FastifyReply) => {
    reply.send({ status: "shutting down" });
    setImmediate(() => process.exit(0));
  });

  // WebSocket log streaming at /_ldk/ws/logs
  app.server.on("upgrade", (request, socket, head) => {
    const url = request.url ?? "";
    if (url === "/_ldk/ws/logs") {
      wsServer.handleUpgrade(request, socket, head, (ws: WebSocket) => {
        wsServer.emit("connection", ws, request);
        state.logSubscribers.add(ws);

        // Send buffered logs
        for (const entry of state.logBuffer) {
          try {
            ws.send(JSON.stringify(entry));
          } catch {
            break;
          }
        }

        ws.on("close", () => {
          state.logSubscribers.delete(ws);
        });

        ws.on("error", () => {
          state.logSubscribers.delete(ws);
        });
      });
    }
  });
}

export { normalizeOp };
