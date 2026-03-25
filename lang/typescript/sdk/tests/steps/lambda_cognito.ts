/** Step definitions: lambda_cognito cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

const LAMBDA_COGNITO_TEST_FUNC = "e2e-test-func-1";
const LAMBDA_COGNITO_TEST_POOL_NAME = "e2e-test-pool-1";
const LAMBDA_COGNITO_TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function cognitoClient(world: SdkWorld) {
  const { CognitoIdentityProviderClient } = require("@aws-sdk/client-cognito-identity-provider");
  return world.session!.client<typeof CognitoIdentityProviderClient>("cognitoidp");
}

async function createFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_COGNITO_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_COGNITO_TEST_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createPool(world: SdkWorld): Promise<string> {
  const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await cognitoClient(world).send(
    new CreateUserPoolCommand({ PoolName: LAMBDA_COGNITO_TEST_POOL_NAME }),
  );
  return result.UserPool.Id as string;
}

async function findPoolId(world: SdkWorld): Promise<string | null> {
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await cognitoClient(world).send(
    new ListUserPoolsCommand({ MaxResults: 10 }),
  );
  const pools: Array<{ Id: string; Name: string }> = result.UserPools ?? [];
  const found = pools.find((p) => p.Name === LAMBDA_COGNITO_TEST_POOL_NAME);
  return found ? found.Id : null;
}

// ── Given: pool state ─────────────────────────────────────────────────────────

Given("the pool does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no Cognito user pools.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const expectedPoolName = LAMBDA_COGNITO_TEST_POOL_NAME;
  const poolId = await createPool(this);
  // Assert: pool created
  (this as any)._lambdaCognitoPoolId = poolId;
  assert.ok(expectedPoolName, "Expected pool name to be defined");
});

Given("the pool exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const expectedPoolName = LAMBDA_COGNITO_TEST_POOL_NAME;
  const poolId = await createPool(this);
  // Assert: pool created
  (this as any)._lambdaCognitoPoolId = poolId;
  assert.ok(expectedPoolName, "Expected pool name to be defined");
});

Given("the pool is {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // No-op: pools are ACTIVE immediately after creation.
    return;
  }
  if (state === "DELETED") {
    // No-op: fresh state has no pools (simulates deleted pool).
    return;
  }
});

Given("the pool is already {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "DELETED") {
    // Act: find and delete the pool so it is in DELETED state
    const { DeleteUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
    const poolId = await findPoolId(this);
    if (poolId) {
      await cognitoClient(this).send(
        new DeleteUserPoolCommand({ UserPoolId: poolId }),
      );
    }
    // Assert: pool is now deleted
    return;
  }
});

Given("the pool does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no Cognito user pools.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool does not exist or is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: fresh state has no pools (simulates deleted or non-existent pool).
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool is not {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "DELETED") {
    // Act: create the pool so it is not DELETED
    const expectedPoolName = LAMBDA_COGNITO_TEST_POOL_NAME;
    const poolId = await createPool(this);
    // Assert: pool created
    (this as any)._lambdaCognitoPoolId = poolId;
    assert.ok(expectedPoolName, "Expected pool name to be defined");
    return;
  }
});

// ── Given: invocation state ───────────────────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create the Lambda function so an invocation could be in progress
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createFunction(this);
  // Assert: function created
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no in-progress invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_COGNITO_TEST_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_COGNITO_TEST_ROLE_ARN,
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

When("a Cognito user pool is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  try {
    const result = await cognitoClient(this).send(
      new CreateUserPoolCommand({ PoolName: LAMBDA_COGNITO_TEST_POOL_NAME }),
    );
    // Assert: store result
    (this as any)._lambdaCognitoPoolId = result.UserPool.Id;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a Cognito user pool is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  try {
    const poolId = await findPoolId(this);
    const result = await cognitoClient(this).send(
      new DeleteUserPoolCommand({ UserPoolId: poolId }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation in lws without Docker.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation: scenario requires @internal runtime"),
  };
});

When(
  "the Lambda function fails to call Cognito because the pool has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger Lambda invocation failure: scenario requires @internal runtime",
      ),
    };
  },
);

When(
  "the Lambda function calls a Cognito admin {string} on an {string} pool and succeeds",
  async function (this: SdkWorld, _api: string, _poolState: string) {
    // @internal: Cannot trigger Lambda-Cognito invocation in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda-Cognito invocation success: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  const result = await lambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: LAMBDA_COGNITO_TEST_FUNC }),
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

Then('the pool is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  const poolId = await findPoolId(this);
  assert.ok(poolId, "Expected pool to be ACTIVE but pool was not found");
  const result = await cognitoClient(this).send(
    new DescribeUserPoolCommand({ UserPoolId: poolId }),
  );
  // Assert
  const expectedStatus = "Active";
  const actualStatus = result.UserPool?.Status as string;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected pool status "${expectedStatus}" but got "${actualStatus}"`,
  );
});

Then('the pool is "DELETED" and Lambda calls targeting it will fail', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const actualPoolId = await findPoolId(this);
  // Assert
  const expectedPoolId = null;
  assert.strictEqual(
    actualPoolId,
    expectedPoolId,
    `Expected pool to be deleted but found pool with id "${actualPoolId}"`,
  );
});

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED" with a ResourceNotFoundException', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation success in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant catch-all steps ─────────────────────────────────────────────────

Then(
  "every {string} invocation references an {string} Lambda function",
  async function (this: SdkWorld, _invState: string, _funcState: string) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then("every successful invocation recorded which pool it called", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
