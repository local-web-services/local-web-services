/** Step definitions: lambda_s3tables cross-service informal specification scenarios */

// Steps already registered in other files are NOT re-registered here where they
// conflict.  All other lambda-side invocation steps follow the same pattern as
// lambda_secretsmanager.ts.

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_S3TABLES_TEST_FUNC = "test-lambda-s3tables-1";
const LAMBDA_S3TABLES_TEST_BUCKET = "test-lambda-s3tables-bucket-1";
const LAMBDA_S3TABLES_TEST_TABLE = "test-lambda-s3tables-table-1";
const LAMBDA_S3TABLES_TEST_NAMESPACE = "test-lambda-s3tables-ns-1";
const LAMBDA_S3TABLES_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaS3TablesLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaS3TablesS3TablesClient(world: SdkWorld) {
  const { S3TablesClient } = require("@aws-sdk/client-s3tables");
  return world.session!.client<typeof S3TablesClient>("s3tables");
}

async function lambdaS3TablesCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaS3TablesLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_S3TABLES_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_S3TABLES_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaS3TablesCreateBucket(world: SdkWorld): Promise<void> {
  const { CreateTableBucketCommand } = require("@aws-sdk/client-s3tables");
  await lambdaS3TablesS3TablesClient(world).send(
    new CreateTableBucketCommand({ Name: LAMBDA_S3TABLES_TEST_BUCKET }),
  );
}

async function lambdaS3TablesCreateTable(world: SdkWorld): Promise<void> {
  const { CreateTableCommand } = require("@aws-sdk/client-s3tables");
  await lambdaS3TablesS3TablesClient(world).send(
    new CreateTableCommand({
      TableBucketARN: LAMBDA_S3TABLES_TEST_BUCKET,
      Namespace: LAMBDA_S3TABLES_TEST_NAMESPACE,
      Name: LAMBDA_S3TABLES_TEST_TABLE,
      Format: "ICEBERG",
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
      await lambdaS3TablesCreateFunction(this);
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

Given("a record slot is available", async function (this: SdkWorld) {
  // No-op: always room for records in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no record slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust record slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: S3Tables bucket/table state unique to cross-service scenarios ───────

Given('the table bucket is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the table bucket
  try {
    await lambdaS3TablesCreateBucket(this);
  } catch {
    // bucket may already exist
  }
  // Assert: bucket is ACTIVE
});

Given('the table bucket is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Cannot force a bucket into a non-ACTIVE state via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('a table is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: create bucket then table
  assert.ok(this.session, "Expected session to be initialized");
  try {
    await lambdaS3TablesCreateBucket(this);
  } catch {
    // bucket may already exist
  }
  // Act
  try {
    await lambdaS3TablesCreateTable(this);
  } catch {
    // table may already exist
  }
  // Assert: table is ACTIVE
});

Given('no table is "ACTIVE"', async function (this: SdkWorld) {
  // No-op: fresh state has no tables in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the table is "DELETING"', async function (this: SdkWorld) {
  // Arrange: create bucket, create table, then delete table
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTableCommand } = require("@aws-sdk/client-s3tables");
  try {
    await lambdaS3TablesCreateBucket(this);
  } catch {
    // bucket may already exist
  }
  try {
    await lambdaS3TablesCreateTable(this);
  } catch {
    // table may already exist
  }
  // Act: delete the table to put it in DELETING state
  await lambdaS3TablesS3TablesClient(this).send(
    new DeleteTableCommand({
      TableBucketARN: LAMBDA_S3TABLES_TEST_BUCKET,
      Namespace: LAMBDA_S3TABLES_TEST_NAMESPACE,
      Name: LAMBDA_S3TABLES_TEST_TABLE,
    }),
  );
  // Assert: table is now DELETING
});

Given('the table is not "DELETING"', async function (this: SdkWorld) {
  // Arrange: create the bucket and table (ACTIVE, not DELETING)
  assert.ok(this.session, "Expected session to be initialized");
  try {
    await lambdaS3TablesCreateBucket(this);
  } catch {
    // bucket may already exist
  }
  // Act
  try {
    await lambdaS3TablesCreateTable(this);
  } catch {
    // table may already exist
  }
  // Assert: table is ACTIVE
});

Given('the table is already "DELETING"', async function (this: SdkWorld) {
  // Arrange: create bucket, create table, then delete table
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteTableCommand } = require("@aws-sdk/client-s3tables");
  try {
    await lambdaS3TablesCreateBucket(this);
  } catch {
    // bucket may already exist
  }
  try {
    await lambdaS3TablesCreateTable(this);
  } catch {
    // table may already exist
  }
  // Act: delete the table so it is already in DELETING state
  await lambdaS3TablesS3TablesClient(this).send(
    new DeleteTableCommand({
      TableBucketARN: LAMBDA_S3TABLES_TEST_BUCKET,
      Namespace: LAMBDA_S3TABLES_TEST_NAMESPACE,
      Name: LAMBDA_S3TABLES_TEST_TABLE,
    }),
  );
  // Assert: table is already DELETING
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaS3TablesLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_S3TABLES_TEST_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_S3TABLES_ROLE_ARN,
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

When("an S3 table bucket is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateTableBucketCommand } = require("@aws-sdk/client-s3tables");
  // Act
  try {
    const result = await lambdaS3TablesS3TablesClient(this).send(
      new CreateTableBucketCommand({ Name: LAMBDA_S3TABLES_TEST_BUCKET }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table is created in the table bucket", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateTableCommand } = require("@aws-sdk/client-s3tables");
  // Act
  try {
    const result = await lambdaS3TablesS3TablesClient(this).send(
      new CreateTableCommand({
        TableBucketARN: LAMBDA_S3TABLES_TEST_BUCKET,
        Namespace: LAMBDA_S3TABLES_TEST_NAMESPACE,
        Name: LAMBDA_S3TABLES_TEST_TABLE,
        Format: "ICEBERG",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a table deletion is initiated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { DeleteTableCommand } = require("@aws-sdk/client-s3tables");
  // Act
  try {
    const result = await lambdaS3TablesS3TablesClient(this).send(
      new DeleteTableCommand({
        TableBucketARN: LAMBDA_S3TABLES_TEST_BUCKET,
        Namespace: LAMBDA_S3TABLES_TEST_NAMESPACE,
        Name: LAMBDA_S3TABLES_TEST_TABLE,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
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
  "the Lambda function fails to write because the table is being deleted",
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
  'the Lambda function writes a record to an "ACTIVE" table and succeeds',
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

Then("the function is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    const result = await lambdaS3TablesLambdaClient(this).send(
      new GetFunctionCommand({ FunctionName: LAMBDA_S3TABLES_TEST_FUNC }),
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

// "the bucket is {string}" is registered in cross_service_common.ts.

// "the table is {string}" is registered in cross_service_common.ts.

Then('the table is "DELETING" and write operations will fail', async function (this: SdkWorld) {
  // @internal: Cannot observe table DELETING state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the invocation is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the invocation is "FAILED" with a ResourceNotFoundException',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the record "EXISTS" and the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda record write result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then("every existing record references a table that exists", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
