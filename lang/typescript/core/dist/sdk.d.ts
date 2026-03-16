/** LwsManagementSdk — class-based management SDK for use in tests and tooling. */
import type { IamPolicy } from "./types";
export declare class LwsManagementSdk {
    private readonly port;
    readonly chaos: {
        enable(service: string): Promise<void>;
        disable(service: string): Promise<void>;
        set(service: string, options: {
            errorRate?: number;
            latencyMin?: number;
            latencyMax?: number;
        }): Promise<void>;
        status(): Promise<unknown>;
    };
    readonly iam: {
        set(service: string, mode: string): Promise<void>;
        disable(service: string): Promise<void>;
        setIdentity(identity: string): Promise<void>;
        registerIdentities(identities: Record<string, {
            inline_policies?: IamPolicy[];
            boundary_policy?: IamPolicy;
        }>): Promise<void>;
        status(): Promise<unknown>;
    };
    constructor(port: number);
    reset(): Promise<void>;
}
//# sourceMappingURL=sdk.d.ts.map