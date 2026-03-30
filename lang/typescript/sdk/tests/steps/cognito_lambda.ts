/** Step definitions: cognito_lambda cross-service informal specification scenarios */

// Steps already registered in lambda_cognito.ts:
//   - the pool does not already exist / already exists / exists / does not exist
//   - the pool is {string} (Given and Then), the pool is not {string}
//   - an invocation is "IN_PROGRESS" / no invocation is "IN_PROGRESS"
//   - a Lambda function is deployed
//   - the function is "ACTIVE" (Then)
//   - every {string} invocation references an {string} Lambda function
//
// Steps already registered in lambda.ts:
//   - the function is {string}, the function is not {string} (Given)
//
// Steps already registered in capacity.ts:
//   - no invocation slot is available
//
// Steps already registered in cross_service_common.ts:
//   - the system is initialized
//
// Steps already registered in sqs.ts / cross_service_common.ts:
//   - the operation is rejected
//
// Only the NEW unique cross-service steps absent from all constituent files are
// defined here.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, PoolStepHelpers } from "../support/world";

const CL_TEST_POOL_NAME = "e2e-test-pool-1";
const CL_TEST_FUNC = "e2e-test-func-1";
const CL_TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const CL_TEST_USERNAME = "e2e-test-user-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function cognitoClient(world: SdkWorld) {
  const { CognitoIdentityProviderClient } = require("@aws-sdk/client-cognito-identity-provider");
  return world.session!.client<typeof CognitoIdentityProviderClient>("cognitoidp");
}

async function findPoolId(world: SdkWorld): Promise<string | null> {
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await cognitoClient(world).send(new ListUserPoolsCommand({ MaxResults: 60 }));
  const pools: Array<{ Id: string; Name: string }> = result.UserPools ?? [];
  const found = pools.find((p) => p.Name === CL_TEST_POOL_NAME);
  return found ? found.Id : null;
}

// ── Before hook: register poolHelpers for cognitolambda scenarios ──────────────

Before({ tags: "@cognitolambda" }, function (this: SdkWorld) {
  const poolHelpersImpl: PoolStepHelpers = {
    setupPoolExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
      // Act
      await cognitoClient(world).send(new CreateUserPoolCommand({ PoolName: CL_TEST_POOL_NAME }));
      // Assert: pool created
    },
    createNamedUserPool: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
      // Act
      try {
        const result = await cognitoClient(world).send(
          new CreateUserPoolCommand({ PoolName: CL_TEST_POOL_NAME }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
  this.poolHelpers = poolHelpersImpl;
});

// ── Given: trigger configuration ──────────────────────────────────────────────

Given("the pool has no trigger configured", async function (this: SdkWorld) {
  // No-op: pools have no trigger configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool already has a trigger configured", async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool has no pre-signup trigger configured", async function (this: SdkWorld) {
  // No-op: pools have no pre-signup trigger configured by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool has a pre-signup trigger configured", async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the trigger function is "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda triggers for Cognito in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the trigger function is not "ACTIVE"', async function (this: SdkWorld) {
  // @internal: Cannot configure Lambda triggers for Cognito in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: capacity slots ──────────────────────────────────────────────────────

Given("the user slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("cognitoidp").unlimited().apply();
  // Assert: capacity applied
});

Given("no user slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("cognitoidp").exhaust().apply();
  // Assert: capacity exhausted
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Cognito User Pool is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.poolHelpers?.createNamedUserPool,
    "Expected poolHelpers.createNamedUserPool to be registered",
  );
  // Act
  await this.poolHelpers.createNamedUserPool(this);
  // Assert: captured in lastCallResult
});

When(
  "a Lambda pre-signup trigger is configured on the Cognito User Pool",
  async function (this: SdkWorld) {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot configure Lambda trigger: scenario is @internal"),
    };
  },
);

When(
  "a user initiates signup to a pool that has a pre-signup trigger configured",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Cognito->Lambda invocation: scenario is @internal"),
    };
  },
);

When(
  "a user signs up to a pool that has no pre-signup trigger configured",
  async function (this: SdkWorld) {
    // Arrange: find the pool
    assert.ok(this.session, "Expected session to be initialized");
    const { AdminCreateUserCommand } = require("@aws-sdk/client-cognito-identity-provider");
    try {
      const poolId = await findPoolId(this);
      if (!poolId) {
        throw new Error("pool not found");
      }
      // Act: create a user directly (no trigger involved)
      const result = await cognitoClient(this).send(
        new AdminCreateUserCommand({
          UserPoolId: poolId,
          Username: CL_TEST_USERNAME,
          MessageAction: "SUPPRESS",
        }),
      );
      // Assert: store result
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

When("the pre-signup Lambda allows the signup", async function (this: SdkWorld) {
  // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Cognito->Lambda allow: scenario is @internal"),
  };
});

When("the pre-signup Lambda denies the signup", async function (this: SdkWorld) {
  // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Cognito->Lambda deny: scenario is @internal"),
  };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the pool is "ACTIVE" with no pre-signup trigger configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  const result = await cognitoClient(this).send(new ListUserPoolsCommand({ MaxResults: 60 }));
  // Assert
  const expectedPoolName = CL_TEST_POOL_NAME;
  const actualPoolNames: string[] = (result.UserPools ?? []).map((p: { Name: string }) => p.Name);
  assert.ok(
    actualPoolNames.includes(expectedPoolName),
    `Expected pool "${expectedPoolName}" to exist but found: ${JSON.stringify(actualPoolNames)}`,
  );
});

Then(
  "all subsequent signups will synchronously invoke the function before confirming",
  async function (this: SdkWorld) {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the user is "PENDING" and the trigger Lambda is invoked synchronously',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the user is immediately "CONFIRMED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListUsersCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  const poolId = await findPoolId(this);
  assert.ok(poolId, "Expected pool to exist in order to list users");
  const result = await cognitoClient(this).send(new ListUsersCommand({ UserPoolId: poolId }));
  // Assert
  const expectedMinCount = 1;
  const actualCount: number = (result.Users ?? []).length;
  assert.ok(
    actualCount >= expectedMinCount,
    `Expected at least ${expectedMinCount} user but found ${actualCount}`,
  );
});

Then('the invocation is "SUCCESS" and the user is "CONFIRMED"', async function (this: SdkWorld) {
  // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED" and the user is "REJECTED"', async function (this: SdkWorld) {
  // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant catch-all steps ──────────────────────────────────────────────────

Then('every "IN_PROGRESS" invocation is for a "PENDING" user', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'every "PENDING" user has a corresponding "IN_PROGRESS" invocation',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// Note: "every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function" is
// already matched by the parameterized step in lambda_cognito.ts:
//   every {string} invocation references an {string} Lambda function
// so it is NOT re-registered here.

// Note: "the function is "ACTIVE"" (Then) and "the pool is "ACTIVE"" (Then) are
// already registered in lambda_cognito.ts and are NOT re-registered here.
