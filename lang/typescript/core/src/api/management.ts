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
}

export async function managementPlugin(
  fastify: FastifyInstance,
  opts: ManagementPluginOptions,
): Promise<void> {
  const allProviders = opts.providers ?? opts.orchestrator.providers;
  const resourceMetadata = opts.resourceMetadata ?? {};
  const chaosConfigs = opts.chaosConfigs ?? new Map<string, AwsChaosConfig>();

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
}
