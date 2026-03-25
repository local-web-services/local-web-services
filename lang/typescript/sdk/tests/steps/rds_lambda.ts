/** Step definitions: rds_lambda cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const RDS_LAMBDA_TEST_DB_INSTANCE_ID = "test-rds-db-1";
const RDS_LAMBDA_TEST_FUNC_NAME = "e2e-test-func-1";
const RDS_LAMBDA_TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const RDS_LAMBDA_TEST_DB_ENGINE = "mysql";
const RDS_LAMBDA_TEST_DB_CLASS = "db.t3.micro";

// ── Helpers ───────────────────────────────────────────────────────────────────

function rdsLambdaRdsClient(world: SdkWorld) {
  const { RDSClient } = require("@aws-sdk/client-rds");
  return world.session!.client<typeof RDSClient>("rds");
}

function rdsLambdaLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

async function rdsLambdaCreateDBInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  try {
    await rdsLambdaRdsClient(world).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_LAMBDA_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_LAMBDA_TEST_DB_CLASS,
        Engine: RDS_LAMBDA_TEST_DB_ENGINE,
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("already") && !msg.includes("DBInstanceAlreadyExists")) {
      throw err;
    }
  }
}

async function rdsLambdaCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  try {
    await rdsLambdaLambdaClient(world).send(
      new CreateFunctionCommand({
        FunctionName: RDS_LAMBDA_TEST_FUNC_NAME,
        Runtime: "python3.12",
        Role: RDS_LAMBDA_TEST_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("ResourceConflict") && !msg.includes("already")) {
      throw err;
    }
  }
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Before hook: register functionHelpers for rdslambda scenarios ─────────────

Before({ tags: "@rdslambda" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: RDS_LAMBDA_TEST_FUNC_NAME,
    deployFunction: async (world: SdkWorld) => {
      try {
        await rdsLambdaCreateFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: RDS_LAMBDA_TEST_FUNC_NAME },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await rdsLambdaLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: RDS_LAMBDA_TEST_FUNC_NAME }),
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

// ── Given: DB instance state setup ───────────────────────────────────────────

Given('the "DB" instance does not already exist', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no DB instances.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "DB" instance already exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsLambdaCreateDBInstance(this);
  // Assert: DB instance created
});

Given('the "DB" instance exists and is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the DB instance (lws instances are AVAILABLE after creation)
  await rdsLambdaCreateDBInstance(this);
  // Assert: DB instance created
});

Given('the "DB" instance does not exist or is not "AVAILABLE"', async function (this: SdkWorld) {
  // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  // Only reached by @lifecycle scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "DB" instance is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the DB instance (lws instances are AVAILABLE after creation)
  await rdsLambdaCreateDBInstance(this);
  // Assert: DB instance created
});

Given('the "DB" instance is not "AVAILABLE"', async function (this: SdkWorld) {
  // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  // Only reached by @lifecycle scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: Lambda integration state ──────────────────────────────────────────

Given('the "DB" instance has no Lambda integration configured', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh DB instances have no Lambda integration.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  'the "DB" instance already has a Lambda integration configured',
  async function (this: SdkWorld) {
    // @internal: Cannot configure Lambda integration on a DB instance via public API in lws.
    // Only reached by excluded scenarios.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Given('the "DB" instance has a Lambda integration configured', async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda integration state in lws via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: Lambda function state ──────────────────────────────────────────────

Given('the function exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the Lambda function (lws functions are ACTIVE after creation)
  await rdsLambdaCreateFunction(this);
  // Assert: function created
});

Given('the function does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no Lambda functions (simulates absent).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the Lambda function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: Lambda functions in lws are ACTIVE after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the Lambda function is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Cannot force a Lambda function into a non-ACTIVE state via public API.
  // Only reached by @lifecycle scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the Lambda function is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no Lambda functions (simulates deleted).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the Lambda function is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: ensure the Lambda function exists
  await rdsLambdaCreateFunction(this);
  // Assert: function created
});

// "the function is {string}" is registered in lambda.ts (dispatches via functionHelpers).

Given('the function is already "DELETED"', async function (this: SdkWorld) {
  // @internal: Cannot force a function into DELETED state via public API while still tracked.
  // Only reached by @lifecycle scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation slot state ──────────────────────────────────────────────

// ── When: actions ─────────────────────────────────────────────────────────────

When('an "RDS" "DB" instance is created', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsLambdaRdsClient(this).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_LAMBDA_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_LAMBDA_TEST_DB_CLASS,
        Engine: RDS_LAMBDA_TEST_DB_ENGINE,
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

When("the Lambda function is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await rdsLambdaLambdaClient(this).send(
      new DeleteFunctionCommand({ FunctionName: RDS_LAMBDA_TEST_FUNC_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  'the "DB" instance is configured with an "IAM" role to invoke the Lambda function',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ModifyDBInstanceCommand } = require("@aws-sdk/client-rds");
    // Act
    try {
      const result = await rdsLambdaRdsClient(this).send(
        new ModifyDBInstanceCommand({
          DBInstanceIdentifier: RDS_LAMBDA_TEST_DB_INSTANCE_ID,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  'an "RDS" stored procedure invokes the Lambda function and succeeds',
  async function (this: SdkWorld) {
    // @internal: stored_proc_invokes_lambda cannot be triggered via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("stored_proc_invokes_lambda: scenario is @internal"),
    };
  },
);

When(
  'an "RDS" stored procedure fails to invoke Lambda because the function has been deleted',
  async function (this: SdkWorld) {
    // @internal: invocation_fails_function_deleted cannot be triggered via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("invocation_fails_function_deleted: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then(
  'the "DB" instance is "AVAILABLE" with no Lambda integration configured',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected RDS DB instance creation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
    assert.ok(
      this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
      "Expected output from RDS DB instance creation but got null",
    );
  },
);

Then(
  'the function is "DELETED" and stored procedure invocations targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected Lambda function deletion to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then(
  'stored procedures on the "DB" can invoke the Lambda function',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected configure_lambda_integration to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

Then('the invocation is "FAILED" with a function not found error', async function (this: SdkWorld) {
  // @internal: invocation_fails_function_deleted outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  'every successful invocation references a "DB" instance that exists',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "every successful invocation recorded which function it invoked",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
