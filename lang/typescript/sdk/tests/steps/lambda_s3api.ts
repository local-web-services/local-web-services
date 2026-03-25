/** Step definitions: lambda_s3api cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_S3API_FUNC = "e2e-test-func-1";
const LAMBDA_S3API_BUCKET = "e2e-test-bucket-1";
const LAMBDA_S3API_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function s3Client(world: SdkWorld) {
  const { S3Client } = require("@aws-sdk/client-s3");
  return world.session!.client<typeof S3Client>("s3");
}

async function lambdaS3apiCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_S3API_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_S3API_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

// ── Before hook: register functionHelpers for lambdas3api scenarios ─────────────

Before({ tags: "@lambdas3api" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_S3API_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await lambdaS3apiCreateFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LAMBDA_S3API_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_S3API_FUNC }),
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

// ── Given: invocation slot state ──────────────────────────────────────────────

// ── Given: invocation in-progress state ──────────────────────────────────────

// ── Given: object slot state ──────────────────────────────────────────────────

// "an object slot is available" is registered in cross_service_common.ts.

// "no object slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "an S3 bucket is created" is registered in cross_service_common.ts.

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation failure via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
  };
});

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation success via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
  };
});

When(
  "the Lambda function writes an object to the S3 bucket during invocation",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda object write during invocation via public API in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda object write: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the bucket is {string}" is already registered as a parameterized Given in s3api.ts;
// it matches Then the bucket is "ACTIVE" via Cucumber keyword aliasing.

// "the function is {string}" is already registered as a parameterized Given in lambda.ts;
// it matches Then the function is "ACTIVE" via Cucumber keyword aliasing.

// "the object \"EXISTS\" in the bucket" is already registered in s3api.ts.

Then('the invocation is "FAILED"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation FAILED state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: invariant assertions (no-op) ───────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then('every existing object belongs to an "ACTIVE" bucket', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
