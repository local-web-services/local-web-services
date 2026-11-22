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

export { managementPlugin } from "./api/management.js";
export type { ManagementPluginOptions, IOrchestratorStatus } from "./api/management.js";

export type { AwsChaosConfig } from "./providers/_shared/chaos.js";
export { defaultChaosConfig, resetChaosConfig } from "./providers/_shared/chaos.js";
export type { ProviderContext } from "./providers/_shared/providerContext.js";

export { startDevServer } from "./cli/server.js";
export type { DevServerOptions, DevServerHandle } from "./cli/server.js";
export { fetchStatus, fetchResources, postShutdown, postReset, waitUntilReady } from "./cli/http.js";
export type { LdkStatus, LdkResources } from "./cli/http.js";
