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
} from "./specs.js";
export type { ResourceSpec } from "./specs.js";

export { lwsSessionFixture } from "./fixtures.js";

export { ChaosBuilder } from "./builders/chaos.js";
export type { ChaosConfig } from "./builders/chaos.js";

export { FakeBuilder, FakeRuleBuilder } from "./builders/fake.js";
export type { FakeRule } from "./builders/fake.js";

export { discoverFromCdk } from "./discovery/cdk.js";
export { discoverFromHcl } from "./discovery/hcl.js";
