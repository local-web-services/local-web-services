/** Shared type definitions for the TypeScript core. */
export interface ChaosRule {
    error_code?: string;
    error_message?: string;
    error_rate?: number;
    latency_ms?: number;
    latency_min_ms?: number;
    latency_max_ms?: number;
    connection_reset?: boolean;
    timeout?: boolean;
    http_status?: number;
}
export interface FakeRule {
    body?: unknown;
    status?: number;
    content_type?: string;
    headers?: Record<string, string>;
    delay_ms?: number;
    error_code?: string;
    error_message?: string;
    http_status?: number;
    match_headers?: Record<string, string>;
}
export interface IamStatement {
    Effect: "Allow" | "Deny";
    Action: string | string[];
    Resource: string | string[];
    Principal?: unknown;
    Condition?: unknown;
}
export interface IamPolicy {
    Statement: IamStatement[];
}
export interface IamIdentity {
    inline_policies?: IamPolicy[];
    permission_boundary?: IamPolicy;
}
export interface IamConfig {
    enforce: boolean;
    identities: Record<string, IamIdentity>;
    resource_policies: Record<string, IamPolicy>;
    default_identity?: string;
}
export interface LogEntry {
    timestamp: string;
    service: string;
    operation: string;
    method: string;
    path: string;
    status: number;
    duration_ms: number;
    request_id: string;
}
export interface ServerState {
    /** Chaos rules: service -> operation -> ChaosRule */
    chaosRules: Map<string, Map<string, ChaosRule>>;
    /** Fake rules: service -> operation -> FakeRule */
    fakeRules: Map<string, Map<string, FakeRule>>;
    /** IAM config */
    iamConfig: IamConfig;
    /** Log buffer (circular, max 500) */
    logBuffer: LogEntry[];
    /** Log subscribers (WebSocket connections) */
    logSubscribers: Set<import("ws").WebSocket>;
    /** Reset callbacks registered by providers */
    resetCallbacks: Array<() => void | Promise<void>>;
}
export declare function createServerState(): ServerState;
//# sourceMappingURL=types.d.ts.map