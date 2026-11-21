/**
 * Management API Fastify plugin.
 *
 * Mounts `/_ldk/` routes on the main Fastify instance:
 *   GET  /_ldk/status     — provider health
 *   GET  /_ldk/resources  — port map
 *   POST /_ldk/reset      — clear all provider state
 *   POST /_ldk/shutdown   — trigger graceful shutdown
 *
 * Mirrors `api/management.py::create_management_router`.
 */

import type { FastifyInstance } from "fastify";
import type { IProvider } from "../interfaces/provider.js";
import type { AwsChaosConfig } from "../providers/_shared/chaos.js";
import { resetChaosConfig } from "../providers/_shared/chaos.js";

export interface CapacityConfig {
  slots: number | null;
}

export interface LifecycleConfig {
  enabled: boolean;
  create_dwell_ms: number;
  delete_dwell_ms: number;
  modify_dwell_ms: number;
}

export interface IamIdentityPolicy {
  inline_policies: Array<{ actions: string[]; effect: "Allow" | "Deny" }>;
  boundary_policy?: { actions: string[] };
}

export interface IamConfig {
  mode: "enforce" | "audit" | "disabled";
  default_identity: string;
  identities: Record<string, IamIdentityPolicy>;
}

/** Minimal orchestrator surface the management plugin requires. */
export interface IOrchestratorStatus {
  readonly running: boolean;
  readonly providers: Map<string, IProvider>;
  requestShutdown(): void;
}

export interface ManagementPluginOptions {
  orchestrator: IOrchestratorStatus;
  providers?: Map<string, IProvider>;
  /** Pre-built resource metadata returned by GET /_ldk/resources. */
  resourceMetadata?: Record<string, unknown>;
  chaosConfigs?: Map<string, AwsChaosConfig>;
  capacityConfigs?: Map<string, CapacityConfig>;
  lifecycleConfigs?: Map<string, LifecycleConfig>;
  iamConfig?: IamConfig;
}

export function defaultIamConfig(): IamConfig {
  return { mode: "disabled", default_identity: "admin", identities: {} };
}

export async function managementPlugin(
  fastify: FastifyInstance,
  opts: ManagementPluginOptions,
): Promise<void> {
  const allProviders = opts.providers ?? opts.orchestrator.providers;
  const resourceMetadata = opts.resourceMetadata ?? {};
  const chaosConfigs = opts.chaosConfigs ?? new Map<string, AwsChaosConfig>();
  const capacityConfigs = opts.capacityConfigs ?? new Map<string, CapacityConfig>();
  const lifecycleConfigs = opts.lifecycleConfigs ?? new Map<string, LifecycleConfig>();
  const iamConfig: IamConfig = opts.iamConfig ?? defaultIamConfig();

  // GET /_ldk/status
  fastify.get("/_ldk/status", async (_request, reply) => {
    const providerList: Array<{ id: string; name: string; healthy: boolean }> = [];
    for (const [nodeId, provider] of allProviders) {
      let healthy = false;
      try {
        healthy = await provider.healthCheck();
      } catch {
        healthy = false;
      }
      providerList.push({ id: nodeId, name: provider.name, healthy });
    }
    reply.send({ running: opts.orchestrator.running, providers: providerList });
  });

  // GET /_ldk/resources
  fastify.get("/_ldk/resources", async (_request, reply) => {
    reply.send(resourceMetadata);
  });

  // POST /_ldk/reset
  fastify.post("/_ldk/reset", async (_request, reply) => {
    let resetCount = 0;
    for (const provider of allProviders.values()) {
      if (provider.reset !== undefined) {
        try {
          await provider.reset();
          resetCount++;
        } catch (err) {
          console.warn(`[ldk] Error resetting ${provider.name}: ${String(err)}`);
        }
      }
    }
    for (const cfg of chaosConfigs.values()) {
      resetChaosConfig(cfg);
    }
    reply.send({ status: "ok", providers_reset: resetCount });
  });

  // POST /_ldk/shutdown
  fastify.post("/_ldk/shutdown", async (_request, reply) => {
    opts.orchestrator.requestShutdown();
    reply.send({ status: "shutting_down" });
  });

  // GET /_ldk/chaos/:service — return current chaos config for a service
  fastify.get<{ Params: { service: string } }>("/_ldk/chaos/:service", async (request, reply) => {
    const cfg = chaosConfigs.get(request.params.service);
    if (cfg === undefined) {
      reply.code(404).send({ error: `No chaos config for service '${request.params.service}'` });
      return;
    }
    reply.send({
      enabled: cfg.enabled,
      error_rate: cfg.errorRate,
      latency_min_ms: cfg.latencyMinMs,
      latency_max_ms: cfg.latencyMaxMs,
      connection_reset_rate: cfg.connectionResetRate,
      timeout_rate: cfg.timeoutRate,
    });
  });

  // POST /_ldk/chaos — update chaos config
  // Body: { "<service>": { "enabled": true, "error_rate": 0.5, ... } }
  fastify.post("/_ldk/chaos", async (request, reply) => {
    const body = request.body as Record<string, Record<string, unknown>>;
    for (const [service, patch] of Object.entries(body)) {
      let cfg = chaosConfigs.get(service);
      if (cfg === undefined) {
        cfg = {
          enabled: false,
          errorRate: 0,
          latencyMinMs: 0,
          latencyMaxMs: 0,
          errors: [],
          connectionResetRate: 0,
          timeoutRate: 0,
        };
        chaosConfigs.set(service, cfg);
      }
      if (typeof patch["enabled"] === "boolean") cfg.enabled = patch["enabled"];
      if (typeof patch["error_rate"] === "number") cfg.errorRate = patch["error_rate"];
      if (typeof patch["latency_min_ms"] === "number") cfg.latencyMinMs = patch["latency_min_ms"];
      if (typeof patch["latency_max_ms"] === "number") cfg.latencyMaxMs = patch["latency_max_ms"];
      if (typeof patch["connection_reset_rate"] === "number") cfg.connectionResetRate = patch["connection_reset_rate"];
      if (typeof patch["timeout_rate"] === "number") cfg.timeoutRate = patch["timeout_rate"];
    }
    reply.send({ status: "ok" });
  });

  // DELETE /_ldk/chaos/:service — reset chaos to defaults
  fastify.delete<{ Params: { service: string } }>("/_ldk/chaos/:service", async (request, reply) => {
    const cfg = chaosConfigs.get(request.params.service);
    if (cfg !== undefined) resetChaosConfig(cfg);
    reply.send({ status: "ok" });
  });

  // GET /_ldk/capacity — return all capacity configs
  fastify.get("/_ldk/capacity", async (_request, reply) => {
    const result: Record<string, { slots: number | null }> = {};
    for (const [service, cfg] of capacityConfigs) {
      result[service] = { slots: cfg.slots };
    }
    reply.send(result);
  });

  // GET /_ldk/capacity/:service — return capacity config for one service
  fastify.get<{ Params: { service: string } }>("/_ldk/capacity/:service", async (request, reply) => {
    const cfg = capacityConfigs.get(request.params.service);
    if (cfg === undefined) {
      reply.send({ slots: null });
      return;
    }
    reply.send({ slots: cfg.slots });
  });

  // POST /_ldk/capacity — update capacity config
  // Body: { "<service>": { "slots": n | null } }
  fastify.post("/_ldk/capacity", async (request, reply) => {
    const body = request.body as Record<string, { slots: number | null }>;
    for (const [service, patch] of Object.entries(body)) {
      let cfg = capacityConfigs.get(service);
      if (cfg === undefined) {
        cfg = { slots: null };
        capacityConfigs.set(service, cfg);
      }
      if ("slots" in patch) cfg.slots = patch.slots;
    }
    reply.send({ status: "ok" });
  });

  // DELETE /_ldk/capacity/:service — reset to unlimited
  fastify.delete<{ Params: { service: string } }>("/_ldk/capacity/:service", async (request, reply) => {
    const cfg = capacityConfigs.get(request.params.service);
    if (cfg !== undefined) cfg.slots = null;
    reply.send({ status: "ok" });
  });

  // GET /_ldk/iam-auth — return current IAM auth config
  fastify.get("/_ldk/iam-auth", async (_request, reply) => {
    reply.send(iamConfig);
  });

  // POST /_ldk/iam-auth — update IAM auth config
  fastify.post("/_ldk/iam-auth", async (request, reply) => {
    const body = request.body as Partial<IamConfig>;
    if (body.mode !== undefined) iamConfig.mode = body.mode;
    if (body.default_identity !== undefined) iamConfig.default_identity = body.default_identity;
    if (body.identities !== undefined) {
      for (const [name, policy] of Object.entries(body.identities)) {
        iamConfig.identities[name] = policy;
      }
    }
    reply.send({ status: "ok" });
  });

  // DELETE /_ldk/iam-auth — reset IAM auth to defaults
  fastify.delete("/_ldk/iam-auth", async (_request, reply) => {
    iamConfig.mode = "disabled";
    iamConfig.default_identity = "admin";
    iamConfig.identities = {};
    reply.send({ status: "ok" });
  });

  // GET /_ldk/lifecycle — return all lifecycle configs
  fastify.get("/_ldk/lifecycle", async (_request, reply) => {
    const result: Record<string, LifecycleConfig> = {};
    for (const [service, cfg] of lifecycleConfigs) {
      result[service] = { ...cfg };
    }
    reply.send(result);
  });

  // GET /_ldk/lifecycle/:service — return lifecycle config for one service
  fastify.get<{ Params: { service: string } }>("/_ldk/lifecycle/:service", async (request, reply) => {
    const cfg = lifecycleConfigs.get(request.params.service);
    if (cfg === undefined) {
      reply.code(404).send({ error: `No lifecycle config for service '${request.params.service}'` });
      return;
    }
    reply.send({ ...cfg });
  });

  // POST /_ldk/lifecycle — update lifecycle config
  // Body: { "<service>": { "enabled": bool, "create_dwell_ms": n, ... } }
  fastify.post("/_ldk/lifecycle", async (request, reply) => {
    const body = request.body as Record<string, Partial<LifecycleConfig>>;
    for (const [service, patch] of Object.entries(body)) {
      let cfg = lifecycleConfigs.get(service);
      if (cfg === undefined) {
        cfg = { enabled: false, create_dwell_ms: 0, delete_dwell_ms: 0, modify_dwell_ms: 0 };
        lifecycleConfigs.set(service, cfg);
      }
      if (typeof patch.enabled === "boolean") cfg.enabled = patch.enabled;
      if (typeof patch.create_dwell_ms === "number") cfg.create_dwell_ms = patch.create_dwell_ms;
      if (typeof patch.delete_dwell_ms === "number") cfg.delete_dwell_ms = patch.delete_dwell_ms;
      if (typeof patch.modify_dwell_ms === "number") cfg.modify_dwell_ms = patch.modify_dwell_ms;
    }
    reply.send({ status: "ok" });
  });

  // DELETE /_ldk/lifecycle/:service — disable lifecycle simulation for a service
  fastify.delete<{ Params: { service: string } }>("/_ldk/lifecycle/:service", async (request, reply) => {
    lifecycleConfigs.delete(request.params.service);
    reply.send({ status: "ok" });
  });
}
