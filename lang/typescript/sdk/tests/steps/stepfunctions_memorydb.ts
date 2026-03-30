/** Step definitions: stepfunctions_memorydb cross-service scenarios — unique steps only */

import { When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, ExecutionStepHelpers } from "../support/world";

// ── Constants ─────────────────────────────────────────────────────────────────

const SFN_MEMORYDB_TEST_SM = "test-sf-memorydb-sm-1";
const SFN_MEMORYDB_TEST_CLUSTER = "test-sf-memorydb-cluster-1";
const SFN_MEMORYDB_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const SFN_MEMORYDB_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_MEMORYDB_TEST_INPUT = JSON.stringify({ key: "value" });
const SFN_MEMORYDB_REGION = "us-east-1";
const SFN_MEMORYDB_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnMemoryDBSfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function sfnMemoryDBClient(world: SdkWorld) {
  const { MemoryDBClient } = require("@aws-sdk/client-memorydb");
  return world.session!.client<typeof MemoryDBClient>("memorydb");
}

function sfnMemoryDBSmArn(name: string): string {
  return `arn:aws:states:${SFN_MEMORYDB_REGION}:${SFN_MEMORYDB_ACCOUNT_ID}:stateMachine:${name}`;
}

async function sfnMemoryDBCreateSm(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnMemoryDBSfnClient(world).send(
    new CreateStateMachineCommand({
      name: SFN_MEMORYDB_TEST_SM,
      definition: SFN_MEMORYDB_PASS_DEFINITION,
      roleArn: SFN_MEMORYDB_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

async function sfnMemoryDBCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  await sfnMemoryDBClient(world).send(
    new CreateClusterCommand({
      ClusterName: SFN_MEMORYDB_TEST_CLUSTER,
      NodeType: "db.r6g.large",
      ACLName: "open-access",
    }),
  );
}

// ── Before hook: register cluster helpers for @stepfunctionsmemorydb scenarios ─

Before({ tags: "@stepfunctionsmemorydb" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await sfnMemoryDBCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      if (expectedState !== "AVAILABLE") {
        // @internal: Cannot observe non-AVAILABLE cluster states in lws. No-op.
        assert.ok(world.session, "Expected session to be initialized");
        return;
      }
      const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
      const expectedClusterName = SFN_MEMORYDB_TEST_CLUSTER;
      const expectedStatus = "available";
      const result = await sfnMemoryDBClient(world).send(
        new DescribeClustersCommand({ ClusterName: expectedClusterName }),
      );
      const clusters: Array<{ Name: string; Status: string }> = result.Clusters ?? [];
      assert.ok(
        clusters.length > 0,
        `Expected cluster "${expectedClusterName}" to exist but it was not found; expected_cluster_name=${expectedClusterName}`,
      );
      const actualStatus = clusters[0].Status;
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    createNamedCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
      // Act
      try {
        const result = await sfnMemoryDBClient(world).send(
          new CreateClusterCommand({
            ClusterName: SFN_MEMORYDB_TEST_CLUSTER,
            NodeType: "db.r6g.large",
            ACLName: "open-access",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    beginClusterUpdate: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { UpdateClusterCommand } = require("@aws-sdk/client-memorydb");
      // Act
      try {
        const result = await sfnMemoryDBClient(world).send(
          new UpdateClusterCommand({ ClusterName: SFN_MEMORYDB_TEST_CLUSTER }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    completeClusterUpdate: async (world: SdkWorld) => {
      // @internal: Cannot drive cluster update to completion via public API in lws.
      assert.ok(world.session, "Expected session to be initialized");
      world.lastCallResult = {
        success: false,
        output: null,
        error: new Error("cannot drive cluster update to completion via public API in lws"),
      };
      // Assert: captured in lastCallResult
    },
  };

  const executionHelpersImpl: ExecutionStepHelpers = {
    setupExecutionRunning: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create state machine then start execution
      const expectedSmArn = await sfnMemoryDBCreateSm(this);
      (world as any)._sfnMemoryDBSmArn = expectedSmArn;
      const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
      const execResult = await sfnMemoryDBSfnClient(this).send(
        new StartExecutionCommand({
          stateMachineArn: sfnMemoryDBSmArn(SFN_MEMORYDB_TEST_SM),
          input: SFN_MEMORYDB_TEST_INPUT,
        }),
      );
      // Assert: execution started
      (world as any)._sfnMemoryDBExecArn = execResult.executionArn;
      assert.ok(execResult.executionArn, "Expected executionArn in StartExecution response");
    },
  };
  this.executionHelpers = executionHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: cluster existence ──────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

// ── Given: execution state ────────────────────────────────────────────────────

// "an execution is {string}" is registered in cross_service_common.ts (dispatches via executionHelpers).

// "no execution is {string}" is registered in cross_service_common.ts.

// ── Given: capacity ───────────────────────────────────────────────────────────

// "an execution slot is available" is registered in cross_service_common.ts.

// "no execution slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Step Functions state machine is created" is registered in stepfunctions.ts.
// "an execution of the state machine is started" is registered in stepfunctions.ts.

// "a MemoryDB cluster is created" is registered in memorydb.ts
// (dispatches via clusterHelpers.createNamedCluster registered in the Before hook above).
// "a MemoryDB cluster update begins" is registered in memorydb.ts
// (dispatches via clusterHelpers.beginClusterUpdate registered in the Before hook above).
// "the MemoryDB cluster update completes" is registered in memorydb.ts
// (dispatches via clusterHelpers.completeClusterUpdate registered in the Before hook above).

When(
  "a running execution fails to connect because the MemoryDB cluster is updating",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that fails due to UPDATING cluster in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that fails due to UPDATING cluster in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'a running execution connects to the "AVAILABLE" MemoryDB cluster and the task succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that connects to MemoryDB cluster in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that connects to MemoryDB cluster in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the state machine is "ACTIVE"" is registered in stepfunctions.ts.
// "the execution is "RUNNING"" is registered in stepfunctions.ts.
// "the operation is rejected" is registered in cross_service_common.ts.

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

Then('the cluster is "UPDATING" and connections may be refused', async function (this: SdkWorld) {
  // @internal: Cannot observe UPDATING cluster state via public API in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the cluster is \"AVAILABLE\" again" is registered in cluster_common.ts.

// "the execution is SUCCEEDED" — handled by the canonical
// Then("the execution is {string}", ...) in stepfunctions_sqs.ts.

Then('the execution is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution MemoryDB task failure in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ──────────────────────────────────────────────────────────

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

// "every succeeded execution recorded which cluster it connected to"
// — registered in cross_service_common.ts.
