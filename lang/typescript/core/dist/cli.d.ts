/** Programmatic CLI for management operations — use in tests, not as a binary. */
import type { IamPolicy } from "./types";
/** Enable chaos for a service (marks it as active). */
export declare function chaosEnable(port: number, service: string): Promise<void>;
/** Disable chaos for a service. */
export declare function chaosDisable(port: number, service: string): Promise<void>;
/** Set chaos config for a service. */
export declare function chaosSet(port: number, service: string, options: {
    errorRate?: number;
    latencyMin?: number;
    latencyMax?: number;
}): Promise<void>;
/** Get chaos status — returns per-service chaos state. */
export declare function chaosStatus(port: number): Promise<unknown>;
/** Get IAM auth config. */
export declare function iamStatus(port: number): Promise<unknown>;
/** Set IAM mode for a service. */
export declare function iamSet(port: number, _service: string, mode: string): Promise<void>;
/** Disable IAM auth. */
export declare function iamDisable(port: number, _service: string): Promise<void>;
/** Set a specific identity as the default. */
export declare function iamSetIdentity(port: number, identity: string): Promise<void>;
/** Register identity definitions and optionally set mode/default_identity. */
export declare function iamRegisterIdentities(port: number, identities: Record<string, {
    inline_policies?: IamPolicy[];
    boundary_policy?: IamPolicy;
}>): Promise<void>;
/** Reset all state. */
export declare function reset(port: number): Promise<void>;
//# sourceMappingURL=cli.d.ts.map