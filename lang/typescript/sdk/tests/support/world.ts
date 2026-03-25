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
  // clusterHelpers, userHelpers, and apiHelpers will be populated by service-specific Before hooks
  this.clusterHelpers = null;
  this.userHelpers = null;
  this.apiHelpers = null;
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
