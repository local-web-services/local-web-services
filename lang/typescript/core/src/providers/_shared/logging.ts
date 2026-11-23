/**
 * Request logging Fastify hook.
 *
 * Logs method, path, status code, and duration (ms) for every AWS service
 * request.  Mirrors `logging/middleware.py`'s `RequestLoggingMiddleware`.
 */

import type { FastifyReply, FastifyRequest } from "fastify";

/**
 * Returns a Fastify `onRequest` hook that records start time, and an
 * `onResponse` hook that logs the completed request.
 */
export function makeLoggingHooks(serviceName: string): {
  onRequest: (request: FastifyRequest) => Promise<void>;
  onResponse: (request: FastifyRequest, reply: FastifyReply) => Promise<void>;
} {
  return {
    onRequest: async (request) => {
      (request as FastifyRequest & { _lwsStart?: number })._lwsStart = Date.now();
    },
    onResponse: async (request, reply) => {
      const start = (request as FastifyRequest & { _lwsStart?: number })._lwsStart ?? Date.now();
      const durationMs = Date.now() - start;
      console.log(
        `[ldk.${serviceName}] ${request.method} ${request.url} → ${reply.statusCode} (${durationMs}ms)`,
      );
    },
  };
}
