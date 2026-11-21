/**
 * Chaos engineering configuration and Fastify preHandler hook.
 *
 * Injects errors, latency, timeouts, and connection resets into AWS service
 * responses based on `AwsChaosConfig`.
 *
 * Mirrors `providers/_shared/aws_chaos.py`.
 */

import type { FastifyReply, FastifyRequest } from "fastify";
import { type AwsErrorSpec, type ErrorFormat, formatError } from "./errorFormat.js";

export interface AwsChaosConfig {
  enabled: boolean;
  errorRate: number;
  latencyMinMs: number;
  latencyMaxMs: number;
  errors: AwsErrorSpec[];
  connectionResetRate: number;
  timeoutRate: number;
}

export function defaultChaosConfig(): AwsChaosConfig {
  return {
    enabled: false,
    errorRate: 0,
    latencyMinMs: 0,
    latencyMaxMs: 0,
    errors: [],
    connectionResetRate: 0,
    timeoutRate: 0,
  };
}

export function resetChaosConfig(cfg: AwsChaosConfig): void {
  cfg.enabled = false;
  cfg.errorRate = 0;
  cfg.latencyMinMs = 0;
  cfg.latencyMaxMs = 0;
  cfg.errors = [];
  cfg.connectionResetRate = 0;
  cfg.timeoutRate = 0;
}

function pickError(cfg: AwsChaosConfig): AwsErrorSpec {
  if (cfg.errors.length === 0) {
    return { type: "InternalServerError", message: "chaos: injected error", statusCode: 500 };
  }
  const totalWeight = cfg.errors.reduce((sum, e) => sum + (e.weight ?? 1), 0);
  const roll = Math.random() * totalWeight;
  let cumulative = 0;
  for (const error of cfg.errors) {
    cumulative += error.weight ?? 1;
    if (roll < cumulative) return error;
  }
  return cfg.errors[cfg.errors.length - 1]!;
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

/**
 * Returns a Fastify `preHandler` hook that applies chaos rules.
 *
 * Usage: `fastify.addHook('preHandler', chaosPreHandler(config, 'json'))`
 */
export function chaosPreHandler(
  config: AwsChaosConfig,
  errorFormat: ErrorFormat,
): (request: FastifyRequest, reply: FastifyReply) => Promise<void> {
  return async (request, reply) => {
    if (!config.enabled) return;
    if (request.url.startsWith("/_ldk/")) return;

    // Connection reset
    if (config.connectionResetRate > 0 && Math.random() < config.connectionResetRate) {
      reply.raw.destroy(new Error("chaos: connection reset"));
      return;
    }

    // Timeout simulation
    if (config.timeoutRate > 0 && Math.random() < config.timeoutRate) {
      await sleep(300_000);
      const timeoutError: AwsErrorSpec = {
        type: "ServiceUnavailableException",
        message: "chaos: request timed out",
        statusCode: 504,
      };
      const { statusCode, contentType, body } = formatError(timeoutError, errorFormat);
      reply.code(statusCode).type(contentType).send(body);
      return;
    }

    // Latency injection
    if (config.latencyMinMs > 0 || config.latencyMaxMs > 0) {
      const latency =
        config.latencyMinMs +
        Math.floor(Math.random() * (config.latencyMaxMs - config.latencyMinMs + 1));
      await sleep(latency);
    }

    // Error rate injection
    if (config.errorRate > 0 && Math.random() < config.errorRate) {
      const error = pickError(config);
      const { statusCode, contentType, body } = formatError(error, errorFormat);
      reply.code(statusCode).type(contentType).send(body);
    }
  };
}
