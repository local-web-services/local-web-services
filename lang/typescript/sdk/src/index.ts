/**
 * Public API for `local-web-services-typescript-sdk`.
 */

export { LwsSession } from "./session.js";

export {
  DynamoTable,
  SqsQueue,
  S3Bucket,
  SnsTopic,
  SsmParameter,
  Secret,
  StateMachine,
  EventBus,
  CognitoUserPool,
  LambdaFunction,
} from "./specs.js";
export type { ResourceSpec } from "./specs.js";

export { lwsSessionFixture } from "./fixtures.js";

export { ChaosBuilder } from "./builders/chaos.js";
export type { ChaosConfig } from "./builders/chaos.js";

export { FakeBuilder, FakeRuleBuilder } from "./builders/fake.js";
export type { FakeRule } from "./builders/fake.js";

export { CapacityBuilder } from "./builders/capacity.js";
export type { CapacityConfig } from "./builders/capacity.js";

export { IamBuilder, IamIdentityBuilder } from "./builders/iam.js";
export type { IamConfig, IamIdentityPolicy } from "./builders/iam.js";

export { LifecycleBuilder } from "./builders/lifecycle.js";
export type { LifecycleConfig } from "./builders/lifecycle.js";

export { parseCdkAssembly } from "./cdk.js";
export type { FromCdkOptions } from "./cdk.js";
export { discoverFromCdk } from "./discovery/cdk.js";
export { discoverFromHcl } from "./discovery/hcl.js";
