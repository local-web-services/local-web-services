/** Resource specification for LwsSession.create(). */
export interface ResourceSpec {
  tables?: Array<string | TableSpec>;
  queues?: Array<string | QueueSpec>;
  buckets?: Array<string | { name: string }>;
  topics?: Array<string | { name: string }>;
  stateMachines?: Array<StateMachineSpec>;
  parameters?: Array<string | ParameterSpec>;
  secrets?: Array<string | SecretSpec>;
}

export interface TableSpec {
  name: string;
  partitionKey: string;
  partitionKeyType?: "S" | "N" | "B";
  sortKey?: string;
  sortKeyType?: "S" | "N" | "B";
}

export interface QueueSpec {
  name: string;
  isFifo?: boolean;
  visibilityTimeout?: number;
}

export interface StateMachineSpec {
  name: string;
  definition?: string | object;
  roleArn?: string;
}

export interface ParameterSpec {
  name: string;
  value?: string;
  type?: "String" | "StringList" | "SecureString";
}

export interface SecretSpec {
  name: string;
  secretString?: string;
  description?: string;
}
