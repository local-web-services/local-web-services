/**
 * local-web-services-testing TypeScript SDK.
 *
 * In-process AWS service fixtures for testing without a running ldk dev.
 */

export { LwsSession } from "./session";
export type { Resource } from "./session";
export { table, queue, bucket, topic, stateMachine, useLws } from "./session";
export { DynamoDBHelper } from "./resources/dynamodb";
export { SQSHelper } from "./resources/sqs";
export { S3Helper } from "./resources/s3";
export { FakeBuilder, FakeRuleBuilder } from "./builders/fake";
export { ChaosBuilder } from "./builders/chaos";
export { IamBuilder, IdentityBuilder } from "./builders/iam";
export { LogCapture } from "./logs";
export type {
  ResourceSpec,
  TableSpec,
  QueueSpec,
  StateMachineSpec,
  ParameterSpec,
  SecretSpec,
} from "./types";
