"use strict";
/** Programmatic CLI for management operations — use in tests, not as a binary. */
Object.defineProperty(exports, "__esModule", { value: true });
exports.chaosEnable = chaosEnable;
exports.chaosDisable = chaosDisable;
exports.chaosSet = chaosSet;
exports.chaosStatus = chaosStatus;
exports.iamStatus = iamStatus;
exports.iamSet = iamSet;
exports.iamDisable = iamDisable;
exports.iamSetIdentity = iamSetIdentity;
exports.iamRegisterIdentities = iamRegisterIdentities;
exports.reset = reset;
const BASE_URL = (port) => `http://127.0.0.1:${port}`;
async function post(url, body) {
    const res = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
    });
    const text = await res.text();
    try {
        return JSON.parse(text);
    }
    catch {
        return text;
    }
}
async function get(url) {
    const res = await fetch(url);
    const text = await res.text();
    try {
        return JSON.parse(text);
    }
    catch {
        return text;
    }
}
/** Enable chaos for a service (marks it as active). */
async function chaosEnable(port, service) {
    await post(`${BASE_URL(port)}/_ldk/chaos`, {
        [service]: { enabled: true },
    });
}
/** Disable chaos for a service. */
async function chaosDisable(port, service) {
    await post(`${BASE_URL(port)}/_ldk/chaos`, {
        [service]: { enabled: false },
    });
}
/** Set chaos config for a service. */
async function chaosSet(port, service, options) {
    const config = { enabled: true };
    if (options.errorRate !== undefined)
        config.error_rate = options.errorRate;
    if (options.latencyMin !== undefined)
        config.latency_min_ms = options.latencyMin;
    if (options.latencyMax !== undefined)
        config.latency_max_ms = options.latencyMax;
    await post(`${BASE_URL(port)}/_ldk/chaos`, { [service]: config });
}
/** Get chaos status — returns per-service chaos state. */
async function chaosStatus(port) {
    return get(`${BASE_URL(port)}/_ldk/chaos`);
}
/** Get IAM auth config. */
async function iamStatus(port) {
    return get(`${BASE_URL(port)}/_ldk/iam-auth`);
}
/** Set IAM mode for a service. */
async function iamSet(port, _service, mode) {
    await post(`${BASE_URL(port)}/_ldk/iam-auth`, { mode });
}
/** Disable IAM auth. */
async function iamDisable(port, _service) {
    await post(`${BASE_URL(port)}/_ldk/iam-auth`, { mode: "disabled" });
}
/** Set a specific identity as the default. */
async function iamSetIdentity(port, identity) {
    await post(`${BASE_URL(port)}/_ldk/iam-auth`, { default_identity: identity });
}
/** Register identity definitions and optionally set mode/default_identity. */
async function iamRegisterIdentities(port, identities) {
    await post(`${BASE_URL(port)}/_ldk/iam-auth`, { identities });
}
/** Reset all state. */
async function reset(port) {
    await post(`${BASE_URL(port)}/_ldk/reset`, {});
}
//# sourceMappingURL=cli.js.map