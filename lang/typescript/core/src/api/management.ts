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
import type { Orchestrator } from "../runtime/orchestrator.js";
import type { AwsChaosConfig } from "../providers/_shared/chaos.js";
import { resetChaosConfig } from "../providers/_shared/chaos.js";

export interface ManagementPluginOptions {
  orchestrator: Orchestrator;
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
}
