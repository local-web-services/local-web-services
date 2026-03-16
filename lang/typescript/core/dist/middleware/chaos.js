"use strict";
/** Chaos injection middleware. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.applyChaos = applyChaos;
async function applyChaos(state, service, operation, _req, reply) {
    const serviceRules = state.chaosRules.get(service);
    if (!serviceRules)
        return false;
    // Check operation-specific rule first, then wildcard "*"
    const rule = serviceRules.get(operation) ?? serviceRules.get("*");
    if (!rule)
        return false;
    // Latency-only mode: when no error_rate is set but latency is, apply delay and let the request through
    if (rule.latency_ms && rule.latency_ms > 0 && rule.error_rate === undefined) {
        await new Promise((r) => setTimeout(r, rule.latency_ms));
        return false;
    }
    // Error rate: probability 0.0 - 1.0 that we inject an error
    if (rule.error_rate !== undefined) {
        if (rule.error_rate <= 0)
            return false;
        if (Math.random() > rule.error_rate)
            return false;
    }
    // Latency injection (applied before error response)
    if (rule.latency_ms && rule.latency_ms > 0) {
        await new Promise((r) => setTimeout(r, rule.latency_ms));
    }
    // Timeout simulation
    if (rule.timeout) {
        await new Promise((r) => setTimeout(r, 60000));
        reply.status(504).send({ __type: "RequestTimeout", message: "Request timed out" });
        return true;
    }
    // Connection reset simulation
    if (rule.connection_reset) {
        try {
            reply.raw.destroy();
        }
        catch {
            // ignore
        }
        return true;
    }
    // Error injection — produce a realistic AWS error
    const errorCode = rule.error_code ?? "InternalError";
    const httpStatus = rule.http_status ?? 500;
    reply.status(httpStatus).send({
        __type: errorCode,
        message: rule.error_message ?? `Chaos error: ${errorCode}`,
    });
    return true;
}
//# sourceMappingURL=chaos.js.map