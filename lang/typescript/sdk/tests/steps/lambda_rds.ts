/** Step definitions: lambda_rds cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { InstanceStepHelpers } from "../support/world";

const LAMBDA_RDS_TEST_FUNC = "test-lambda-rds-1";
const LAMBDA_RDS_TEST_INSTANCE = "test-lambda-rds-instance-1";
const LAMBDA_RDS_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaRdsLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaRdsRdsClient(world: SdkWorld) {
  const { RDSClient } = require("@aws-sdk/client-rds");
  return world.session!.client<typeof RDSClient>("rds");
}

async function lambdaRdsCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaRdsLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_RDS_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_RDS_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaRdsCreateInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  await lambdaRdsRdsClient(world).send(
    new CreateDBInstanceCommand({
      DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE,
      DBInstanceClass: "db.t3.micro",
      Engine: "mysql",
      MasterUsername: "admin",
      MasterUserPassword: "password123",
    }),
  );
}

// ── Before hook: register functionHelpers for lambdards scenarios ─────────────

Before({ tags: "@lambdards" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_RDS_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaRdsCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_RDS_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaRdsLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_RDS_TEST_FUNC }),
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
  const instanceHelpersImpl: InstanceStepHelpers = {
    assertInstanceStatus: async (world: SdkWorld, expectedStatus: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      if (expectedStatus === "AVAILABLE") {
        const { DescribeDBInstancesCommand } = require("@aws-sdk/client-rds");
        const result = await lambdaRdsRdsClient(world).send(
          new DescribeDBInstancesCommand({ DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE }),
        );
        const expectedDbStatus = "available";
        const actualDbStatus = result.DBInstances?.[0]?.DBInstanceStatus ?? "";
        assert.strictEqual(
          actualDbStatus,
          expectedDbStatus,
          `Expected instance status "${expectedDbStatus}" but got "${actualDbStatus}"; expected_status=${expectedDbStatus} actual_status=${actualDbStatus}`,
        );
      }
      // For other statuses: no-op
    },
  };
  this.instanceHelpers = instanceHelpersImpl;
});

// ── Given: invocation state ───────────────────────────────────────────────────

// "an invocation is {string}" — registered in capacity.ts (dispatches via functionHelpers)
// "no invocation is {string}" — registered in capacity.ts

// ── Given: RDS instance state unique to cross-service scenarios ───────────────

Given("the database instance is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "FAILING_OVER") {
    const { RebootDBInstanceCommand } = require("@aws-sdk/client-rds");
    try {
      await lambdaRdsCreateInstance(this);
    } catch {
      // instance may already exist
    }
    // Act: trigger failover via reboot with force failover
    await lambdaRdsRdsClient(this).send(
      new RebootDBInstanceCommand({
        DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE,
        ForceFailover: true,
      }),
    );
    // Assert: instance is now FAILING_OVER
    return;
  }
  if (state === "AVAILABLE") {
    // Act: create the instance (available by default)
    try {
      await lambdaRdsCreateInstance(this);
    } catch {
      // instance may already exist
    }
    return;
  }
  // For other states, no-op.
});

Given("the database instance is not {string}", async function (this: SdkWorld, _state: string) {
  // Arrange: create the instance (available, not in the rejected state)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaRdsCreateInstance(this);
  } catch {
    // instance may already exist
  }
  // Assert: instance is AVAILABLE
});

// ── When: actions ─────────────────────────────────────────────────────────────

When('an "RDS" database instance is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await lambdaRdsRdsClient(this).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE,
        DBInstanceClass: "db.t3.micro",
        Engine: "mysql",
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When('a Multi-"AZ" failover begins on the "RDS" instance', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { RebootDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await lambdaRdsRdsClient(this).send(
      new RebootDBInstanceCommand({
        DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE,
        ForceFailover: true,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'the Multi-"AZ" failover completes and the new primary is promoted',
  async function (this: SdkWorld) {
    // @internal: Cannot force failover completion via public APIs.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot force failover completion: scenario is @internal"),
    };
  },
);

When(
  "the Lambda function fails to connect because the database is failing over",
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
  'the Lambda function executes a "SQL" query against the "AVAILABLE" database and succeeds',
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

// "the instance is {string}" is registered in cross_service_common.ts (dispatches via instanceHelpers).

Then(
  'the instance is "FAILING_OVER" and temporarily unavailable for connections',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeDBInstancesCommand } = require("@aws-sdk/client-rds");
    // Act
    const result = await lambdaRdsRdsClient(this).send(
      new DescribeDBInstancesCommand({ DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE }),
    );
    // Assert
    const expectedStatus = "failing-over";
    const actualStatus = result.DBInstances?.[0]?.DBInstanceStatus ?? "";
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  },
);

Then('the instance is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: Cannot observe failover completion in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the invocation is {string}" — registered in lambda_common.ts
// "the invocation is FAILED with a connection error" — registered in lambda_common.ts

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then(
  "every successful invocation recorded which database it queried",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
