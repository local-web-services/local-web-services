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
 *  - createApiWithRoot: creates the REST API and fetches the root resource ID */
export interface ApiStepHelpers {
  createApi(world: SdkWorld): Promise<string>;
  createApiWithRoot(world: SdkWorld): Promise<void>;
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

/** Callbacks for shared snapshot step definitions. Each step file that
 *  exercises snapshots registers these helpers in a tagged Before hook
 *  so the canonical consolidated step definitions can call them.
 *
 *  - setupSnapshotExists: creates a snapshot (Given "the snapshot exists")
 *  - assertSnapshotStatus (optional): asserts the snapshot is in the expected state */
export interface SnapshotStepHelpers {
  setupSnapshotExists(world: SdkWorld): Promise<void>;
  assertSnapshotStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
}

/** Callbacks for shared instance step definitions. Each step file that
 *  exercises database instances registers these helpers in a tagged Before hook
 *  so the canonical consolidated step definitions can call them.
 *
 *  - assertInstanceStatus (optional): asserts the instance is in the expected state */
export interface InstanceStepHelpers {
  assertInstanceStatus?(world: SdkWorld, expectedStatus: string): Promise<void>;
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
  /** Snapshot step helpers registered by the active service's Before hook. */
  snapshotHelpers: SnapshotStepHelpers | null = null;

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
