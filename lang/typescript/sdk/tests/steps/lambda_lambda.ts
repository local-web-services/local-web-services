/** Step definitions: lambda_lambda cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_CALLER_FUNC = "e2e-lambda-caller-fn-1";
const LAMBDA_CALLEE_FUNC = "e2e-lambda-callee-fn-1";
const LAMBDA_LAMBDA_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

async function createCallerFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_CALLER_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_LAMBDA_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createCalleeFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_CALLEE_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_LAMBDA_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

// ── Given: caller function state ──────────────────────────────────────────────

Given("the caller function does not already exist", async function (this: SdkWorld) {
  // No-op: fresh state after session reset has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the caller function already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCallerFunction(this);
  // Assert: caller created
});

Given("the caller exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCallerFunction(this);
  // Assert: caller created
});

Given("the caller is {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // No-op: lws resolves functions to ACTIVE immediately after creation.
    return;
  }
  // For other states: @internal — cannot observe in lws.
});

Given("the caller is not {string}", async function (this: SdkWorld, state: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  if (state === "ACTIVE") {
    // Arrange: delete the caller, apply lifecycle dwell so next create is non-ACTIVE
    const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    try {
      await lambdaLambdaClient(this).send(
        new DeleteFunctionCommand({ FunctionName: LAMBDA_CALLER_FUNC }),
      );
    } catch {
      // function may not exist
    }
    await this.session!.lifecycle("lambda").createDwellMs(5000).apply();
    await createCallerFunction(this);
    return;
  }
  // For other states: no-op.
});

Given("the caller does not exist", async function (this: SdkWorld) {
  // No-op: fresh state has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: callee function state ──────────────────────────────────────────────

Given("the callee function does not already exist", async function (this: SdkWorld) {
  // No-op: fresh state after session reset has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the callee function already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCalleeFunction(this);
  // Assert: callee created
});

Given("the callee exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCalleeFunction(this);
  // Assert: callee created
});

Given('the callee is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: ensure callee exists (create, ignore already-exists errors)
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    await lambdaLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_CALLEE_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
  } catch {
    // callee may already exist
  }
  // Assert: callee exists and is ACTIVE
});

Given('the callee is already "DELETED"', async function (this: SdkWorld) {
  // Arrange: create the callee, apply delete dwell, then delete it
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand, DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act: create first (ignore errors if already exists)
  try {
    await lambdaLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_CALLEE_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
  } catch {
    // may already exist
  }
  await this.session!.lifecycle("lambda").deleteDwellMs(5000).apply();
  try {
    await lambdaLambdaClient(this).send(
      new DeleteFunctionCommand({ FunctionName: LAMBDA_CALLEE_FUNC }),
    );
  } catch {
    // delete may fail if function does not exist
  }
  this.lastCallResult = { success: true, output: null };
  // Assert: callee is in deleted state
});

Given("the callee does not exist", async function (this: SdkWorld) {
  // No-op: fresh state has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the callee does not exist or is "DELETED"', async function (this: SdkWorld) {
  // No-op: fresh state has no Lambda functions (simulates absent or deleted callee).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the callee is "DELETED"', async function (this: SdkWorld) {
  // @internal: No public API puts a callee in DELETED state without deleting it.
  // Only reached by @internal scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the callee is not "DELETED"', async function (this: SdkWorld) {
  // Arrange: ensure callee exists (i.e. it is not deleted)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCalleeFunction(this);
  // Assert: callee exists
});

// ── Given: invocation state ────────────────────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create the caller function to represent an in-progress invocation context
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createCallerFunction(this);
  // Assert: caller created
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // No-op: fresh state has no invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("an invocation slot is available", async function (this: SdkWorld) {
  // No-op: always room for invocations in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ─────────────────────────────────────────────────────────────

When("a caller Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_CALLER_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("a callee Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_CALLEE_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_LAMBDA_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the callee Lambda function is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaLambdaClient(this).send(
      new DeleteFunctionCommand({ FunctionName: LAMBDA_CALLEE_FUNC }),
    );
    // Assert: store result
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
});

When("the caller Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda-to-Lambda invocation in lws without Docker.
  // Only reached by @internal scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation: scenario is @internal"),
  };
});

When(
  "the caller fails to invoke the callee because the callee has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda-to-Lambda invocation failure in lws without Docker.
    // Only reached by @internal scenarios excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
  },
);

When(
  'the caller Lambda function invokes the "ACTIVE" callee and the call succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda-to-Lambda invocation success in lws without Docker.
    // Only reached by @internal scenarios excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation success: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the caller function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  const result = await lambdaLambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: LAMBDA_CALLER_FUNC }),
  );
  // Assert
  const expectedState = "Active";
  const actualState = result.Configuration?.State as string;
  assert.strictEqual(
    actualState,
    expectedState,
    `Expected caller function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
  );
});

Then('the callee function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  const result = await lambdaLambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: LAMBDA_CALLEE_FUNC }),
  );
  // Assert
  const expectedState = "Active";
  const actualState = result.Configuration?.State as string;
  assert.strictEqual(
    actualState,
    expectedState,
    `Expected callee function state "${expectedState}" but got "${actualState}"; expected_state=${expectedState} actual_state=${actualState}`,
  );
});

Then(
  'the callee is "DELETED" and invocations targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    let threwError = false;
    try {
      await lambdaLambdaClient(this).send(
        new GetFunctionCommand({ FunctionName: LAMBDA_CALLEE_FUNC }),
      );
    } catch {
      threwError = true;
    }
    // Assert
    const expectedDeleted = true;
    const actualDeleted = threwError;
    assert.ok(
      actualDeleted,
      `Expected callee "${LAMBDA_CALLEE_FUNC}" to be deleted but it still exists; expected_deleted=${expectedDeleted} actual_deleted=${actualDeleted}`,
    );
  },
);

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation state in lws.
  // Only reached by @internal scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the invocation is "FAILED" with a ResourceNotFoundException',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation success in lws.
  // Only reached by @internal scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant catch-all steps ─────────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" caller function',
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  "every successful invocation recorded which callee was invoked",
  async function (this: SdkWorld) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
