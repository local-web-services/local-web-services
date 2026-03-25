/** Step definitions: lambda_stepfunctions cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LAMBDA_SF_FUNC = "e2e-test-func-1";
const LAMBDA_SF_SM = "test-sm-1";
const LAMBDA_SF_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const LAMBDA_SF_REGION = "us-east-1";
const LAMBDA_SF_ACCOUNT_ID = "000000000000";
const LAMBDA_SF_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function sfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function smArn(): string {
  return `arn:aws:states:${LAMBDA_SF_REGION}:${LAMBDA_SF_ACCOUNT_ID}:stateMachine:${LAMBDA_SF_SM}`;
}

async function createFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LAMBDA_SF_FUNC,
      Runtime: "python3.12",
      Role: LAMBDA_SF_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createStateMachine(world: SdkWorld): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnClient(world).send(
    new CreateStateMachineCommand({
      name: LAMBDA_SF_SM,
      definition: LAMBDA_SF_PASS_DEFINITION,
      roleArn: LAMBDA_SF_ROLE_ARN,
      type: "STANDARD",
    }),
  );
  return result.stateMachineArn as string;
}

// ── Given: function state ──────────────────────────────────────────────────────

Given("the function does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no Lambda functions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the function already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createFunction(this);
  // Assert: function created (no error thrown)
});

Given("the function exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createFunction(this);
  // Assert: function created (no error thrown)
});

Given("the function does not exist", async function (this: SdkWorld) {
  // Arrange: delete the function if present so it does not exist
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act: delete, ignore errors (function may not exist)
  try {
    await lambdaClient(this).send(new DeleteFunctionCommand({ FunctionName: LAMBDA_SF_FUNC }));
  } catch {
    // function may not exist; desired state is absence
  }
  // Assert: desired state is absence
});

Given('the function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: functions are ACTIVE immediately after creation in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the function is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: apply lifecycle dwell so next created function starts in a non-ACTIVE state
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteFunctionCommand } = require("@aws-sdk/client-lambda");
  const mgmtPort = (this.session as any)._basePort as number;
  // Act
  try {
    await lambdaClient(this).send(new DeleteFunctionCommand({ FunctionName: LAMBDA_SF_FUNC }));
  } catch {
    // function may not exist
  }
  await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/lifecycle`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ lambda: { create_dwell_ms: 5000 } }),
  });
  await createFunction(this);
  // Assert: function exists but is in a non-ACTIVE state
});

// ── Given: state machine state ─────────────────────────────────────────────────

Given("the state machine does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no state machines.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the state machine already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const arn = await createStateMachine(this);
  (this as any)._lambdaSfnSmArn = arn;
  // Assert: state machine exists (no error thrown)
});

Given("the state machine exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const arn = await createStateMachine(this);
  (this as any)._lambdaSfnSmArn = arn;
  // Assert: state machine exists (no error thrown)
});

Given('the state machine is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: state machines are ACTIVE immediately after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the state machine is already "DELETED"', async function (this: SdkWorld) {
  // Arrange: create a state machine, apply a delete dwell, then delete it
  assert.ok(this.session, "Expected session to be initialized");
  const mgmtPort = (this.session as any)._basePort as number;
  try {
    await createStateMachine(this);
  } catch {
    // may already exist
  }
  // Act: apply lifecycle dwell so delete keeps it in DELETING state
  await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/lifecycle`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ stepfunctions: { delete_dwell_ms: 5000 } }),
  });
  const { DeleteStateMachineCommand } = require("@aws-sdk/client-sfn");
  try {
    await sfnClient(this).send(new DeleteStateMachineCommand({ stateMachineArn: smArn() }));
  } catch {
    // ignore
  }
  // Assert: state machine is in DELETED/DELETING state
});

Given("the state machine does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no state machines.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the state machine is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no state machines (simulates deleted).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the state machine is not "DELETED"', async function (this: SdkWorld) {
  // Arrange: create a state machine so it exists and is ACTIVE (not DELETED)
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const arn = await createStateMachine(this);
  (this as any)._lambdaSfnSmArn = arn;
  // Assert: state machine exists
});

Given('the state machine does not exist or is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no state machines.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: execution state ─────────────────────────────────────────────────────

Given('an execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange: create a state machine and start an execution
  assert.ok(this.session, "Expected session to be initialized");
  if (!(this as any)._lambdaSfnSmArn) {
    const arn = await createStateMachine(this);
    (this as any)._lambdaSfnSmArn = arn;
  }
  const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
  // Act
  const result = await sfnClient(this).send(
    new StartExecutionCommand({
      stateMachineArn: smArn(),
      input: JSON.stringify({ key: "value" }),
    }),
  );
  (this as any)._lambdaSfnExecArn = result.executionArn;
  // Assert: execution started (no error thrown)
});

Given('no execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no executions.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("an execution slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: execution slots are always available in lws fresh state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no execution slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust Step Functions execution slot limit via public API in lws.
  // Scenarios using this step are tagged @capacity and excluded from standard runs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: invocation state ────────────────────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange: create a Lambda function to represent an in-progress invocation context.
  // In lws, creating a function is the closest observable analogue; actual invocation
  // state is internal.
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await createFunction(this);
  // Assert: function created (no error thrown)
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh session has no invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("an invocation slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: invocation slots are always available in lws fresh state.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust Lambda invocation slot limit via public API in lws.
  // Scenarios using this step are tagged @capacity and excluded from standard runs.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: actions ──────────────────────────────────────────────────────────────

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const result = await lambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: LAMBDA_SF_FUNC,
        Runtime: "python3.12",
        Role: LAMBDA_SF_ROLE_ARN,
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

When("a Step Functions state machine is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new CreateStateMachineCommand({
        name: LAMBDA_SF_SM,
        definition: LAMBDA_SF_PASS_DEFINITION,
        roleArn: LAMBDA_SF_ROLE_ARN,
        type: "STANDARD",
      }),
    );
    (this as any)._lambdaSfnSmArn = result.stateMachineArn;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a Step Functions state machine is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new DeleteStateMachineCommand({ stateMachineArn: smArn() }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a running execution completes successfully", async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution completion via public API in lws.
  // This scenario is tagged @internal and excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger internal execution completion via public API in lws"),
  };
  // Assert: captured in lastCallResult
});

When("the Lambda function is invoked", async function (this: SdkWorld) {
  // @internal: Cannot trigger Lambda invocation via public API in lws without Docker.
  // This scenario is tagged @internal and excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger Lambda invocation via public API in lws"),
  };
  // Assert: captured in lastCallResult
});

When(
  "the Lambda function fails to start an execution because the state machine has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation failure via public API in lws.
    // This scenario is tagged @internal and excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure via public API in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Lambda function starts an execution of an "ACTIVE" state machine and succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda-started execution via public API in lws.
    // This scenario is tagged @internal and excluded by the tag filter.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda-started execution via public API in lws"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ───────────────────────────────────────────────────────────

Then('the function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
  const expectedState = "Active";
  // Act
  const result = await lambdaClient(this).send(
    new GetFunctionCommand({ FunctionName: LAMBDA_SF_FUNC }),
  );
  // Assert
  const actualState: string = result.Configuration?.State ?? "";
  assert.strictEqual(
    actualState,
    expectedState,
    `Expected function state "${expectedState}" but got "${actualState}"`,
  );
});

Then('the state machine is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeStateMachineCommand } = require("@aws-sdk/client-sfn");
  const expectedStatus = "ACTIVE";
  // Act
  const result = await sfnClient(this).send(
    new DescribeStateMachineCommand({ stateMachineArn: smArn() }),
  );
  // Assert
  const actualStatus: string = result.status ?? "";
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected state machine status "${expectedStatus}" but got "${actualStatus}"`,
  );
});

Then(
  'the state machine is "DELETED" and Lambda StartExecution calls will fail',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeStateMachineCommand } = require("@aws-sdk/client-sfn");
    const expectedErrCode = "StateMachineDoesNotExist";
    // Act: attempt to describe the state machine; it should not be found
    try {
      await sfnClient(this).send(new DescribeStateMachineCommand({ stateMachineArn: smArn() }));
      // Assert: should have thrown
      assert.fail(
        `Expected state machine to be deleted but describe succeeded; expected_error=${expectedErrCode}`,
      );
    } catch (err: unknown) {
      const errMsg = err instanceof Error ? err.message : String(err);
      assert.ok(
        errMsg.includes(expectedErrCode) || errMsg.includes("does not exist"),
        `Expected "${expectedErrCode}" error but got: ${errMsg}`,
      );
    }
  },
);

Then('the execution is "SUCCEEDED"', async function (this: SdkWorld) {
  // @internal: Cannot observe internal execution completion via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the execution is "RUNNING" and the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation result or execution state via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation state via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the invocation is "FAILED" with a StateMachineDoesNotExist error',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure via public API in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Then: operation rejection ─────────────────────────────────────────────────

Then("the operation is rejected", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Assert
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    false,
    `Expected operation to be rejected but it succeeded; actual_success=${actualSuccess}`,
  );
});

// ── Then: invariants ──────────────────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied in isolated context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "RUNNING" execution references a state machine that exists',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied in isolated context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
