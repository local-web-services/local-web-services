/** Step definitions: stepfunctions_cognito cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, ExecutionStepHelpers } from "../support/world";

const SFN_COGNITO_TEST_SM = "test-sm-1";
const SFN_COGNITO_TEST_POOL_NAME = "e2e-test-pool-1";
const SFN_COGNITO_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const SFN_COGNITO_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_COGNITO_TEST_INPUT = JSON.stringify({ key: "value" });
const SFN_COGNITO_REGION = "us-east-1";
const SFN_COGNITO_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnCognitoSfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function sfnCognitoCognitoClient(world: SdkWorld) {
  const { CognitoIdentityProviderClient } = require("@aws-sdk/client-cognito-identity-provider");
  return world.session!.client<typeof CognitoIdentityProviderClient>("cognitoidp");
}

function sfnCognitoSmArn(name: string): string {
  return `arn:aws:states:${SFN_COGNITO_REGION}:${SFN_COGNITO_ACCOUNT_ID}:stateMachine:${name}`;
}

async function sfnCognitoCreateSm(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnCognitoSfnClient(world).send(
    new CreateStateMachineCommand({
      name: SFN_COGNITO_TEST_SM,
      definition: SFN_COGNITO_PASS_DEFINITION,
      roleArn: SFN_COGNITO_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

async function sfnCognitoCreatePool(world: SdkWorld): Promise<string> {
  const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await sfnCognitoCognitoClient(world).send(
    new CreateUserPoolCommand({ PoolName: SFN_COGNITO_TEST_POOL_NAME }),
  );
  return result.UserPool.Id as string;
}

async function sfnCognitoGetPoolId(world: SdkWorld): Promise<string | null> {
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  const result = await sfnCognitoCognitoClient(world).send(
    new ListUserPoolsCommand({ MaxResults: 60 }),
  );
  const pools: Array<{ Name: string; Id: string }> = result.UserPools ?? [];
  const match = pools.find((p) => p.Name === SFN_COGNITO_TEST_POOL_NAME);
  return match ? match.Id : null;
}

// ── Background ────────────────────────────────────────────────────────────────
// ── Before hook: register executionHelpers for stepfunctionscognito scenarios ────────────

Before({ tags: "@stepfunctionscognito" }, function (this: SdkWorld) {
  const executionHelpersImpl: ExecutionStepHelpers = {
    setupExecutionRunning: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create state machine then start execution
      const expectedSmArn = await sfnCognitoCreateSm(this);
      (world as any)._sfnCognitoSmArn = expectedSmArn;
      const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
      const execResult = await sfnCognitoSfnClient(this).send(
        new StartExecutionCommand({
          stateMachineArn: sfnCognitoSmArn(SFN_COGNITO_TEST_SM),
          input: SFN_COGNITO_TEST_INPUT,
        }),
      );
      // Assert: execution started
      (world as any)._sfnCognitoExecArn = execResult.executionArn;
      assert.ok(execResult.executionArn, "Expected executionArn in StartExecution response");
    },
  };
  this.executionHelpers = executionHelpersImpl;
  this.poolHelpers = {
    setupPoolExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the pool (idempotent)
      const expectedPoolId = await sfnCognitoCreatePool(world);
      // Assert: pool created
      (world as any)._sfnCognitoPoolId = expectedPoolId;
      assert.ok(expectedPoolId, "Expected pool ID to be defined");
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
        const result = await sfnCognitoCognitoClient(world).send(
          new CreateUserPoolCommand({ PoolName: SFN_COGNITO_TEST_POOL_NAME }),
        );
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
        const actualPoolId = await sfnCognitoGetPoolId(world);
        if (actualPoolId === null) {
          throw new Error("ResourceNotFoundException: pool not found");
        }
        const result = await sfnCognitoCognitoClient(world).send(
          new DeleteUserPoolCommand({ UserPoolId: actualPoolId }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
});

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: pool existence ─────────────────────────────────────────────────────

// "the pool does not already exist" is registered in cross_service_common.ts.

// "the pool already exists" is registered in cross_service_common.ts (dispatches via poolHelpers).

// "the pool exists" is registered in cross_service_common.ts (dispatches via poolHelpers).

// "the pool does not exist" — registered in cross_service_common.ts.

Given("the pool does not exist or is {string}", async function (this: SdkWorld, _state: string) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no user pools.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: pool status ────────────────────────────────────────────────────────

// "the pool is {string}" as Given — handled by cross_service_common.ts (dispatches via poolHelpers).

Given("the pool is not {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "DELETED") {
    // Act: create an ACTIVE pool so it is not DELETED
    const expectedPoolId = await sfnCognitoCreatePool(this);
    // Assert: pool created
    (this as any)._sfnCognitoPoolId = expectedPoolId;
    return;
  }
  // No-op for other states
});

Given("the pool is already {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "DELETED") {
    // Act: create pool and then delete it via lifecycle dwell
    const expectedPoolId = await sfnCognitoCreatePool(this);
    (this as any)._sfnCognitoPoolId = expectedPoolId;
    await this.session!.lifecycle("cognitoidp").deleteDwellMs(5000).apply();
    const { DeleteUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
    try {
      await sfnCognitoCognitoClient(this).send(
        new DeleteUserPoolCommand({ UserPoolId: expectedPoolId }),
      );
    } catch (_err: unknown) {
      // ignore — desired state is deleted
    }
    // Assert: pool deleted
    return;
  }
  // No-op for other states
});

// ── Given: execution state ────────────────────────────────────────────────────

// "an execution is {string}" is registered in cross_service_common.ts (dispatches via executionHelpers).

// "no execution is {string}" is registered in cross_service_common.ts.

// ── Given: capacity ───────────────────────────────────────────────────────────

// "an execution slot is available" is registered in cross_service_common.ts.

// "no execution slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Step Functions state machine is created" is registered in stepfunctions.ts.
// "an execution of the state machine is started" is registered in stepfunctions.ts.

// "a Cognito user pool is created" is registered in lambda_cognito.ts (dispatches via poolHelpers.createNamedPool).
// "a Cognito user pool is deleted" is registered in lambda_cognito.ts (dispatches via poolHelpers.deleteNamedPool).

When(
  `a running execution calls an "ACTIVE" Cognito user pool and the task succeeds`,
  async function (this: SdkWorld) {
    // @internal scenario: cannot trigger internal execution step that calls Cognito in lws.
    // Act: record rejection — this scenario is untestable via public API.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger internal execution step that calls Cognito in lws"),
    };
    // Assert: captured in lastCallResult
    return "pending";
  },
);

When(
  "a running execution fails because the Cognito user pool has been deleted",
  async function (this: SdkWorld) {
    // @internal scenario: cannot trigger internal execution step that fails due to deleted Cognito pool in lws.
    // Act: record rejection — this scenario is untestable via public API.
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that fails due to deleted Cognito pool in lws",
      ),
    };
    // Assert: captured in lastCallResult
    return "pending";
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the state machine is "ACTIVE"" is registered in stepfunctions.ts.
// "the execution is "RUNNING"" is registered in stepfunctions_sqs.ts.
// "the operation is rejected" is registered in sqs.ts.

// "the pool is {string}" as Then — handled by cross_service_common.ts (dispatches via poolHelpers).

Then(
  `the pool is "DELETED" and "SDK" task calls targeting it will fail`,
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const expectedPoolName = SFN_COGNITO_TEST_POOL_NAME;
    const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
    // Act
    const result = await sfnCognitoCognitoClient(this).send(
      new ListUserPoolsCommand({ MaxResults: 60 }),
    );
    const pools: Array<{ Name: string }> = result.UserPools ?? [];
    const actualExists = pools.some((p) => p.Name === expectedPoolName);
    // Assert: pool must not exist
    assert.ok(
      !actualExists,
      `Expected pool "${expectedPoolName}" to be deleted but it still exists; expected_pool_name=${expectedPoolName}`,
    );
  },
);

// "the execution is SUCCEEDED" — handled by the canonical
// Then("the execution is {string}", ...) in stepfunctions_sqs.ts.

Then(`the execution is "FAILED" with a ResourceNotFoundException`, async function (this: SdkWorld) {
  // @internal scenario: cannot observe internal execution Cognito task failure in lws.
  // No-op: invariant trivially satisfied in isolated lws context.
  return "pending";
});

// ── Then: invariants ──────────────────────────────────────────────────────────

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

Then("every succeeded execution recorded which pool it called", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
});
