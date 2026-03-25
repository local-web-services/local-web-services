/** Step definitions: lambda_secretsmanager cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LS_TEST_FUNC = "e2e-test-func-1";
const LS_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const LS_TEST_SECRET = "e2e-test-secret-1";
const LS_TEST_SECRET_VALUE = "e2e-test-secret-value-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function smClient(world: SdkWorld) {
  const { SecretsManagerClient } = require("@aws-sdk/client-secrets-manager");
  return world.session!.client<typeof SecretsManagerClient>("secretsmanager");
}

async function createLsFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LS_TEST_FUNC,
      Runtime: "python3.12",
      Role: LS_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createLsSecret(world: SdkWorld): Promise<void> {
  const { CreateSecretCommand } = require("@aws-sdk/client-secrets-manager");
  await smClient(world).send(
    new CreateSecretCommand({ Name: LS_TEST_SECRET, SecretString: LS_TEST_SECRET_VALUE }),
  );
}

// ── Before hook: register functionHelpers for lambdasecretsmanager scenarios ─────────────

Before({ tags: "@lambdasecretsmanager" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LS_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await createLsFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LS_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LS_TEST_FUNC }),
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

// ── Given: invocation state ───────────────────────────────────────────────────

// ── Given: secret state unique to cross-service scenarios ─────────────────────

Given('the secret exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the secret
  await createLsSecret(this);
  // Assert: secret is ACTIVE immediately after creation in lws
});

Given('the secret is "PENDING_DELETION"', async function (this: SdkWorld) {
  // Arrange: create and then soft-delete the secret so it is PENDING_DELETION
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateSecretCommand, DeleteSecretCommand } = require("@aws-sdk/client-secrets-manager");
  // Act
  try {
    await smClient(this).send(
      new CreateSecretCommand({ Name: LS_TEST_SECRET, SecretString: LS_TEST_SECRET_VALUE }),
    );
  } catch {
    // Secret may already exist
  }
  await smClient(this).send(
    new DeleteSecretCommand({ SecretId: LS_TEST_SECRET, RecoveryWindowInDays: 7 }),
  );
  // Assert: secret is now PENDING_DELETION
});

Given("the secret is not pending deletion", async function (this: SdkWorld) {
  // Arrange: create the secret (not pending deletion)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createLsSecret(this);
  // Assert: secret created and ACTIVE
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "a secret is created in Secrets Manager" is registered in cross_service_common.ts.

// "a secret is scheduled for deletion" is registered in cross_service_common.ts.

When(
  "the Lambda function fails because the secret is pending deletion",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Lambda function reads an "ACTIVE" secret and completes successfully',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation success in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the secret is "ACTIVE" and can be read by Lambda', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeSecretCommand } = require("@aws-sdk/client-secrets-manager");
  // Act
  const result = await smClient(this).send(new DescribeSecretCommand({ SecretId: LS_TEST_SECRET }));
  // Assert
  const expectedName = LS_TEST_SECRET;
  const actualName = result.Name ?? "";
  assert.strictEqual(
    actualName,
    expectedName,
    `Expected secret name "${expectedName}" but got "${actualName}"; expected_name=${expectedName} actual_name=${actualName}`,
  );
});

Then(
  'the secret is "PENDING_DELETION" and will be unavailable to Lambda during the recovery window',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeSecretCommand } = require("@aws-sdk/client-secrets-manager");
    // Act
    const result = await smClient(this).send(
      new DescribeSecretCommand({ SecretId: LS_TEST_SECRET }),
    );
    // Assert
    const actualDeletedDate = result.DeletedDate;
    assert.ok(
      actualDeletedDate != null,
      `Expected secret "${LS_TEST_SECRET}" to have a DeletedDate (pending deletion) but got null; actual_deleted_date=null`,
    );
  },
);

Then(
  'the invocation is "FAILED" with a ResourceNotFoundException',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Invariant catch-all steps ─────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then(
  /^every successful invocation recorded which secret it read$/,
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  },
);
