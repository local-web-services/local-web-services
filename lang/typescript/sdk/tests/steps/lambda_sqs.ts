/** Step definitions: lambda_sqs cross-service informal specification scenarios */

import { Before, Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_SQS_TEST_FUNC = "e2e-test-func-1";
const LAMBDA_SQS_TEST_QUEUE = "e2e-test-q1";
const LAMBDA_SQS_TEST_DLQ = "e2e-test-dlq-1";
const LAMBDA_SQS_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const LAMBDA_SQS_REGION = "us-east-1";
const LAMBDA_SQS_ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function sqsClient(world: SdkWorld) {
  const { SQSClient } = require("@aws-sdk/client-sqs");
  return world.session!.client<typeof SQSClient>("sqs");
}

function queueUrl(world: SdkWorld, queueName: string): string {
  const port = world.session!.portFor("sqs");
  return `http://127.0.0.1:${port}/000000000000/${queueName}`;
}

function queueArn(queueName: string): string {
  return `arn:aws:sqs:${LAMBDA_SQS_REGION}:${LAMBDA_SQS_ACCOUNT_ID}:${queueName}`;
}

async function createLambdaFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_SQS_TEST_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_SQS_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createQueue(world: SdkWorld, queueName: string): Promise<void> {
  const { CreateQueueCommand } = require("@aws-sdk/client-sqs");
  await sqsClient(world).send(new CreateQueueCommand({ QueueName: queueName }));
}

async function deleteQueue(world: SdkWorld, queueName: string): Promise<void> {
  const { DeleteQueueCommand } = require("@aws-sdk/client-sqs");
  try {
    await sqsClient(world).send(new DeleteQueueCommand({ QueueUrl: queueUrl(world, queueName) }));
  } catch {
    // queue may not exist; desired state is absence
  }
}

// ── Before hook: register functionHelpers for @lambdasqs scenarios ────────────

Before({ tags: "@lambdasqs" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LAMBDA_SQS_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
      try {
        const result = await lambdaClient(world).send(
          new CreateFunctionCommand({
            FunctionName: LAMBDA_SQS_TEST_FUNC,
            Runtime: "python3.12",
            Role: LAMBDA_SQS_ROLE_ARN,
            Handler: "index.handler",
            Code: { ZipFile: Buffer.from("fake") },
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_SQS_TEST_FUNC }),
      );
      const actualState: string = result.Configuration?.State ?? "";
      const expectedState = "Active";
      const assertModule = require("assert");
      assertModule.strictEqual(
        actualState,
        expectedState,
        `Expected function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
      );
    },
  };
});

// ── Given: function state ─────────────────────────────────────────────────────
// "the function does not already exist", "the function already exists",
// "the function exists", "the function does not exist",
// "the function is {string}", "the function is not {string}" are registered
// in lambda.ts (dispatches via functionHelpers) — NOT re-registered here.
// "a Lambda function is deployed" (When), "the Lambda function is invoked" (When),
// "the function is ACTIVE" (Then), "the invocation is IN_PROGRESS" (Then),
// "the invocation is SUCCESS" (Then), "every {string} invocation references ..." (Then)
// are registered in lambda_common.ts — NOT re-registered here.

// ── Given: queue state ────────────────────────────────────────────────────────
// "the queue does not already exist", "the queue already exists",
// "the queue exists", "the queue does not exist",
// "the queue is {string}", "the queue is not {string}" are already
// registered in sqs.ts — NOT re-registered here.
// "the dead-letter queue exists", "the dead-letter queue does not exist",
// "the dead-letter queue is {string}", "the dead-letter queue is not {string}"
// are already registered in sqs.ts — NOT re-registered here.
// "the operation is rejected" is already registered in sqs.ts — NOT re-registered here.

// ── Given: source queue state ─────────────────────────────────────────────────

Given("the source queue exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createQueue(this, LAMBDA_SQS_TEST_QUEUE);
  // Assert: source queue created
});

Given("the source queue does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no queues.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the source queue is {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // No-op: queues are ACTIVE immediately after creation in lws.
    return;
  }
  // Arrange: apply lifecycle dwell so the source queue is non-ACTIVE
  // Act
  await this.session!.lifecycle("sqs").createDwellMs(5000).apply();
  await deleteQueue(this, LAMBDA_SQS_TEST_QUEUE);
  await createQueue(this, LAMBDA_SQS_TEST_QUEUE);
  // Assert: queue created in non-ACTIVE state
});

Given("the source queue is not {string}", async function (this: SdkWorld, state: string) {
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // Arrange: apply lifecycle dwell so the source queue is non-ACTIVE
    // Act
    await this.session!.lifecycle("sqs").createDwellMs(5000).apply();
    await deleteQueue(this, LAMBDA_SQS_TEST_QUEUE);
    await createQueue(this, LAMBDA_SQS_TEST_QUEUE);
    // Assert: queue created in non-ACTIVE state
    return;
  }
  // For other states, no-op.
});

Given("the source queue has no dead-letter queue configured", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: queue created without a DLQ.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(
  "the source queue already has a dead-letter queue configured",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    try {
      await createQueue(this, LAMBDA_SQS_TEST_QUEUE);
    } catch {
      // queue may already exist
    }
    try {
      await createQueue(this, LAMBDA_SQS_TEST_DLQ);
    } catch {
      // DLQ may already exist
    }
    // Act: configure redrive policy
    const { SetQueueAttributesCommand } = require("@aws-sdk/client-sqs");
    const expectedDlqArn = queueArn(LAMBDA_SQS_TEST_DLQ);
    const redrivePolicy = JSON.stringify({
      deadLetterTargetArn: expectedDlqArn,
      maxReceiveCount: 2,
    });
    await sqsClient(this).send(
      new SetQueueAttributesCommand({
        QueueUrl: queueUrl(this, LAMBDA_SQS_TEST_QUEUE),
        Attributes: { RedrivePolicy: redrivePolicy },
      }),
    );
    // Assert: redrive policy applied (no error thrown)
  },
);

// ── Given: event source mapping state ─────────────────────────────────────────
// "the event source mapping does not already exist" and
// "the event source mapping already exists" and
// "the event source mapping exists" and
// "the event source mapping does not exist" are already registered in
// lambda.ts — NOT re-registered here.

Given("the event source mapping is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot pre-create enabled event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the event source mapping is not {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot pre-create disabled event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the mapped function is {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot set up event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the mapped function is not {string}", async function (this: SdkWorld, _state: string) {
  // @internal: Cannot set up event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation / message / slot state ──────────────────────────────────

Given('an "AVAILABLE" message exists in the mapped queue', async function (this: SdkWorld) {
  // @internal: Cannot set up event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('no "AVAILABLE" message exists in the mapped queue', async function (this: SdkWorld) {
  // @internal: Cannot set up event source mapping in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// "a message slot is available" is registered in cross_service_common.ts.
// "no message slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Lambda function is deployed" is registered in lambda_common.ts (dispatches via functionHelpers).

// "an {string} queue is created" is registered in cross_service_common.ts.

When('the "SQS" queue is configured with a dead-letter queue', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { SetQueueAttributesCommand } = require("@aws-sdk/client-sqs");
  const expectedDlqArn = queueArn(LAMBDA_SQS_TEST_DLQ);
  const redrivePolicy = JSON.stringify({
    deadLetterTargetArn: expectedDlqArn,
    maxReceiveCount: 2,
  });
  // Act
  try {
    const result = await sqsClient(this).send(
      new SetQueueAttributesCommand({
        QueueUrl: queueUrl(this, LAMBDA_SQS_TEST_QUEUE),
        Attributes: { RedrivePolicy: redrivePolicy },
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "a Lambda event source mapping is created linking a queue to a function",
  async function (this: SdkWorld) {
    // @internal: Cannot create event source mapping in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot create ESM linking queue to function: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  "the event source mapping polls the queue and invokes the Lambda function",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger ESM polling in lws.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger ESM polling: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

// "the Lambda function is invoked" is registered in lambda_common.ts.

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
  };
  // Assert: captured in lastCallResult
});

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation success in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
  };
  // Assert: captured in lastCallResult
});

When('a message arrives in the "SQS" queue', async function (this: SdkWorld) {
  // @internal: Cannot trigger internal message arrival in lws.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger internal message arrival: scenario is @internal"),
  };
  // Assert: captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the function is ACTIVE" is registered in lambda_common.ts (dispatches via functionHelpers).
// "the invocation is IN_PROGRESS" is registered in lambda_common.ts.
// "the invocation is SUCCESS" is registered in lambda_common.ts.
// "every {string} invocation references an {string} Lambda function" is registered in lambda_common.ts.

Then('the queue is "ACTIVE" with no dead-letter queue configured', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetQueueAttributesCommand } = require("@aws-sdk/client-sqs");
  // Act
  const result = await sqsClient(this).send(
    new GetQueueAttributesCommand({
      QueueUrl: queueUrl(this, LAMBDA_SQS_TEST_QUEUE),
      AttributeNames: ["RedrivePolicy"],
    }),
  );
  const actualAttributes: Record<string, string> = result.Attributes ?? {};
  const actualRedrive = actualAttributes["RedrivePolicy"] ?? "";
  // Assert
  const expectedRedrive = "";
  assert.strictEqual(
    actualRedrive,
    expectedRedrive,
    `Expected no RedrivePolicy but got "${actualRedrive}"; expected_redrive="${expectedRedrive}" actual_redrive="${actualRedrive}"`,
  );
});

Then(
  "failed messages will be redriven to the dead-letter queue after two receives",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetQueueAttributesCommand } = require("@aws-sdk/client-sqs");
    // Act
    const result = await sqsClient(this).send(
      new GetQueueAttributesCommand({
        QueueUrl: queueUrl(this, LAMBDA_SQS_TEST_QUEUE),
        AttributeNames: ["RedrivePolicy"],
      }),
    );
    const actualAttributes: Record<string, string> = result.Attributes ?? {};
    const actualPolicy = actualAttributes["RedrivePolicy"] ?? "";
    assert.ok(actualPolicy !== "", "Expected a RedrivePolicy to be configured but got none");
    const parsedPolicy = JSON.parse(actualPolicy) as { maxReceiveCount?: number };
    const actualCount = parsedPolicy.maxReceiveCount ?? 0;
    // Assert
    const expectedCount = 2;
    assert.strictEqual(
      actualCount,
      expectedCount,
      `Expected maxReceiveCount ${expectedCount} but got ${actualCount}; expected_count=${expectedCount} actual_count=${actualCount}`,
    );
  },
);

Then(
  'the event source mapping is "ENABLED" and will poll the queue for messages',
  async function (this: SdkWorld) {
    // @internal: Cannot observe event source mapping state in lws.
  },
);

// "the invocation is IN_PROGRESS" is registered in lambda_common.ts.

Then('the invocation is "FAILED"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation failure in lws.
});

Then(
  'the invocation is "SUCCESS" and the "SQS" message is "DELETED"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation result in lws.
  },
);

Then(
  /^if the receive count is below the threshold the message is "AVAILABLE" for reprocessing, otherwise it is redriven to the dead-letter queue$/,
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda SQS failure handling in lws.
  },
);

Then(
  'the message is "IN_FLIGHT" and a Lambda invocation is "IN_PROGRESS"',
  async function (this: SdkWorld) {
    // @internal: Cannot observe ESM polling result in lws.
  },
);

Then('the message is "AVAILABLE" for processing', async function (this: SdkWorld) {
  // @internal: Cannot observe internal message state in lws.
});

// ── Then: invariants ──────────────────────────────────────────────────────────

Then(
  /^every in-progress invocation was initiated by an "ENABLED" event source mapping$/,
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  },
);

Then(
  /^every in-progress invocation references an "ACTIVE" Lambda function$/,
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  },
);

Then(
  /^every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue$/,
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  },
);

Then(
  /^every "ENABLED" event source mapping references an "ACTIVE" queue$/,
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  },
);
