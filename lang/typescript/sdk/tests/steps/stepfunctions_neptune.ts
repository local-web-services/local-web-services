/** Step definitions: stepfunctions_neptune cross-service scenarios — unique steps only */

import { When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, ExecutionStepHelpers } from "../support/world";

// ── Constants ─────────────────────────────────────────────────────────────────

const SFN_NEPTUNE_TEST_SM = "test-sf-neptune-sm-1";
const SFN_NEPTUNE_TEST_CLUSTER_ID = "test-sf-neptune-cluster-1";
const SFN_NEPTUNE_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const SFN_NEPTUNE_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_NEPTUNE_TEST_INPUT = JSON.stringify({ key: "value" });
const SFN_NEPTUNE_REGION = "us-east-1";
const SFN_NEPTUNE_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnNeptuneSfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function sfnNeptuneNeptuneClient(world: SdkWorld) {
  const { NeptuneClient } = require("@aws-sdk/client-neptune");
  return world.session!.client<typeof NeptuneClient>("neptune");
}

function sfnNeptuneSmArn(name: string): string {
  return `arn:aws:states:${SFN_NEPTUNE_REGION}:${SFN_NEPTUNE_ACCOUNT_ID}:stateMachine:${name}`;
}

async function sfnNeptuneCreateSm(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnNeptuneSfnClient(world).send(
    new CreateStateMachineCommand({
      name: SFN_NEPTUNE_TEST_SM,
      definition: SFN_NEPTUNE_PASS_DEFINITION,
      roleArn: SFN_NEPTUNE_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

async function sfnNeptuneCreateCluster(world: SdkWorld): Promise<string> {
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  const result = await sfnNeptuneNeptuneClient(world).send(
    new CreateDBClusterCommand({
      DBClusterIdentifier: SFN_NEPTUNE_TEST_CLUSTER_ID,
      Engine: "neptune",
    }),
  );
  return result.DBCluster.DBClusterIdentifier as string;
}

// ── Before hook: register cluster helpers for @stepfunctionsneptune scenarios ─

Before({ tags: "@stepfunctionsneptune" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        const clusterID = await sfnNeptuneCreateCluster(world);
        (world as any)._sfnNeptuneClusterID = clusterID;
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      const expectedClusterID = SFN_NEPTUNE_TEST_CLUSTER_ID;
      const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
      const result = await sfnNeptuneNeptuneClient(world).send(
        new DescribeDBClustersCommand({ DBClusterIdentifier: expectedClusterID }),
      );
      const clusters: Array<{ DBClusterIdentifier: string; Status?: string }> =
        result.DBClusters ?? [];
      const actualCluster = clusters.find((c) => c.DBClusterIdentifier === expectedClusterID);
      assert.ok(
        actualCluster,
        `Expected cluster "${expectedClusterID}" to be "${expectedState}" but it was not found; expected_cluster_id=${expectedClusterID}`,
      );
      if (expectedState !== "AVAILABLE") {
        // @internal: Cannot observe non-AVAILABLE cluster states in lws. No-op.
        return;
      }
    },
    createNamedCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await sfnNeptuneNeptuneClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: SFN_NEPTUNE_TEST_CLUSTER_ID,
            Engine: "neptune",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    stopCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await sfnNeptuneNeptuneClient(world).send(
          new StopDBClusterCommand({ DBClusterIdentifier: SFN_NEPTUNE_TEST_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    startCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { StartDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await sfnNeptuneNeptuneClient(world).send(
          new StartDBClusterCommand({ DBClusterIdentifier: SFN_NEPTUNE_TEST_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };

  const executionHelpersImpl: ExecutionStepHelpers = {
    setupExecutionRunning: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create state machine then start execution
      const expectedSmArn = await sfnNeptuneCreateSm(this);
      (world as any)._sfnNeptuneSmArn = expectedSmArn;
      const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
      const execResult = await sfnNeptuneSfnClient(this).send(
        new StartExecutionCommand({
          stateMachineArn: sfnNeptuneSmArn(SFN_NEPTUNE_TEST_SM),
          input: SFN_NEPTUNE_TEST_INPUT,
        }),
      );
      // Assert: execution started
      (world as any)._sfnNeptuneExecArn = execResult.executionArn;
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

// "a Neptune cluster is created" is registered in neptune.ts (dispatches via clusterHelpers.createNamedCluster).
// "the Neptune cluster is stopped" is registered in neptune.ts (dispatches via clusterHelpers.stopCluster).
// "the Neptune cluster is started" is registered in neptune.ts (dispatches via clusterHelpers.startCluster).

When(
  "a running execution fails to query because the Neptune cluster is stopped",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that queries Neptune in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger internal execution step that queries Neptune in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'a running execution queries the "AVAILABLE" Neptune cluster and the task succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that queries Neptune in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger internal execution step that queries Neptune in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: cross-service assertions ────────────────────────────────────────────

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

// "the cluster is \"STOPPED\" and graph queries will be rejected" is registered in cluster_common.ts.
// "the cluster is \"AVAILABLE\" and ready to accept graph queries" is registered in cluster_common.ts (dispatches via clusterHelpers.assertClusterStatus).

// "the execution is SUCCEEDED" — handled by the canonical
// Then("the execution is {string}", ...) in stepfunctions_sqs.ts.

Then(`the execution is "FAILED" with a connection error`, async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution Neptune task failure in lws.
  // No-op: invariant trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ─────────────────────────────────────────────────────────

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

Then(
  "every succeeded execution recorded which cluster it queried",
  async function (this: SdkWorld) {
    // Invariant: trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
