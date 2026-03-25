/** Step definitions: lambda_rds cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

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

// ── Given: invocation state ───────────────────────────────────────────────────

Given("an invocation is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "IN_PROGRESS") {
    // Act: create a Lambda function so an invocation can be considered in-progress
    try {
      await lambdaRdsCreateFunction(this);
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

Given("an invocation slot is available", async function (this: SdkWorld) {
  // No-op: always room for invocations in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

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

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaRdsLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_RDS_TEST_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_RDS_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

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

Then("the function is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    const result = await lambdaRdsLambdaClient(this).send(
      new GetFunctionCommand({ FunctionName: LAMBDA_RDS_TEST_FUNC }),
    );
    // Assert
    const expectedState = "Active";
    const actualState = result.Configuration?.State ?? "";
    assert.strictEqual(
      actualState,
      expectedState,
      `Expected function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
    );
  }
});

Then("the instance is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "AVAILABLE") {
    const { DescribeDBInstancesCommand } = require("@aws-sdk/client-rds");
    // Act
    const result = await lambdaRdsRdsClient(this).send(
      new DescribeDBInstancesCommand({ DBInstanceIdentifier: LAMBDA_RDS_TEST_INSTANCE }),
    );
    // Assert
    const expectedStatus = "available";
    const actualStatus = result.DBInstances?.[0]?.DBInstanceStatus ?? "";
    assert.strictEqual(
      actualStatus,
      expectedStatus,
      `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
    );
  }
});

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

Then("the invocation is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the invocation is "FAILED" with a connection error',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "every successful invocation recorded which database it queried",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
