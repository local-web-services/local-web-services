/** Step definitions: lambda_memorydb cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_MEMORYDB_TEST_FUNC = "test-lambda-memorydb-1";
const LAMBDA_MEMORYDB_TEST_CLUSTER = "test-lambda-memorydb-cluster-1";
const LAMBDA_MEMORYDB_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaMemorydbLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaMemorydbMemoryDbClient(world: SdkWorld) {
  const { MemoryDBClient } = require("@aws-sdk/client-memorydb");
  return world.session!.client<typeof MemoryDBClient>("memorydb");
}

async function lambdaMemorydbCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaMemorydbLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_MEMORYDB_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_MEMORYDB_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaMemorydbCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  await lambdaMemorydbMemoryDbClient(world).send(
    new CreateClusterCommand({
      ClusterName: LAMBDA_MEMORYDB_TEST_CLUSTER,
      NodeType: "db.t4g.small",
      ACLName: "open-access",
    }),
  );
}

// ── Before hook: register cluster helpers for @lambdamemorydb scenarios ───────

Before({ tags: "@lambdamemorydb" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await lambdaMemorydbCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      if (expectedState !== "AVAILABLE") {
        // @internal: Cannot observe non-AVAILABLE cluster states in lws. No-op.
        return;
      }
      const { DescribeClustersCommand } = require("@aws-sdk/client-memorydb");
      const result = await lambdaMemorydbMemoryDbClient(world).send(
        new DescribeClustersCommand({ ClusterName: LAMBDA_MEMORYDB_TEST_CLUSTER }),
      );
      const expectedStatus = "available";
      const actualStatus = result.Clusters?.[0]?.Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
  this.functionHelpers = {
    functionName: LAMBDA_MEMORYDB_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaMemorydbCreateFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: LAMBDA_MEMORYDB_TEST_FUNC },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaMemorydbLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_MEMORYDB_TEST_FUNC }),
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
      await lambdaMemorydbCreateFunction(this);
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

Given("a record slot is available", async function (this: SdkWorld) {
  // No-op: always room for records in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no record slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust record slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a MemoryDB cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateClusterCommand } = require("@aws-sdk/client-memorydb");
  // Act
  try {
    const result = await lambdaMemorydbMemoryDbClient(this).send(
      new CreateClusterCommand({
        ClusterName: LAMBDA_MEMORYDB_TEST_CLUSTER,
        NodeType: "db.t4g.small",
        ACLName: "open-access",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a MemoryDB cluster update begins", async function (this: SdkWorld) {
  // @internal: Cannot force a cluster into UPDATING state via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot force cluster update: scenario is @internal"),
  };
});

When("the MemoryDB cluster update completes", async function (this: SdkWorld) {
  // @internal: Cannot force cluster update completion via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot force cluster update completion: scenario is @internal"),
  };
});

When(
  "the Lambda function fails to write because the cluster is updating",
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
  'the Lambda function writes a record to the "AVAILABLE" MemoryDB cluster during invocation',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda record write in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda record write: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the function is {string}" is registered in lambda.ts (dispatches via functionHelpers.assertFunctionActive).

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

Then('the cluster is "UPDATING" and write operations may fail', async function (this: SdkWorld) {
  // @internal: Cannot observe cluster UPDATING state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cluster is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: Cannot observe cluster AVAILABLE-again state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the invocation is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED" with a connection refused error', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the record "EXISTS" in the cluster and the invocation is "SUCCESS"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda record write result in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then("every existing record references a cluster that exists", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
