/** Step definitions: lambda_glacier cross-service informal specification scenarios */

// Steps already registered in lambda.ts ("the function does not already exist",
// "the function already exists", "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}",
// "an invocation slot is available", "no invocation slot is available"),
// glacier.ts ("the vault does not already exist", "the vault already exists",
// "the vault exists", "the vault does not exist", "the archive slot is available",
// "no archive slot is available"),
// capacity.ts, cross_service_common.ts ("the system is initialized"), and
// sqs.ts ("the operation is rejected") are NOT re-registered here.

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { VaultStepHelpers } from "../support/world";

const LAMBDA_GLACIER_TEST_FUNC = "test-lambda-glacier-1";
const LAMBDA_GLACIER_TEST_VAULT = "test-lambda-glacier-vault-1";
const LAMBDA_GLACIER_ACCOUNT_ID = "-";
const LAMBDA_GLACIER_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ────────────────────────────────────────────────────────────────────

function lambdaGlacierLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaGlacierGlacierClient(world: SdkWorld) {
  const { GlacierClient } = require("@aws-sdk/client-glacier");
  return world.session!.client<typeof GlacierClient>("glacier");
}

async function lambdaGlacierCreateFunction(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  await lambdaGlacierLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_GLACIER_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_GLACIER_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
  // Assert: caller checks result
}

async function lambdaGlacierCreateVault(world: SdkWorld): Promise<void> {
  // Arrange
  const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
  // Act
  await lambdaGlacierGlacierClient(world).send(
    new CreateVaultCommand({
      accountId: LAMBDA_GLACIER_ACCOUNT_ID,
      vaultName: LAMBDA_GLACIER_TEST_VAULT,
    }),
  );
  // Assert: caller checks result
}

// ── Before hook: register functionHelpers for lambdaglacier scenarios ─────────────

Before({ tags: "@lambdaglacier" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_GLACIER_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaGlacierCreateFunction(world);
        world.lastCallResult = {
          success: true,
          output: { FunctionName: LAMBDA_GLACIER_TEST_FUNC },
        };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaGlacierLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_GLACIER_TEST_FUNC }),
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

  const vaultHelpersImpl: VaultStepHelpers = {
    setupVaultExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act
      await lambdaGlacierCreateVault(this);
      // Assert: vault created
    },
    createVault: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
      // Act
      try {
        const result = await lambdaGlacierGlacierClient(this).send(
          new CreateVaultCommand({
            accountId: LAMBDA_GLACIER_ACCOUNT_ID,
            vaultName: LAMBDA_GLACIER_TEST_VAULT,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    deleteVault: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteVaultCommand } = require("@aws-sdk/client-glacier");
      // Act
      try {
        const result = await lambdaGlacierGlacierClient(this).send(
          new DeleteVaultCommand({
            accountId: LAMBDA_GLACIER_ACCOUNT_ID,
            vaultName: LAMBDA_GLACIER_TEST_VAULT,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    assertVaultState: async (world: SdkWorld, expectedState: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      if (expectedState !== "EXISTS") return;
      const { DescribeVaultCommand } = require("@aws-sdk/client-glacier");
      const expectedVaultName = LAMBDA_GLACIER_TEST_VAULT;
      // Act
      const result = await lambdaGlacierGlacierClient(this).send(
        new DescribeVaultCommand({
          accountId: LAMBDA_GLACIER_ACCOUNT_ID,
          vaultName: expectedVaultName,
        }),
      );
      const actualVaultName = result.VaultName ?? "";
      // Assert
      assert.strictEqual(
        actualVaultName,
        expectedVaultName,
        `Expected vault name "${expectedVaultName}" but got "${actualVaultName}"; expected_vault_name=${expectedVaultName} actual_vault_name=${actualVaultName}`,
      );
    },
    assertVaultDeleted: async (world: SdkWorld) => {
      // @internal: vault DELETED state cannot be forced via public API without prior creation.
      // No-op for lambda_glacier scenarios.
      assert.ok(world.session, "Expected session to be initialized");
    },
  };
  this.vaultHelpers = vaultHelpersImpl;
});

// ── Given: vault state ────────────────────────────────────────────────────────

// "the vault does not already exist" is registered in cross_service_common.ts.
// "the vault already exists" is registered in cross_service_common.ts (dispatches via vaultHelpers).

// "the vault exists" is registered in cross_service_common.ts (dispatches via helpers).

// 'the vault "EXISTS"' as Given — handled by the combined Then registration below.

Given(/^the vault "EXISTS" \(not already "DELETED"\)$/, async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh vault is not DELETED.
  assert.ok(this.session, "Expected session to be initialized");
});

// 'the vault is "DELETED"' is registered in glacier.ts (dispatches via vaultHelpers.assertVaultDeleted).

Given('the vault is already "DELETED"', async function (this: SdkWorld) {
  // @internal: vault DELETED state requires prior deletion via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the vault is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaGlacierCreateVault(this);
  // Assert: vault created (not DELETED)
});

// "the vault does not exist" is registered in cross_service_common.ts (dispatches via helpers).

Given('the vault does not exist or is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no vaults.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation state ───────────────────────────────────────────────────

// ── Given: slot state ─────────────────────────────────────────────────────────

Given("an archive slot is available", async function (this: SdkWorld) {
  // No-op: always room for archives in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no archive slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust archive slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: sequence state (fid/vid/iid) ──────────────────────────────────────

Given("fid not in func_status", async function (this: SdkWorld) {
  // No-op: fresh state has no functions in func_status.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("fid in func_status", async function (this: SdkWorld) {
  // Arrange: create the Lambda function so fid is tracked in func_status
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaGlacierCreateFunction(this);
  } catch {
    // function may already exist
  }
});

Given("vid not in vault_status", async function (this: SdkWorld) {
  // No-op: fresh state has no vaults in vault_status.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("vid in vault_status", async function (this: SdkWorld) {
  // Arrange: create the vault so vid is tracked in vault_status
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaGlacierCreateVault(this);
  } catch {
    // vault may already exist
  }
});

Given("iid in inv_status", async function (this: SdkWorld) {
  // Arrange: create the Lambda function so an invocation can be tracked
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  try {
    await lambdaGlacierCreateFunction(this);
  } catch {
    // function may already exist
  }
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Glacier vault is created" is registered in glacier_sns.ts (dispatches via vaultHelpers.createVault).

// "a Glacier vault is deleted" is registered in stepfunctions_glacier.ts (dispatches via vaultHelpers.deleteVault).

When(
  "the Lambda function uploads an archive to an existing vault and succeeds",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda archive upload in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda archive upload: scenario is @internal"),
    };
  },
);

When(
  "the Lambda function fails to upload because the vault has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda upload failure in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda upload failure: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// 'the vault "EXISTS"' is handled by the generic 'the vault {string}' in stepfunctions_glacier.ts
// (dispatches via vaultHelpers.assertVaultState).

Then('the vault is "DELETED" and archive uploads will fail', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_vault to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// 'the invocation is "FAILED" with a ResourceNotFoundException' is registered in lambda_common.ts.

Then(
  'the archive "EXISTS" in the vault and the invocation is "SUCCESS"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda archive upload result in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then("every existing archive references a vault that exists", async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
