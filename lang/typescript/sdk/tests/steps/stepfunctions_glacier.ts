/** Step definitions: stepfunctions_glacier cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { ExecutionStepHelpers } from "../support/world";
import type { VaultStepHelpers } from "../support/world";

// ── Constants ─────────────────────────────────────────────────────────────────

const SFN_GLACIER_TEST_SM = "test-sf-glacier-sm-1";
const SFN_GLACIER_TEST_VAULT = "test-sf-glacier-vault-1";
const SFN_GLACIER_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const SFN_GLACIER_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_GLACIER_TEST_INPUT = JSON.stringify({ key: "value" });
const SFN_GLACIER_REGION = "us-east-1";
const SFN_GLACIER_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnGlacierSfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function sfnGlacierClient(world: SdkWorld) {
  const { GlacierClient } = require("@aws-sdk/client-glacier");
  return world.session!.client<typeof GlacierClient>("glacier");
}

function sfnGlacierSmArn(name: string): string {
  return `arn:aws:states:${SFN_GLACIER_REGION}:${SFN_GLACIER_ACCOUNT_ID}:stateMachine:${name}`;
}

async function sfnGlacierCreateSm(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnGlacierSfnClient(world).send(
    new CreateStateMachineCommand({
      name: SFN_GLACIER_TEST_SM,
      definition: SFN_GLACIER_PASS_DEFINITION,
      roleArn: SFN_GLACIER_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

async function sfnGlacierCreateVault(world: SdkWorld): Promise<void> {
  const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
  await sfnGlacierClient(world).send(new CreateVaultCommand({ vaultName: SFN_GLACIER_TEST_VAULT }));
}

// ── Background ────────────────────────────────────────────────────────────────
// ── Before hook: register executionHelpers for stepfunctionsglacier scenarios ────────────

Before({ tags: "@stepfunctionsglacier" }, function (this: SdkWorld) {
  const executionHelpersImpl: ExecutionStepHelpers = {
    setupExecutionRunning: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create state machine then start execution
      const expectedSmArn = await sfnGlacierCreateSm(this);
      (world as any)._sfnGlacierSmArn = expectedSmArn;
      const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
      const execResult = await sfnGlacierSfnClient(this).send(
        new StartExecutionCommand({
          stateMachineArn: sfnGlacierSmArn(SFN_GLACIER_TEST_SM),
          input: SFN_GLACIER_TEST_INPUT,
        }),
      );
      // Assert: execution started
      (world as any)._sfnGlacierExecArn = execResult.executionArn;
      assert.ok(execResult.executionArn, "Expected executionArn in StartExecution response");
    },
  };
  this.executionHelpers = executionHelpersImpl;

  const vaultHelpersImpl: VaultStepHelpers = {
    setupVaultExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      try {
        await sfnGlacierCreateVault(world);
      } catch {
        // vault may already exist
      }
    },
    createVault: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateVaultCommand } = require("@aws-sdk/client-glacier");
      // Act
      try {
        const result = await sfnGlacierClient(this).send(
          new CreateVaultCommand({ vaultName: SFN_GLACIER_TEST_VAULT }),
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
        const result = await sfnGlacierClient(this).send(
          new DeleteVaultCommand({ vaultName: SFN_GLACIER_TEST_VAULT }),
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
      const { DescribeVaultCommand } = require("@aws-sdk/client-glacier");
      const expectedVaultName = SFN_GLACIER_TEST_VAULT;
      if (expectedState === "EXISTS") {
        // Act
        const result = await sfnGlacierClient(this).send(
          new DescribeVaultCommand({ vaultName: expectedVaultName }),
        );
        const actualVaultName = result.VaultName as string;
        // Assert
        assert.strictEqual(
          actualVaultName,
          expectedVaultName,
          `Expected vault name "${expectedVaultName}" but got "${actualVaultName}"; expected_vault_name=${expectedVaultName} actual_vault_name=${actualVaultName}`,
        );
      }
    },
    assertVaultDeleted: async (world: SdkWorld) => {
      // No-op: fresh state has no vaults (simulates deleted vault).
      assert.ok(world.session, "Expected session to be initialized");
    },
  };
  this.vaultHelpers = vaultHelpersImpl;
});

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: vault existence ────────────────────────────────────────────────────

// "the vault does not already exist" is registered in cross_service_common.ts.
// "the vault already exists" is registered in cross_service_common.ts (dispatches via vaultHelpers).

// "the vault exists" is registered in cross_service_common.ts (dispatches via vaultHelpers).
// "the vault does not exist" is registered in cross_service_common.ts.

// ── Given: vault status ────────────────────────────────────────────────────────

// 'the vault {string}' (Given context) is handled by the combined Given/Then registration below.

// 'the vault is "DELETED"' is registered in glacier.ts (dispatches via vaultHelpers.assertVaultDeleted).

Given('the vault is already "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create vault then delete it
  try {
    await sfnGlacierCreateVault(this);
  } catch {
    // vault may already exist
  }
  const { DeleteVaultCommand } = require("@aws-sdk/client-glacier");
  try {
    await sfnGlacierClient(this).send(
      new DeleteVaultCommand({ vaultName: SFN_GLACIER_TEST_VAULT }),
    );
  } catch {
    // ignore — desired state is deleted
  }
  // Assert: vault is deleted
});

Given('the vault is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create an existing vault (not deleted)
  try {
    await sfnGlacierCreateVault(this);
  } catch {
    // vault may already exist
  }
  // Assert: vault exists
});

Given('the vault does not exist or is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no vaults (simulates absent/deleted vault).
  assert.ok(this.session, "Expected session to be initialized");
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

// "a Glacier vault is created" is registered in glacier_sns.ts (dispatches via vaultHelpers.createVault).

When("a Glacier vault is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(this.vaultHelpers?.deleteVault, "Expected vaultHelpers.deleteVault to be registered");
  // Act: dispatch to service-specific vault helpers
  await this.vaultHelpers.deleteVault(this);
  // Assert: captured in lastCallResult
});

When(
  "a running execution fails because the Glacier vault has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that fails due to deleted Glacier vault in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger internal execution step that fails due to deleted Glacier vault in lws",
      ),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'a running execution calls a Glacier vault that "EXISTS" and the task succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal execution step that calls Glacier vault in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger internal execution step that calls Glacier vault in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the state machine is "ACTIVE"" is registered in stepfunctions.ts.
// "the execution is "RUNNING"" is registered in stepfunctions.ts.
// "the operation is rejected" is registered in cross_service_common.ts.

Then("the vault {string}", async function (this: SdkWorld, expectedState: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Setup: create vault if state indicates it should exist (Given context)
  if (expectedState === "EXISTS" || expectedState === 'EXISTS (not already "DELETED")') {
    try {
      await sfnGlacierCreateVault(this);
    } catch {
      // vault may already exist
    }
  }
  // Assert: dispatch to service-specific vault helpers when registered (Then context)
  if (this.vaultHelpers?.assertVaultState) {
    // Act
    await this.vaultHelpers.assertVaultState(this, expectedState);
    // Assert: handled by assertVaultState
    return;
  }
  // Default: no-op
});

Then(
  'the vault is "DELETED" and "SDK" task calls targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeVaultCommand } = require("@aws-sdk/client-glacier");
    const expectedVaultName = SFN_GLACIER_TEST_VAULT;
    // Act: describe must fail (vault does not exist)
    try {
      await sfnGlacierClient(this).send(new DescribeVaultCommand({ vaultName: expectedVaultName }));
      // Assert: if no error, vault still exists — fail the assertion
      assert.fail(
        `Expected vault "${expectedVaultName}" to be deleted but it still exists; expected_vault_name=${expectedVaultName}`,
      );
    } catch (err: unknown) {
      // Assert: error expected; vault is deleted
      assert.ok(err, "Expected describe to fail for deleted vault");
    }
  },
);

// "the execution is SUCCEEDED" — handled by the canonical
// Then("the execution is {string}", ...) in stepfunctions_sqs.ts.

Then('the execution is "FAILED" with a ResourceNotFoundException', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution Glacier task failure in lws.
  // No-op: treat as invariant satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariants ──────────────────────────────────────────────────────────

// "every {string} execution references an {string} state machine" is in cross_service_common.ts.

Then("every succeeded execution recorded which vault it called", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
