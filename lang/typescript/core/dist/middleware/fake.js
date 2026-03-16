"use strict";
/** Fake response middleware — intercepts and returns pre-configured responses. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.applyFake = applyFake;
function normalizeOp(op) {
    return op.replace(/[-_]/g, "").toLowerCase();
}
function findRule(serviceRules, operation) {
    // Exact match first
    const exact = serviceRules.get(operation);
    if (exact)
        return exact;
    // Normalized match
    const normalized = normalizeOp(operation);
    const normedKey = serviceRules.get(`__norm_${normalized}`);
    if (normedKey)
        return normedKey;
    // Scan all keys for normalized match
    for (const [key, rule] of serviceRules) {
        if (!key.startsWith("__norm_") && normalizeOp(key) === normalized) {
            return rule;
        }
    }
    return undefined;
}
async function applyFake(state, service, operation, req, reply) {
    const serviceRules = state.fakeRules.get(service);
    if (!serviceRules)
        return false;
    const rule = findRule(serviceRules, operation);
    if (!rule)
        return false;
    // Check header matching
    if (rule.match_headers) {
        for (const [key, value] of Object.entries(rule.match_headers)) {
            if (req.headers[key.toLowerCase()] !== value)
                return false;
        }
    }
    // Apply delay
    if (rule.delay_ms && rule.delay_ms > 0) {
        await new Promise((r) => setTimeout(r, rule.delay_ms));
    }
    // Return error
    if (rule.error_code) {
        const status = rule.http_status ?? rule.status ?? 400;
        reply.status(status).send({
            __type: rule.error_code,
            message: rule.error_message ?? rule.error_code,
        });
        return true;
    }
    // Return custom body
    const status = rule.status ?? rule.http_status ?? 200;
    const headers = rule.headers ?? {};
    for (const [k, v] of Object.entries(headers)) {
        reply.header(k, v);
    }
    // Set content type if specified in rule
    const contentType = rule.content_type;
    if (contentType) {
        reply.header("Content-Type", contentType);
    }
    if (rule.body !== undefined) {
        if (typeof rule.body === "string") {
            // If the content type is XML or the body looks like XML, send as raw string
            const isXml = contentType?.includes("xml") || rule.body.trimStart().startsWith("<");
            if (isXml) {
                reply.status(status).send(rule.body);
            }
            else {
                // Try to parse as JSON, fall back to raw string
                try {
                    const parsed = JSON.parse(rule.body);
                    reply.status(status).send(parsed);
                }
                catch {
                    reply.status(status).send(rule.body);
                }
            }
        }
        else {
            reply.status(status).send(rule.body);
        }
    }
    else {
        reply.status(status).send({});
    }
    return true;
}
//# sourceMappingURL=fake.js.map