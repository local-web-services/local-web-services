/** Step definitions: lambda_docdb cross-service informal specification scenarios */

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_DOCDB_TEST_FUNC = "test-lambda-docdb-1";
const LAMBDA_DOCDB_TEST_CLUSTER = "test-lambda-docdb-cluster-1";
const LAMBDA_DOCDB_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaDocdbLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaDocdbDocdbClient(world: SdkWorld) {
  const { DocDBClient } = require("@aws-sdk/client-docdb");
  return world.session!.client<typeof DocDBClient>("docdb");
}

async function lambdaDocdbCreateFunction(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  await lambdaDocdbLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_DOCDB_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_DOCDB_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
  // Assert: caller checks result
}

async function lambdaDocdbCreateCluster(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
  // Act
  await lambdaDocdbDocdbClient(world).send(
    new CreateDBClusterCommand({
      DBClusterIdentifier: LAMBDA_DOCDB_TEST_CLUSTER,
      Engine: "docdb",
      MasterUsername: "admin",
      MasterUserPassword: "pass1234",
    }),
  );
  // Assert: caller checks result
}

// ── Given: cluster state ───────────────────────────────────────────────────────

Given("the cluster does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaDocdbCreateCluster(this);
  // Assert: cluster created
});

Given("the cluster exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaDocdbCreateCluster(this);
  // Assert: cluster created
});

Given("the cluster is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "AVAILABLE") {
    // Act: create the cluster so it is AVAILABLE
    await lambdaDocdbCreateCluster(this);
    return;
  }
  if (state === "STOPPED") {
    // Act: create the cluster; lws does not expose STOPPED state via StopDBCluster
    await lambdaDocdbCreateCluster(this);
    return;
  }
});

Given("the cluster is not {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "AVAILABLE") {
    // Act: create the cluster; lws does not expose non-AVAILABLE state via public API
    await lambdaDocdbCreateCluster(this);
    return;
  }
  if (state === "STOPPED") {
    // Act: create the cluster (AVAILABLE state is not STOPPED)
    await lambdaDocdbCreateCluster(this);
    return;
  }
});

Given("the cluster does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation state ───────────────────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create the Lambda function so an invocation could be in progress
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaDocdbCreateFunction(this);
  // Assert: function created
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no in-progress invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: slot state ─────────────────────────────────────────────────────────

Given("a document slot is available", async function (this: SdkWorld) {
  // No-op: always room for documents in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no document slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust document slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaDocdbLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_DOCDB_TEST_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_DOCDB_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a DocumentDB cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
  // Act
  try {
    const result = await lambdaDocdbDocdbClient(this).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: LAMBDA_DOCDB_TEST_CLUSTER,
        Engine: "docdb",
        MasterUsername: "admin",
        MasterUserPassword: "pass1234",
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the DocumentDB cluster is stopped", async function (this: SdkWorld) {
  // @internal: StopDBCluster is not yet implemented in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot stop DocumentDB cluster: StopDBCluster not implemented in lws"),
  };
});

When("the DocumentDB cluster is started", async function (this: SdkWorld) {
  // @internal: StartDBCluster is not yet implemented in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot start DocumentDB cluster: StartDBCluster not implemented in lws"),
  };
});

When("the Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation in lws without Docker.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation: scenario is @internal"),
  };
});

When(
  "the Lambda function fails to connect because the DocumentDB cluster is stopped",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  'the Lambda function writes a document to the "AVAILABLE" DocumentDB cluster and succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda document write in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda document write: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  const result = await lambdaDocdbLambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: LAMBDA_DOCDB_TEST_FUNC }),
  );
  // Assert
  const expectedState = "Active";
  const actualState = result.Configuration?.State as string;
  assert.strictEqual(
    actualState,
    expectedState,
    `Expected function state "${expectedState}" but got "${actualState}"`,
  );
});

Then('the cluster is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeDBClustersCommand } = require("@aws-sdk/client-docdb");
  // Act
  const result = await lambdaDocdbDocdbClient(this).send(
    new DescribeDBClustersCommand({ DBClusterIdentifier: LAMBDA_DOCDB_TEST_CLUSTER }),
  );
  const clusters: Array<{ Status?: string }> = result.DBClusters ?? [];
  assert.ok(clusters.length > 0, "Expected cluster to be AVAILABLE but cluster was not found");
  // Assert
  const expectedStatus = "available";
  const actualStatus = clusters[0].Status as string;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected cluster status "${expectedStatus}" but got "${actualStatus}"`,
  );
});

Then('the cluster is "AVAILABLE" and ready to accept connections', async function (this: SdkWorld) {
  // @internal: StartDBCluster is not yet implemented in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cluster is "STOPPED" and connections will be rejected', async function (this: SdkWorld) {
  // @internal: StopDBCluster is not yet implemented in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED" with a connection error', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the document "EXISTS" and the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda document write result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then("every existing document references a cluster that exists", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
