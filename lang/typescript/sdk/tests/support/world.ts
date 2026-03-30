/** Cucumber World for the LWS TypeScript SDK BDD tests. */

import { setWorldConstructor, Before, After, World, IWorldOptions } from "@cucumber/cucumber";
import type { ITestCaseHookParameter } from "@cucumber/cucumber";
import { LwsSession } from "../../src/session";
import type { LogCapture } from "../../src/logs";

export interface LastCallResult {
  success: boolean;
  output: unknown;
  error?: unknown;
}

/** Callbacks for shared cluster step definitions. Each cluster-service step
 *  file registers these helpers in a tagged Before hook so the canonical
 *  consolidated step definitions can call them without knowing which service
 *  they are operating on.
 *
 *  - createCluster: creates the cluster for this service (used in Given steps)
 *  - assertClusterStatus (optional): queries the cluster and asserts its status
 *    matches the expected value; called in Then steps where available. When not
 *    provided, the Then step falls back to checking lastCallResult.success. */
export interface ClusterStepHelpers {
  createCluster(world: SdkWorld): Promise<void>;
  assertClusterStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  /** Optional: When "a {Service} cluster is created" — service-specific create-cluster action */
  createNamedCluster?(world: SdkWorld): Promise<void>;
  /** Optional: When "a {Service} cluster update begins" — service-specific update-cluster action */
  beginClusterUpdate?(world: SdkWorld): Promise<void>;
  /** Optional: When "the {Service} cluster update completes" */
  completeClusterUpdate?(world: SdkWorld): Promise<void>;
  /** Optional: When "the {Service} cluster is stopped" */
  stopCluster?(world: SdkWorld): Promise<void>;
  /** Optional: When "the {Service} cluster is started" */
  startCluster?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared user step definitions. Each user-service step
 *  file registers these helpers in a tagged Before hook so the canonical
 *  consolidated step definitions can call them without knowing which service
 *  they are operating on.
 *
 *  - createUser: creates the user for this service (used in Given steps)
 *  - setupUserStatus (optional): sets up the user to be in the given state (Given step)
 *  - assertUserStatus (optional): queries the user and asserts its status (Then step) */
export interface UserStepHelpers {
  createUser(world: SdkWorld): Promise<void>;
  setupUserStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  assertUserStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
}

/** Callbacks for shared API Gateway step definitions. Each cross-service step
 *  file registers these helpers in a tagged Before hook so the canonical
 *  consolidated step definitions can call them without knowing which service
 *  they are operating on.
 *
 *  - createApi: creates the REST API and stores its ID for this service
 *  - createApiWithRoot: creates the REST API and fetches the root resource ID
 *  - setupIntegration (optional): configures the service-specific integration on the API */
export interface ApiStepHelpers {
  createApi(world: SdkWorld): Promise<string>;
  createApiWithRoot(world: SdkWorld): Promise<void>;
  setupIntegration?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared bus (EventBridge) step definitions. Each event-service
 *  step file registers these helpers in a tagged Before hook so the canonical
 *  consolidated step definitions can call them without knowing which service
 *  they are operating on.
 *
 *  - createBus: creates the event bus for this service (used in Given steps)
 *  - deleteBus: deletes the event bus for this service
 *  - assertBusStatus (optional): queries the bus and asserts its status */
export interface BusStepHelpers {
  createBus(world: SdkWorld): Promise<void>;
  deleteBus(world: SdkWorld): Promise<void>;
  assertBusStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
}

/** Callbacks for shared Lambda function step definitions. Each cross-service
 *  step file that exercises Lambda functions registers these helpers in a
 *  tagged Before hook so the canonical consolidated step definitions can call
 *  them without knowing which function name they are operating on.
 *
 *  - deployFunction: creates the Lambda function (When "a Lambda function is deployed")
 *  - invokeFunction: invokes the Lambda function (When "the Lambda function is invoked")
 *  - assertFunctionActive (optional): asserts the function is in ACTIVE state (Then step)
 *  - functionName: the function name used by this service */
export interface FunctionStepHelpers {
  deployFunction(world: SdkWorld): Promise<void>;
  invokeFunction?(world: SdkWorld): Promise<void>;
  assertFunctionActive?(world: SdkWorld): Promise<void>;
  functionName: string;
}

/** Callbacks for shared state machine step definitions. Each step file that
 *  exercises Step Functions state machines registers these helpers in a tagged
 *  Before hook so the canonical consolidated step definitions can call them.
 *
 *  - assertStateMachineActive (optional): asserts the state machine is ACTIVE */
export interface StateMachineStepHelpers {
  assertStateMachineActive?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared vault step definitions (Glacier). Each step file that
 *  exercises vaults registers these helpers in a tagged Before hook.
 *
 *  - setupVaultExists: creates the vault (Given "the vault exists") */
export interface VaultStepHelpers {
  setupVaultExists(world: SdkWorld): Promise<void>;
  /** Optional: When "a Glacier vault is created" — creates vault and stores result in lastCallResult */
  createVault?(world: SdkWorld): Promise<void>;
  /** Optional: When "a Glacier vault is deleted" — deletes vault and stores result in lastCallResult */
  deleteVault?(world: SdkWorld): Promise<void>;
  /** Optional: Then "the vault {string}" — asserts vault state */
  assertVaultState?(world: SdkWorld, expectedState: string): Promise<void>;
  /** Optional: Given/Then "the vault is 'DELETED'" — no-op or assert */
  assertVaultDeleted?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared pool step definitions (Cognito). Each step file that
 *  exercises user pools registers these helpers in a tagged Before hook.
 *
 *  - setupPoolExists: creates the pool (Given "the pool exists")
 *  - assertPoolStatus (optional): asserts the pool is in the expected state */
export interface PoolStepHelpers {
  setupPoolExists(world: SdkWorld): Promise<void>;
  assertPoolStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  /** Optional: When "a Cognito user pool is created" — creates a named pool and stores result */
  createNamedPool?(world: SdkWorld): Promise<void>;
  /** Optional: When "a Cognito user pool is deleted" — deletes the pool and stores result */
  deleteNamedPool?(world: SdkWorld): Promise<void>;
  /** Optional: When "a Cognito User Pool is created" (title case) */
  createNamedUserPool?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared snapshot step definitions (RDS-like services). Each step file
 *  that exercises snapshots registers these helpers in a tagged Before hook.
 *
 *  - setupSnapshotExists: creates a snapshot (Given "the snapshot exists")
 *  - setupSnapshotNotExists: ensures no snapshot exists (Given "the snapshot does not exist")
 *  - assertSnapshotStatus (optional): asserts the snapshot status */
export interface SnapshotHelpers {
  setupSnapshotExists(world: SdkWorld): Promise<void>;
  setupSnapshotNotExists?(world: SdkWorld): Promise<void>;
  assertSnapshotStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  /** Optional: Then "the snapshot is in {string} state" — asserts the snapshot is in expected state */
  assertSnapshotInState?(world: SdkWorld, expectedState: string): Promise<void>;
  /** Optional: Then "the snapshot is in {string} state and linked to the cluster" */
  assertSnapshotInStateLinkedToCluster?(world: SdkWorld, expectedState: string): Promise<void>;
  /** Optional: Then "the snapshot is in {string} state and the cluster is {string}" */
  assertSnapshotInStateWithCluster?(
    world: SdkWorld,
    snapshotState: string,
    clusterState: string,
  ): Promise<void>;
  /** Optional: Then "the restored cluster is in {string} state" */
  assertRestoredClusterInState?(world: SdkWorld, expectedState: string): Promise<void>;
  /** Optional: When "a cluster is restored from a snapshot" */
  restoreClusterFromSnapshot?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared upload step definitions. Each step file that exercises
 *  multipart uploads registers these helpers in a tagged Before hook.
 *
 *  - setupUploadExists: creates a multipart upload (Given "the upload exists") */
export interface UploadStepHelpers {
  setupUploadExists(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared tag step definitions. Each step file that exercises
 *  resource tagging registers these helpers in a tagged Before hook so the
 *  canonical consolidated step definitions can call them without knowing which
 *  service they are operating on.
 *
 *  - setupTagAssociationActive: ensures a tag is associated with the resource (Given)
 *  - setupTagAssociationNotActive: ensures the tag association is not active (Given)
 *  - assertListTagsResult (optional): asserts the list-tags response (Then) */
export interface TagStepHelpers {
  setupTagAssociationActive(world: SdkWorld): Promise<void>;
  setupTagAssociationNotActive(world: SdkWorld): Promise<void>;
  assertListTagsResult?(world: SdkWorld): Promise<void>;
  /** Optional: Then "the resource remains tagged" — service-specific tagged assertion */
  assertResourceTagged?(world: SdkWorld): Promise<void>;
  /** Optional: Given "the resource exists" — service-specific resource creation */
  setupResourceExists?(world: SdkWorld): Promise<void>;
  /** Optional: Given "the resource does not exist" — service-specific resource absence setup */
  setupResourceNotExists?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared database (DocDB/Neptune) step definitions. Each step file
 *  registers these helpers in a tagged Before hook so the canonical consolidated
 *  step definitions can call the correct service implementation.
 *
 *  - createCluster: When "a database cluster is created"
 *  - deleteCluster: When "a database cluster is deleted"
 *  - modifyCluster: When "a database cluster configuration is modified"
 *  - createInstance: When "a database instance is created in an available cluster"
 *  - deleteInstance: When "a database instance is deleted"
 *  - modifyInstance: When "a database instance configuration is modified"
 *  - rebootInstance (optional): When "a database instance is rebooted"
 *  - createSnapshot: When "a database cluster snapshot is created"
 *  - deleteSnapshot: When "a database cluster snapshot is deleted" */
export interface DatabaseStepHelpers {
  createCluster(world: SdkWorld): Promise<void>;
  deleteCluster(world: SdkWorld): Promise<void>;
  modifyCluster(world: SdkWorld): Promise<void>;
  createInstance(world: SdkWorld): Promise<void>;
  deleteInstance(world: SdkWorld): Promise<void>;
  modifyInstance(world: SdkWorld): Promise<void>;
  rebootInstance?(world: SdkWorld): Promise<void>;
  createSnapshot(world: SdkWorld): Promise<void>;
  deleteSnapshot(world: SdkWorld): Promise<void>;
  /** Optional: Given "the instance exists" — create cluster + instance for setup */
  setupInstanceExists?(world: SdkWorld): Promise<void>;
  /** Optional: Given "the instance does not exist" — no-op or ensure clean state */
  setupInstanceNotExists?(world: SdkWorld): Promise<void>;
  /** Optional: Then "the instance is in {string} state" — assert the instance is in expected state */
  assertInstanceInState?(world: SdkWorld, expectedState: string): Promise<void>;
  /** Optional: Then "the instance is in {string} state and associated with the cluster" */
  assertInstanceInStateWithCluster?(world: SdkWorld, expectedState: string): Promise<void>;
}

/** Callbacks for shared multipart upload step definitions. Each service file that
 *  exercises multipart uploads (Glacier, S3) registers these helpers in a tagged
 *  Before hook so the canonical consolidated step definitions can dispatch to the
 *  correct service implementation.
 *
 *  - setupUploadDoesNotExist: ensures no upload is in progress (Given)
 *  - setupUploadAlreadyExists: ensures an upload is in progress (Given)
 *  - setupUploadDoesNotAlreadyExist: no-op / fresh state (Given)
 *  - uploadPart: When "a part is uploaded for a multipart upload"
 *  - completeUpload: When "a multipart upload is completed"
 *  - abortUpload: When "a multipart upload is aborted" */
export interface MultipartUploadStepHelpers {
  setupUploadDoesNotExist(world: SdkWorld): Promise<void>;
  setupUploadAlreadyExists(world: SdkWorld): Promise<void>;
  setupUploadDoesNotAlreadyExist(world: SdkWorld): Promise<void>;
  uploadPart(world: SdkWorld): Promise<void>;
  completeUpload(world: SdkWorld): Promise<void>;
  abortUpload(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared domain step definitions (Elasticsearch/OpenSearch). Each step
 *  file that exercises domains registers these helpers in a tagged Before hook
 *  so the canonical consolidated step definitions can call them.
 *
 *  - setupDomainExists: creates the domain if it doesn't exist (Given "the domain exists")
 *  - assertDomainStatus (optional): asserts the domain is in the expected state */
export interface DomainStepHelpers {
  setupDomainExists(world: SdkWorld): Promise<void>;
  assertDomainStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  /** Optional: Given/Then "the domain does not already exist" — no-op setup */
  setupDomainNotAlreadyExists?(world: SdkWorld): Promise<void>;
  /** Optional: Given/Then "the domain already exists" — creates domain */
  setupDomainAlreadyExists?(world: SdkWorld): Promise<void>;
  /** Optional: When "an Elasticsearch domain is created and becomes AVAILABLE" */
  createElasticsearchDomain?(world: SdkWorld): Promise<void>;
  /** Optional: When "a domain configuration update begins" */
  beginDomainConfigUpdate?(world: SdkWorld): Promise<void>;
  /** Optional: Then "the domain is PROCESSING and API calls may fail" */
  assertDomainProcessing?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared execution step definitions. Each cross-service step
 *  file that exercises Step Functions executions registers these helpers in a
 *  tagged Before hook so the canonical consolidated step definitions can call them.
 *
 *  - setupExecutionRunning: creates state machine and starts execution (Given "an execution is RUNNING")
 *  - assertExecutionStatus (optional): asserts the execution is in the expected state */
export interface ExecutionStepHelpers {
  setupExecutionRunning(world: SdkWorld): Promise<void>;
  assertExecutionStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
}

/** Callbacks for shared instance step definitions. Each step file that
 *  exercises database instances registers these helpers in a tagged Before hook
 *  so the canonical consolidated step definitions can call them.
 *
 *  - assertInstanceStatus (optional): asserts the instance is in the expected state */
export interface InstanceStepHelpers {
  assertInstanceStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
  /** Optional: Given '"DB" instance does not already exist' — no-op setup */
  setupInstanceNotExists?(world: SdkWorld): Promise<void>;
  /** Optional: Given '"DB" instance already exists' — creates DB instance */
  setupInstanceExists?(world: SdkWorld): Promise<void>;
  /** Optional: Given '"DB" instance is "AVAILABLE"' — creates DB instance */
  setupInstanceAvailable?(world: SdkWorld): Promise<void>;
  /** Optional: When 'an "RDS" "DB" instance is created' — creates DB instance via API */
  createDbInstance?(world: SdkWorld): Promise<void>;
  /** Optional: Then 'the "DB" instance is "AVAILABLE"' — asserts the instance is AVAILABLE */
  assertInstanceAvailable?(world: SdkWorld): Promise<void>;
}

/** Callbacks for shared table step definitions. Each step file that
 *  exercises tables (S3Tables, DynamoDB, etc.) registers these helpers in a
 *  tagged Before hook so the canonical consolidated step definitions can call them.
 *
 *  - handleTableActive: creates the table if needed and/or asserts it is ACTIVE;
 *    used both in Given (setup) and Then (assert) contexts since the same step
 *    text appears in both positions across different feature files. */
export interface TableStepHelpers {
  handleTableActive(world: SdkWorld): Promise<void>;
  /** Optional: handle target-table setup for cross-service scenarios (e.g. apigateway_dynamodb). */
  handleTargetTableActive?(world: SdkWorld): Promise<void>;
  /** Optional: handle arbitrary table status setup/assertion (e.g. "DELETING" for S3 Tables). */
  handleTableStatus?(world: SdkWorld, status: string): Promise<void>;
  /** Optional: initiate a table deletion (When "a table deletion is initiated"). */
  deleteTable?(world: SdkWorld): Promise<void>;
  /** Optional: delete table directly (When "a table is deleted" — cross-service dispatch). */
  deleteTableDirect?(world: SdkWorld): Promise<void>;
  /** Optional: assert table is in CREATING state (Then 'the table is in "CREATING" state'). */
  assertTableCreating?(world: SdkWorld): Promise<void>;
}

export class SdkWorld extends World {
  session: LwsSession | null = null;
  lastCallResult: LastCallResult = { success: false, output: null };
  lastLogCapture: LogCapture | null = null;
  lastMessages: unknown[] = [];
  /** Tags for the current scenario — set by the Before hook from scenario tags. */
  scenarioTags: string[] = [];
  /** Cluster step helpers registered by the active service's Before hook. */
  clusterHelpers: ClusterStepHelpers | null = null;
  /** User step helpers registered by the active service's Before hook. */
  userHelpers: UserStepHelpers | null = null;
  /** API Gateway step helpers registered by the active cross-service Before hook. */
  apiHelpers: ApiStepHelpers | null = null;
  /** Bus (EventBridge) step helpers registered by the active service's Before hook. */
  busHelpers: BusStepHelpers | null = null;
  /** Lambda function step helpers registered by the active cross-service Before hook. */
  functionHelpers: FunctionStepHelpers | null = null;
  /** State machine step helpers registered by the active cross-service Before hook. */
  smHelpers: StateMachineStepHelpers | null = null;
  /** Table step helpers registered by the active service's Before hook. */
  tableHelpers: TableStepHelpers | null = null;
  /** Instance step helpers registered by the active service's Before hook. */
  instanceHelpers: InstanceStepHelpers | null = null;
  /** Execution step helpers registered by the active cross-service Before hook. */
  executionHelpers: ExecutionStepHelpers | null = null;
  /** Domain step helpers registered by the active service's Before hook. */
  domainHelpers: DomainStepHelpers | null = null;
  /** Vault step helpers registered by the active service's Before hook. */
  vaultHelpers: VaultStepHelpers | null = null;
  /** Pool step helpers registered by the active service's Before hook. */
  poolHelpers: PoolStepHelpers | null = null;
  /** Snapshot step helpers registered by the active service's Before hook. */
  snapshotHelpers: SnapshotHelpers | null = null;
  /** Upload step helpers registered by the active service's Before hook. */
  uploadHelpers: UploadStepHelpers | null = null;
  /** Tag step helpers registered by the active service's Before hook. */
  tagHelpers: TagStepHelpers | null = null;
  /** Multipart upload step helpers registered by the active service's Before hook. */
  multipartUploadHelpers: MultipartUploadStepHelpers | null = null;
  /** Database (DocDB/Neptune) step helpers registered by the active service's Before hook. */
  databaseHelpers: DatabaseStepHelpers | null = null;

  // Pending spec state for multi-step resource building
  _pendingSpec: {
    tables?: Array<{ name: string; partitionKey: string }>;
    queues?: string[];
    buckets?: string[];
    topics?: string[];
    stateMachines?: Array<{ name: string; definition: object }>;
  } = {};

  constructor(options: IWorldOptions) {
    super(options);
  }

  /** Return the ARN of a state machine named `name` from the running session. */
  async getStateMachineArn(name: string): Promise<string> {
    if (!this.session) throw new Error("No session running");
    const { SFNClient, ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
    const client = this.session.client<typeof SFNClient>("stepfunctions");
    const result = await client.send(new ListStateMachinesCommand({}));
    const machines: Array<{ name: string; stateMachineArn: string }> = result.stateMachines ?? [];
    const match = machines.find((m) => m.name === name);
    if (!match) {
      throw new Error(
        `State machine "${name}" not found. Available: ${machines.map((m) => m.name).join(", ")}`,
      );
    }
    return match.stateMachineArn;
  }
}

// ── Lifecycle hooks ────────────────────────────────────────────────────────────

Before(async function (this: SdkWorld, hookParam: ITestCaseHookParameter) {
  // Close any session left open from a previous scenario
  if (this.session) {
    await this.session.close();
    this.session = null;
  }
  this.lastCallResult = { success: false, output: null };
  this.lastLogCapture = null;
  this.lastMessages = [];
  this._pendingSpec = {};

  // Capture scenario tags for service dispatch in shared step definitions
  const tags = hookParam.pickle.tags.map((t) => t.name.replace(/^@/, ""));
  this.scenarioTags = tags;
  // clusterHelpers, userHelpers, apiHelpers, busHelpers, functionHelpers, and smHelpers will be populated by service-specific Before hooks
  this.clusterHelpers = null;
  this.userHelpers = null;
  this.apiHelpers = null;
  this.busHelpers = null;
  this.functionHelpers = null;
  this.smHelpers = null;
  this.tableHelpers = null;
  this.instanceHelpers = null;
  this.snapshotHelpers = null;
  this.executionHelpers = null;
  this.domainHelpers = null;
  this.vaultHelpers = null;
  this.poolHelpers = null;
  this.uploadHelpers = null;
});

After(async function (this: SdkWorld) {
  if (this.session) {
    try {
      await this.session.close();
    } catch {
      // ignore close errors
    }
    this.session = null;
  }
});

setWorldConstructor(SdkWorld);
