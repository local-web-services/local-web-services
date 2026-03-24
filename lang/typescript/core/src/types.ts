/** Shared type definitions for the TypeScript core. */

export interface CapacityConfig {
  slots: number | null; // null = unlimited; 0 = exhausted
}

export function isExhausted(config: CapacityConfig): boolean {
  return config.slots !== null && config.slots === 0;
}

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

const CAPACITY_SERVICES = [
  "dynamodb",
  "sqs",
  "s3",
  "sns",
  "stepfunctions",
  "events",
  "cognito-idp",
  "ssm",
  "secretsmanager",
  "lambda",
  "apigateway",
] as const;

export type CapacityService = (typeof CAPACITY_SERVICES)[number];

export function defaultCapacityConfigs(): Record<string, CapacityConfig> {
  const configs: Record<string, CapacityConfig> = {};
  for (const service of CAPACITY_SERVICES) {
    configs[service] = { slots: null };
  }
  return configs;
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
  /**
   * Cross-service ARN existence checkers.
   * Each provider may register a function here so other providers can
   * validate whether a resource ARN is currently active.
   * Key is a short service name (e.g. "sns", "sqs", "stepfunctions").
   */
  arnExistsCheckers: Map<string, (arn: string) => boolean>;
  /** Capacity configs: service -> CapacityConfig */
  capacityConfigs: Record<string, CapacityConfig>;
}

export function createServerState(): ServerState {
  return {
    chaosRules: new Map(),
    fakeRules: new Map(),
    iamConfig: { enforce: false, identities: {}, resource_policies: {} },
    logBuffer: [],
    logSubscribers: new Set(),
    resetCallbacks: [],
    arnExistsCheckers: new Map(),
    capacityConfigs: defaultCapacityConfigs(),
  };
}
