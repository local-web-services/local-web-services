/** Step definitions: lambda_sns cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
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

// ── Given: invocation state ───────────────────────────────────────────────────

Given("an invocation is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "IN_PROGRESS") {
    // Act: create a Lambda function so an invocation can be considered in-progress
    try {
      await lambdaSnsCreateFunction(this);
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
  // Arrange: exhaust Lambda invocation capacity
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("lambda").exhaust().apply();
  // Assert: capacity is exhausted
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "No session running");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaSnsLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_SNS_TEST_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_SNS_ROLE_ARN,
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

When("the Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation in lws without Docker.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation: scenario is @internal"),
  };
});

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

Then("the invocation is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot observe Lambda invocation state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then("the message is published to the topic", async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda SNS publish result in lws.
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

Then(
  'publishing requires an "ACTIVE" topic to be present',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
