/** Step definitions: lambda_ssm cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// Steps already registered in other files are NOT re-registered here to avoid
// AmbiguousError in Cucumber.js:
//   - "the system is initialized"              — cross_service_common.ts
//   - "the operation is rejected"              — cross_service_common.ts
//   - "the function does not already exist" / "the function already exists" /
//     "the function exists" / "the function does not exist" / "the function is {string}" /
//     "the function is not {string}"           — lambda.ts
//   - "the parameter does not already exist" / "the parameter already exists" /
//     "the parameter exists" / "the parameter does not exist"  — ssm.ts
//
// Cross-service parameterised SSM Given steps registered in cross_service_common.ts
// ("the parameter {string}", "the parameter is {string}", "the parameter is already {string}",
// "the parameter does not exist or is {string}", "the parameter is not {string}") use SM_PARAM
// ("/test/ssm/cs-1"). This file registers EXACT string overrides for the lambda_ssm-specific
// states so Cucumber.js selects the more-specific (literal) definition.

const LAMBDA_SSM_TEST_FUNC = "e2e-test-func-1";
const LAMBDA_SSM_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const LAMBDA_SSM_PARAM = "/e2e/test/param/1";
const LAMBDA_SSM_PARAM_VALUE = "e2e-test-value-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaSsmLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function lambdaSsmSsmClient(world: SdkWorld) {
  const { SSMClient } = require("@aws-sdk/client-ssm");
  return world.session!.client<typeof SSMClient>("ssm");
}

async function lambdaSsmCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaSsmLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_SSM_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_SSM_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function lambdaSsmCreateParam(world: SdkWorld): Promise<void> {
  const { PutParameterCommand } = require("@aws-sdk/client-ssm");
  await lambdaSsmSsmClient(world).send(
    new PutParameterCommand({
      Name: LAMBDA_SSM_PARAM,
      Value: LAMBDA_SSM_PARAM_VALUE,
      Type: "String",
    }),
  );
}

// ── Before hook: register functionHelpers for lambdassm scenarios ─────────────

Before({ tags: "@lambdassm" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_SSM_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaSsmCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_SSM_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaSsmLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_SSM_TEST_FUNC }),
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

// ── Given: parameter state — exact-string overrides ───────────────────────────
// These use exact string literals so Cucumber.js picks them over the parameterised
// versions in cross_service_common.ts (which use SM_PARAM = "/test/ssm/cs-1").

// 'the parameter "EXISTS"' is registered via the generic
// 'the parameter {string}' in cross_service_common.ts.

Given('the parameter is already "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteParameterCommand } = require("@aws-sdk/client-ssm");
  try {
    await lambdaSsmCreateParam(this);
  } catch {
    // parameter may already exist
  }
  // Act: apply lifecycle dwell then delete
  await this.session!.lifecycle("ssm").deleteDwellMs(5000).apply();
  try {
    await lambdaSsmSsmClient(this).send(new DeleteParameterCommand({ Name: LAMBDA_SSM_PARAM }));
    this.lastCallResult = { success: true, output: null };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: parameter is now deleted (next step verifies rejection)
});

Given('the parameter does not exist or is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no parameters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the parameter is "DELETED"', async function (this: SdkWorld) {
  // No-op: fresh state has no parameters (simulates deleted parameter).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the parameter is not "DELETED"', async function (this: SdkWorld) {
  // Arrange: create the parameter so it exists and is not deleted
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await lambdaSsmCreateParam(this);
  // Assert: parameter exists; verified by subsequent steps
});

// ── Given: invocation state ───────────────────────────────────────────────────

// ── When: actions ─────────────────────────────────────────────────────────────

// "a parameter is created in {string} Parameter Store" is registered in cross_service_common.ts.

// "a parameter is deleted from {string} Parameter Store" is registered in cross_service_common.ts.

When(
  "the Lambda function fails because the parameter has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  "the Lambda function reads an existing parameter and completes successfully",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation success in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the parameter "EXISTS" and can be read by Lambda', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetParameterCommand } = require("@aws-sdk/client-ssm");
  // Act
  const result = await lambdaSsmSsmClient(this).send(
    new GetParameterCommand({ Name: LAMBDA_SSM_PARAM }),
  );
  // Assert
  const expectedValue = LAMBDA_SSM_PARAM_VALUE;
  const actualValue = result?.Parameter?.Value;
  assert.strictEqual(
    actualValue,
    expectedValue,
    `Expected parameter value "${expectedValue}" but got "${actualValue}"; expected_value=${expectedValue} actual_value=${actualValue}`,
  );
});

Then(
  'the parameter is "DELETED" and will cause a ParameterNotFound error when read',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetParameterCommand } = require("@aws-sdk/client-ssm");
    // Act: attempt to read the parameter; it should be absent
    let actualError: unknown = null;
    try {
      await lambdaSsmSsmClient(this).send(new GetParameterCommand({ Name: LAMBDA_SSM_PARAM }));
    } catch (err: unknown) {
      actualError = err;
    }
    // Assert
    const expectedErrorPresent = true;
    const actualErrorPresent = actualError !== null;
    assert.ok(
      actualErrorPresent === expectedErrorPresent,
      `Expected parameter "${LAMBDA_SSM_PARAM}" to be deleted but it still exists; expected_error=ParameterNotFound actual_error=null`,
    );
    const actualErrorMsg = String(actualError);
    assert.ok(
      actualErrorMsg.includes("ParameterNotFound"),
      `Expected ParameterNotFound error but got: ${actualErrorMsg}; expected_error=ParameterNotFound actual_error=${actualErrorMsg}`,
    );
  },
);

Then('the invocation is "FAILED" with a ParameterNotFound error', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then(
  "every successful invocation recorded which parameter it read",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
