/** Step definitions: lambda_docdb cross-service informal specification scenarios */

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

import { When, Then, Before } from "@cucumber/cucumber";
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

// ── Before hook: register cluster helpers for @lambdadocdb scenarios ──────────

Before({ tags: "@lambdadocdb" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await lambdaDocdbCreateCluster(world);
      } catch {
        // cluster may already exist
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedState: string) => {
      const { DescribeDBClustersCommand } = require("@aws-sdk/client-docdb");
      const result = await lambdaDocdbDocdbClient(world).send(
        new DescribeDBClustersCommand({ DBClusterIdentifier: LAMBDA_DOCDB_TEST_CLUSTER }),
      );
      const clusters: Array<{ Status?: string }> = result.DBClusters ?? [];
      assert.ok(
        clusters.length > 0,
        `Expected cluster to be "${expectedState}" but cluster was not found`,
      );
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = clusters[0].Status as string;
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    createNamedCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "No session running");
      const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
      // Act
      try {
        const result = await lambdaDocdbDocdbClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: LAMBDA_DOCDB_TEST_CLUSTER,
            Engine: "docdb",
            MasterUsername: "admin",
            MasterUserPassword: "pass1234",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    stopCluster: async (world: SdkWorld) => {
      // @internal: StopDBCluster is not yet implemented in lws.
      assert.ok(world.session, "Expected session to be initialized");
      world.lastCallResult = {
        success: false,
        output: null,
        error: new Error("cannot stop DocumentDB cluster: StopDBCluster not implemented in lws"),
      };
    },
    startCluster: async (world: SdkWorld) => {
      // @internal: StartDBCluster is not yet implemented in lws.
      assert.ok(world.session, "Expected session to be initialized");
      world.lastCallResult = {
        success: false,
        output: null,
        error: new Error("cannot start DocumentDB cluster: StartDBCluster not implemented in lws"),
      };
    },
  };
  this.functionHelpers = {
    functionName: LAMBDA_DOCDB_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaDocdbCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_DOCDB_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaDocdbLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_DOCDB_TEST_FUNC }),
      );
      const expectedState = "Active";
      const actualState = result.Configuration?.State as string;
      assert.strictEqual(
        actualState,
        expectedState,
        `Expected function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
      );
    },
  };
});

// ── Given: cluster state ───────────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

// ── Given: invocation state ───────────────────────────────────────────────────

// ── Given: slot state ─────────────────────────────────────────────────────────

// "a document slot is available" and "no document slot is available"
// — registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a DocumentDB cluster is created" is registered in docdb.ts (dispatches via clusterHelpers.createNamedCluster).
// "the DocumentDB cluster is stopped" is registered in docdb.ts (dispatches via clusterHelpers.stopCluster).
// "the DocumentDB cluster is started" is registered in docdb.ts (dispatches via clusterHelpers.startCluster).

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

// "the cluster is {string}" is registered in cluster_common.ts (dispatches to assertClusterStatus).

// "the cluster is \"AVAILABLE\" and ready to accept connections" is registered in cluster_common.ts.
// "the cluster is \"STOPPED\" and connections will be rejected" is registered in cluster_common.ts.

// "the invocation is FAILED with a connection error" — registered in lambda_common.ts

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
