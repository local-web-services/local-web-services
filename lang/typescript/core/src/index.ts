/**
 * Public API surface for `local-web-services-typescript-core`.
 *
 * Re-exports everything that the SDK and CLI need to depend on.
 */

export type { IProvider } from "./interfaces/provider.js";
export { Orchestrator } from "./runtime/orchestrator.js";
export { findFreePort } from "./runtime/portAllocator.js";
export { buildSdkEnv } from "./runtime/sdkEnv.js";

export type { QueueConfig, RedrivePolicy } from "./providers/sqs/provider.js";
export { SqsProvider, buildQueueConfig } from "./providers/sqs/provider.js";
export { sqsRoutesPlugin } from "./providers/sqs/routes.js";
export type { SqsRoutesOptions } from "./providers/sqs/routes.js";

export type { TableConfig as DynamoTableConfig } from "./providers/dynamodb/provider.js";
export { DynamoProvider } from "./providers/dynamodb/provider.js";
export { dynamoRoutesPlugin } from "./providers/dynamodb/routes.js";
export type { DynamoRoutesOptions } from "./providers/dynamodb/routes.js";
export type { DynamoAttributeValue, DynamoItem } from "./providers/dynamodb/table.js";

export type { SsmParameterConfig } from "./providers/ssm/provider.js";
export { SsmProvider } from "./providers/ssm/provider.js";
export { ssmRoutesPlugin } from "./providers/ssm/routes.js";
export type { SsmRoutesOptions } from "./providers/ssm/routes.js";

export type { SecretConfig } from "./providers/secrets/provider.js";
export { SecretsProvider } from "./providers/secrets/provider.js";
export { secretsRoutesPlugin } from "./providers/secrets/routes.js";
export type { SecretsRoutesOptions } from "./providers/secrets/routes.js";

export type { TopicConfig } from "./providers/sns/provider.js";
export { SnsProvider } from "./providers/sns/provider.js";
export { snsRoutesPlugin } from "./providers/sns/routes.js";
export type { SnsRoutesOptions } from "./providers/sns/routes.js";

export type { BucketConfig } from "./providers/s3/provider.js";
export { S3Provider } from "./providers/s3/provider.js";
export { s3RoutesPlugin } from "./providers/s3/routes.js";
export type { S3RoutesOptions } from "./providers/s3/routes.js";

export type { EventBusConfig } from "./providers/eventbridge/provider.js";
export { EventBridgeProvider } from "./providers/eventbridge/provider.js";
export { eventBridgeRoutesPlugin } from "./providers/eventbridge/routes.js";
export type { EventBridgeRoutesOptions } from "./providers/eventbridge/routes.js";

export type { StateMachineConfig } from "./providers/stepfunctions/provider.js";
export { StepFunctionsProvider } from "./providers/stepfunctions/provider.js";
export { stepFunctionsRoutesPlugin } from "./providers/stepfunctions/routes.js";
export type { StepFunctionsRoutesOptions } from "./providers/stepfunctions/routes.js";

export type { UserPoolConfig } from "./providers/cognito/provider.js";
export { CognitoProvider } from "./providers/cognito/provider.js";
export { cognitoRoutesPlugin } from "./providers/cognito/routes.js";
export type { CognitoRoutesOptions } from "./providers/cognito/routes.js";

export type { FunctionConfig } from "./providers/lambda/provider.js";
export { LambdaProvider } from "./providers/lambda/provider.js";
export { lambdaRoutesPlugin } from "./providers/lambda/routes.js";
export type { LambdaRoutesOptions } from "./providers/lambda/routes.js";

export { managementPlugin } from "./api/management.js";
export type { ManagementPluginOptions, IOrchestratorStatus } from "./api/management.js";

export type { AwsChaosConfig } from "./providers/_shared/chaos.js";
export { defaultChaosConfig, resetChaosConfig } from "./providers/_shared/chaos.js";
export type { ProviderContext } from "./providers/_shared/providerContext.js";

export { startDevServer } from "./cli/server.js";
export type { DevServerOptions, DevServerHandle } from "./cli/server.js";
export { fetchStatus, fetchResources, postShutdown, postReset, waitUntilReady } from "./cli/http.js";
export type { LdkStatus, LdkResources } from "./cli/http.js";
