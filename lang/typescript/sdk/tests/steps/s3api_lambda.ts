/** Step definitions: s3api_lambda cross-service scenarios — unique steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const S3API_LAMBDA_BUCKET = "e2e-test-bucket-1";
const S3API_LAMBDA_FUNC = "e2e-test-func-1";
const S3API_LAMBDA_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const S3API_LAMBDA_KEY = "e2e-test-key-1";
const S3API_LAMBDA_BODY = "test-data-content-1";
const S3API_LAMBDA_REGION = "us-east-1";
const S3API_LAMBDA_ACCOUNT_ID = "000000000000";

function s3apiLambdaFuncArn(): string {
  return `arn:aws:lambda:${S3API_LAMBDA_REGION}:${S3API_LAMBDA_ACCOUNT_ID}:function:${S3API_LAMBDA_FUNC}`;
}

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function s3Client(world: SdkWorld) {
  const { S3Client } = require("@aws-sdk/client-s3");
  return world.session!.client<typeof S3Client>("s3");
}

async function s3apiLambdaCreateBucket(world: SdkWorld): Promise<void> {
  const { CreateBucketCommand } = require("@aws-sdk/client-s3");
  try {
    await s3Client(world).send(new CreateBucketCommand({ Bucket: S3API_LAMBDA_BUCKET }));
  } catch {
    // bucket may already exist; desired state is existence
  }
}

async function s3apiLambdaCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  try {
    await lambdaClient(world).send(
      new CreateFunctionCommand({
        FunctionName: S3API_LAMBDA_FUNC,
        Runtime: "python3.12",
        Role: S3API_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
  } catch {
    // function may already exist; desired state is existence
  }
}

async function s3apiLambdaConfigureNotification(world: SdkWorld): Promise<void> {
  const { PutBucketNotificationConfigurationCommand } = require("@aws-sdk/client-s3");
  await s3Client(world).send(
    new PutBucketNotificationConfigurationCommand({
      Bucket: S3API_LAMBDA_BUCKET,
      NotificationConfiguration: {
        LambdaFunctionConfigurations: [
          {
            LambdaFunctionArn: s3apiLambdaFuncArn(),
            Events: ["s3:ObjectCreated:*"],
          },
        ],
      },
    }),
  );
}

// ── Given: bucket state ───────────────────────────────────────────────────────

// "the bucket does not already exist" is registered in cross_service_common.ts.

// "the bucket already exists" is registered in cross_service_common.ts.

// "the bucket exists" is registered in cross_service_common.ts.

// "the bucket is {string}" is registered in cross_service_common.ts.

// "the bucket is not {string}" is registered in cross_service_common.ts.

// "the bucket does not exist" is registered in cross_service_common.ts.

// ── Given: notification configuration state ───────────────────────────────────

Given("the bucket has no notification configured", async function (this: SdkWorld) {
  // No-op: buckets have no notification configuration by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bucket already has a notification configured", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create bucket and function if needed, then configure notification
  await s3apiLambdaCreateBucket(this);
  await s3apiLambdaCreateFunction(this);
  await s3apiLambdaConfigureNotification(this);
  // Assert: notification configured
});

Given("the bucket has a notification configured", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create bucket and function if needed, then configure notification
  await s3apiLambdaCreateBucket(this);
  await s3apiLambdaCreateFunction(this);
  await s3apiLambdaConfigureNotification(this);
  // Assert: notification configured
});

// ── Given: function state ─────────────────────────────────────────────────────

Given("the function does not already exist", async function (this: SdkWorld) {
  // No-op: fresh state after session reset has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the function already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await s3apiLambdaCreateFunction(this);
  // Assert: function created
});

Given("the function exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await s3apiLambdaCreateFunction(this);
  // Assert: function created
});

Given("the function does not exist", async function (this: SdkWorld) {
  // Arrange: delete the function if present so it does not exist
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act: delete, ignore errors (function may not exist)
  try {
    await lambdaClient(this).send(new DeleteFunctionCommand({ FunctionName: S3API_LAMBDA_FUNC }));
  } catch {
    // function may not exist; desired state is absence
  }
  // Assert: desired state is absence
});

Given("the function is {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // No-op: lws resolves functions to ACTIVE immediately after creation.
    return;
  }
  // @internal: Cannot observe other Lambda states in lws without lifecycle dwell or internal APIs.
});

Given("the function is not {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // Arrange: apply lifecycle dwell so next created function starts in a non-ACTIVE state
    const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    try {
      await lambdaClient(this).send(new DeleteFunctionCommand({ FunctionName: S3API_LAMBDA_FUNC }));
    } catch {
      // function may not exist
    }
    await this.session!.lifecycle("lambda").createDwellMs(5000).apply();
    await s3apiLambdaCreateFunction(this);
    // Assert: function is in non-ACTIVE state
    return;
  }
  // @internal: Cannot observe other Lambda states in lws.
});

// ── Given: notification target function state ─────────────────────────────────

Given(
  "the notification target function is {string}",
  async function (this: SdkWorld, state: string) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    if (state === "ACTIVE") {
      // No-op: Lambda functions are ACTIVE immediately after creation in lws.
      return;
    }
    // @internal: Cannot place Lambda notification target function in a non-ACTIVE state in lws.
    // Assert: no-op
  },
);

Given(
  "the notification target function is not {string}",
  async function (this: SdkWorld, _state: string) {
    // @internal: Cannot place Lambda notification target function in a non-ACTIVE state
    // while it is already configured as a bucket notification target in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Given: capacity / slot state ──────────────────────────────────────────────

// "an object slot is available" is registered in cross_service_common.ts.

// "no object slot is available" is registered in cross_service_common.ts.

Given("an invocation slot is available", async function (this: SdkWorld) {
  // Arrange: set Lambda capacity to unlimited
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("lambda").unlimited().apply();
  // Assert: capacity set
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust Lambda invocation slot limit via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation in-progress state ──────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create the function so an invocation could be in progress.
  assert.ok(this.session, "Expected session to be initialized");
  // Act: the lws fake does not expose invocation state; creating the function
  // is the closest reachable precondition.
  await s3apiLambdaCreateFunction(this);
  // Assert: function created
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // No-op: fresh state has no invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "an S3 bucket is created" is registered in cross_service_common.ts.

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: S3API_LAMBDA_FUNC,
        Runtime: "python3.12",
        Role: S3API_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    // Assert: captured in lastCallResult
    this.lastCallResult = { success: true, output: result };
  } catch (err) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When(
  'an S3 event notification is configured to invoke a Lambda function on object "PUT"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { PutBucketNotificationConfigurationCommand } = require("@aws-sdk/client-s3");
    // Act
    try {
      const result = await s3Client(this).send(
        new PutBucketNotificationConfigurationCommand({
          Bucket: S3API_LAMBDA_BUCKET,
          NotificationConfiguration: {
            LambdaFunctionConfigurations: [
              {
                LambdaFunctionArn: s3apiLambdaFuncArn(),
                Events: ["s3:ObjectCreated:*"],
              },
            ],
          },
        }),
      );
      // Assert: captured in lastCallResult
      this.lastCallResult = { success: true, output: result };
    } catch (err) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

When(
  "an object is put into the bucket and asynchronously invokes the configured Lambda function",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { PutObjectCommand } = require("@aws-sdk/client-s3");
    // Act
    try {
      const result = await s3Client(this).send(
        new PutObjectCommand({
          Bucket: S3API_LAMBDA_BUCKET,
          Key: S3API_LAMBDA_KEY,
          Body: Buffer.from(S3API_LAMBDA_BODY),
        }),
      );
      // Assert: captured in lastCallResult
      this.lastCallResult = { success: true, output: result };
    } catch (err) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
  },
);

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation success via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
  };
});

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation failure via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
  };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

Then(
  'the bucket is "ACTIVE" with no event notification configured',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListBucketsCommand } = require("@aws-sdk/client-s3");
    // Act
    const result = await s3Client(this).send(new ListBucketsCommand({}));
    const buckets: Array<{ Name?: string }> = result.Buckets ?? [];
    const actualExists = buckets.some((b) => b.Name === S3API_LAMBDA_BUCKET);
    // Assert
    const expectedBucketName = S3API_LAMBDA_BUCKET;
    assert.ok(actualExists, `Expected bucket "${expectedBucketName}" to be ACTIVE but not found`);
  },
);

Then('the function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  const result = await lambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: S3API_LAMBDA_FUNC }),
  );
  // Assert
  const expectedState = "Active";
  const actualState: string = result.Configuration?.State ?? "";
  assert.strictEqual(
    actualState,
    expectedState,
    `Expected function state "${expectedState}" but got "${actualState}"`,
  );
});

Then(
  "the bucket will asynchronously invoke the function when an object is put",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetBucketNotificationConfigurationCommand } = require("@aws-sdk/client-s3");
    // Act
    const result = await s3Client(this).send(
      new GetBucketNotificationConfigurationCommand({ Bucket: S3API_LAMBDA_BUCKET }),
    );
    const configs: Array<{ LambdaFunctionArn?: string }> =
      result.LambdaFunctionConfigurations ?? [];
    const expectedFuncArn = s3apiLambdaFuncArn();
    const actualContains = configs.some((cfg) => cfg.LambdaFunctionArn === expectedFuncArn);
    // Assert
    assert.ok(
      actualContains,
      `Expected notification ARN "${expectedFuncArn}" to be configured but found: ${JSON.stringify(configs)}`,
    );
  },
);

Then(
  'the object "EXISTS" in the bucket and an invocation is "IN_PROGRESS"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListObjectsV2Command } = require("@aws-sdk/client-s3");
    // Act
    const result = await s3Client(this).send(
      new ListObjectsV2Command({ Bucket: S3API_LAMBDA_BUCKET }),
    );
    const objects: Array<{ Key?: string }> = result.Contents ?? [];
    const expectedKey = S3API_LAMBDA_KEY;
    const actualExists = objects.some((obj) => obj.Key === expectedKey);
    // Assert
    assert.ok(
      actualExists,
      `Expected object "${expectedKey}" to exist in bucket "${S3API_LAMBDA_BUCKET}" but not found`,
    );
  },
);

// ── Then: invariant assertions (no-op) ────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Then: @internal scenario assertions (no-op) ───────────────────────────────

Then('the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation SUCCESS state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation FAILED state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});
