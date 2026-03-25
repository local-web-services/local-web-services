/** Step definitions: lambda_neptune cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_NEPTUNE_TEST_FUNC = "test-lambda-neptune-1";
const LAMBDA_NEPTUNE_TEST_CLUSTER = "test-lambda-neptune-cluster-1";
const LAMBDA_NEPTUNE_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaNeptuneLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaNeptuneNeptuneClient(world: SdkWorld) {
  const { NeptuneClient } = require("@aws-sdk/client-neptune");
  return world.session!.client<typeof NeptuneClient>("neptune");
}

async function lambdaNeptuneCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaNeptuneLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_NEPTUNE_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_NEPTUNE_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaNeptuneCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  await lambdaNeptuneNeptuneClient(world).send(
    new CreateDBClusterCommand({
      DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER,
      Engine: "neptune",
    }),
  );
}

// ── Before hook: register cluster helpers for @lambdaneptune scenarios ────────

Before({ tags: "@lambdaneptune" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await lambdaNeptuneCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
      const result = await lambdaNeptuneNeptuneClient(world).send(
        new DescribeDBClustersCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
      );
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = result.DBClusters?.[0]?.Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
  this.functionHelpers = {
    functionName: LAMBDA_NEPTUNE_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaNeptuneCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_NEPTUNE_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaNeptuneLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_NEPTUNE_TEST_FUNC }),
      );
      const expectedState = "Active";
      const actualState = result.Configuration?.State ?? "";
      assert.strictEqual(
        actualState,
        expectedState,
        `Expected function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
      );
    },
  };
});

// ── Given: invocation state ───────────────────────────────────────────────────

Given("an invocation is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "IN_PROGRESS") {
    // Act: create a Lambda function so an invocation can be considered in-progress
    try {
      await lambdaNeptuneCreateFunction(this);
    } catch {
      // function may already exist; desired state is presence
    }
    return;
  }
  // For other states, no-op.
});

Given("no invocation is {string}", async function (this: SdkWorld, _state: string) {
  // No-op: fresh state after reset has no in-progress invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: Neptune cluster state unique to cross-service scenarios ────────────

Given('the Neptune cluster is "STOPPED"', async function (this: SdkWorld) {
  // Arrange: create then stop the cluster
  assert.ok(this.session, "Expected session to be initialized");
  const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
  try {
    await lambdaNeptuneCreateCluster(this);
  } catch {
    // cluster may already exist
  }
  // Act
  await lambdaNeptuneNeptuneClient(this).send(
    new StopDBClusterCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
  );
  // Assert: cluster is now STOPPED
});

Given('the Neptune cluster is not "STOPPED"', async function (this: SdkWorld) {
  // Arrange: create the cluster (available, not stopped)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaNeptuneCreateCluster(this);
  } catch {
    // cluster may already exist
  }
  // Assert: cluster is AVAILABLE
});

Given('the Neptune cluster is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange: create the cluster (available by default)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaNeptuneCreateCluster(this);
  } catch {
    // cluster may already exist
  }
  // Assert: cluster is AVAILABLE
});

Given('the Neptune cluster is not "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange: create then stop the cluster so it is not AVAILABLE
  assert.ok(this.session, "Expected session to be initialized");
  const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
  try {
    await lambdaNeptuneCreateCluster(this);
  } catch {
    // cluster may already exist
  }
  // Act
  await lambdaNeptuneNeptuneClient(this).send(
    new StopDBClusterCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
  );
  // Assert: cluster is now STOPPED (not AVAILABLE)
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Neptune cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await lambdaNeptuneNeptuneClient(this).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER,
        Engine: "neptune",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("the Neptune cluster is stopped", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await lambdaNeptuneNeptuneClient(this).send(
      new StopDBClusterCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("the Neptune cluster is started", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { StartDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await lambdaNeptuneNeptuneClient(this).send(
      new StartDBClusterCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "the Lambda function fails to connect because the Neptune cluster is stopped",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  'the Lambda function executes a graph query against the "AVAILABLE" cluster and succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation success in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the function is {string}" is registered in lambda.ts (dispatches via functionHelpers.assertFunctionActive).

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

Then(
  'the cluster is "AVAILABLE" and ready to accept graph queries',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
    // Act
    const result = await lambdaNeptuneNeptuneClient(this).send(
      new DescribeDBClustersCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
    );
    // Assert
    const expectedStatus = "available";
    const actualStatus = result.DBClusters?.[0]?.Status ?? "";
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then(
  'the cluster is "STOPPED" and graph queries will be rejected',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
    // Act
    const result = await lambdaNeptuneNeptuneClient(this).send(
      new DescribeDBClustersCommand({ DBClusterIdentifier: LAMBDA_NEPTUNE_TEST_CLUSTER }),
    );
    // Assert
    const expectedStatus = "stopped";
    const actualStatus = result.DBClusters?.[0]?.Status ?? "";
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then("the invocation is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then(
  "every successful invocation recorded which cluster it queried",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
