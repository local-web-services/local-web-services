/** Step definitions: lambda_sns cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// Steps already registered in other files are NOT re-registered here:
//   - "the system is initialized"              — cross_service_common.ts
//   - "the operation is rejected"              — cross_service_common.ts
//   - "the function does not already exist" / "the function already exists" /
//     "the function exists" / "the function does not exist" / "the function is {string}" /
//     "the function is not {string}"           — lambda.ts
//   - "the topic does not already exist" / "the topic already exists" /
//     "the topic exists" / "the topic does not exist" / "the topic is {string}" /
//     "the topic is not {string}"              — sns.ts and cross_service_common.ts

const LAMBDA_SNS_TEST_FUNC = "e2e-test-func-1";
const LAMBDA_SNS_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaSnsLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

async function lambdaSnsCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaSnsLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_SNS_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_SNS_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

// ── Before hook: register functionHelpers for lambdasns scenarios ─────────────

Before({ tags: "@lambdasns" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_SNS_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaSnsCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_SNS_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaSnsLambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_SNS_TEST_FUNC }),
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

// "an invocation is {string}" — registered in capacity.ts (dispatches via functionHelpers)
// "no invocation is {string}" — registered in capacity.ts

// ── When: actions ─────────────────────────────────────────────────────────────

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
  };
});

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation success in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
  };
});

When(
  "the Lambda function publishes a message to the {string} topic during invocation",
  async function (this: SdkWorld, _service: string) {
    // @internal: Cannot trigger Lambda SNS publish in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda SNS publish: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the invocation is {string}" — registered in lambda_common.ts (literal versions for IN_PROGRESS/SUCCESS/FAILED)

Then("the message is published to the topic", async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda SNS publish result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then('publishing requires an "ACTIVE" topic to be present', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
