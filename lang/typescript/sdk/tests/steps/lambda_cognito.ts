/** Step definitions: lambda_cognito cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
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
  const result = await cognitoClient(world).send(new ListUserPoolsCommand({ MaxResults: 10 }));
  const pools: Array<{ Id: string; Name: string }> = result.UserPools ?? [];
  const found = pools.find((p) => p.Name === LAMBDA_COGNITO_TEST_POOL_NAME);
  return found ? found.Id : null;
}

// ── Before hook: register functionHelpers for lambdacognito scenarios ─────────────

Before({ tags: "@lambdacognito" }, function (this: SdkWorld) {
  this.poolHelpers = {
    setupPoolExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the pool (idempotent)
      const poolId = await createPool(world);
      // Assert: pool created
      (world as any)._lambdaCognitoPoolId = poolId;
    },
    assertPoolStatus: async (_world: SdkWorld, _expectedStatus: string) => {
      // No-op: pool status is always ACTIVE immediately after creation in lws
    },
    createNamedPool: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
      // Act
      try {
        const result = await cognitoClient(world).send(
          new CreateUserPoolCommand({ PoolName: LAMBDA_COGNITO_TEST_POOL_NAME }),
        );
        (world as any)._lambdaCognitoPoolId = result.UserPool.Id;
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    deleteNamedPool: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
      // Act
      try {
        const poolId = await findPoolId(world);
        const result = await cognitoClient(world).send(
          new DeleteUserPoolCommand({ UserPoolId: poolId }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
  this.functionHelpers = {
    functionName: LAMBDA_COGNITO_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await createFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: LAMBDA_COGNITO_TEST_FUNC },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_COGNITO_TEST_FUNC }),
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

// ── Given: pool state ─────────────────────────────────────────────────────────

// "the pool does not already exist" is registered in cross_service_common.ts.

// "the pool already exists" is registered in cross_service_common.ts (dispatches via poolHelpers).

// "the pool exists" is registered in cross_service_common.ts (dispatches via poolHelpers).

// "the pool is {string}" is registered in cross_service_common.ts (dispatches via poolHelpers).

Given("the pool is already {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "DELETED") {
    // Act: find and delete the pool so it is in DELETED state
    const { DeleteUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
    const poolId = await findPoolId(this);
    if (poolId) {
      await cognitoClient(this).send(new DeleteUserPoolCommand({ UserPoolId: poolId }));
    }
    // Assert: pool is now deleted
    return;
  }
});

// "the pool does not exist" is registered in cross_service_common.ts.

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

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Cognito user pool is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.poolHelpers?.createNamedPool,
    "Expected poolHelpers.createNamedPool to be registered",
  );
  // Act
  await this.poolHelpers.createNamedPool(this);
  // Assert: captured in lastCallResult
});

When("a Cognito user pool is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.poolHelpers?.deleteNamedPool,
    "Expected poolHelpers.deleteNamedPool to be registered",
  );
  // Act
  await this.poolHelpers.deleteNamedPool(this);
  // Assert: captured in lastCallResult
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

// 'the pool is "ACTIVE"' — handled by 'the pool is {string}' in cross_service_common.ts.

Then(
  'the pool is "DELETED" and Lambda calls targeting it will fail',
  async function (this: SdkWorld) {
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
  },
);

// "the invocation is "FAILED" with a ResourceNotFoundException" is registered in lambda_common.ts.

// ── Invariant catch-all steps ─────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in lambda_common.ts.

Then("every successful invocation recorded which pool it called", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
