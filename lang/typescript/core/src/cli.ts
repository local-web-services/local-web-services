/** Programmatic CLI for management operations — use in tests, not as a binary. */

import type { IamPolicy } from "./types";

const BASE_URL = (port: number) => `http://127.0.0.1:${port}`;

async function post(url: string, body: unknown): Promise<unknown> {
  const res = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  const text = await res.text();
  try {
    return JSON.parse(text);
  } catch {
    return text;
  }
}

async function get(url: string): Promise<unknown> {
  const res = await fetch(url);
  const text = await res.text();
  try {
    return JSON.parse(text);
  } catch {
    return text;
  }
}

/** Enable chaos for a service (marks it as active). */
export async function chaosEnable(port: number, service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/chaos`, {
    [service]: { enabled: true },
  });
}

/** Disable chaos for a service. */
export async function chaosDisable(port: number, service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/chaos`, {
    [service]: { enabled: false },
  });
}

/** Set chaos config for a service. */
export async function chaosSet(
  port: number,
  service: string,
  options: { errorRate?: number; latencyMin?: number; latencyMax?: number },
): Promise<void> {
  const config: Record<string, unknown> = { enabled: true };
  if (options.errorRate !== undefined) config.error_rate = options.errorRate;
  if (options.latencyMin !== undefined) config.latency_min_ms = options.latencyMin;
  if (options.latencyMax !== undefined) config.latency_max_ms = options.latencyMax;
  await post(`${BASE_URL(port)}/_ldk/chaos`, { [service]: config });
}

/** Get chaos status — returns per-service chaos state. */
export async function chaosStatus(port: number): Promise<unknown> {
  return get(`${BASE_URL(port)}/_ldk/chaos`);
}

/** Get IAM auth config. */
export async function iamStatus(port: number): Promise<unknown> {
  return get(`${BASE_URL(port)}/_ldk/iam-auth`);
}

/** Set IAM mode for a service. */
export async function iamSet(port: number, _service: string, mode: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/iam-auth`, { mode });
}

/** Disable IAM auth. */
export async function iamDisable(port: number, _service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/iam-auth`, { mode: "disabled" });
}

/** Set a specific identity as the default. */
export async function iamSetIdentity(port: number, identity: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/iam-auth`, { default_identity: identity });
}

/** Register identity definitions and optionally set mode/default_identity. */
export async function iamRegisterIdentities(
  port: number,
  identities: Record<string, { inline_policies?: IamPolicy[]; boundary_policy?: IamPolicy }>,
): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/iam-auth`, { identities });
}

/** Reset all state. */
export async function reset(port: number): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/reset`, {});
}

/** Set lifecycle simulation config for a service. */
export async function lifecycleSet(
  port: number,
  service: string,
  options: { createDwellMs?: number; deleteDwellMs?: number },
): Promise<void> {
  const config: Record<string, unknown> = { enabled: true };
  if (options.createDwellMs !== undefined) config.create_dwell_ms = options.createDwellMs;
  if (options.deleteDwellMs !== undefined) config.delete_dwell_ms = options.deleteDwellMs;
  await post(`${BASE_URL(port)}/_ldk/lifecycle`, { [service]: config });
}

/** Disable lifecycle simulation for a service. */
export async function lifecycleDisable(port: number, service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/lifecycle`, {
    [service]: { enabled: false, create_dwell_ms: 0, delete_dwell_ms: 0 },
  });
}

/** Get capacity status — returns per-service capacity config. */
export async function capacityStatus(port: number): Promise<unknown> {
  return get(`${BASE_URL(port)}/_ldk/capacity`);
}

/** Exhaust capacity for a service (set slots to 0). */
export async function capacityExhaust(port: number, service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/capacity`, {
    [service]: { slots: 0 },
  });
}

/** Set capacity slots for a service. */
export async function capacitySetSlots(
  port: number,
  service: string,
  slots: number | null,
): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/capacity`, {
    [service]: { slots },
  });
}

/** Reset capacity for a service (unlimited). */
export async function capacityUnlimited(port: number, service: string): Promise<void> {
  await post(`${BASE_URL(port)}/_ldk/capacity`, {
    [service]: { slots: null },
  });
}
