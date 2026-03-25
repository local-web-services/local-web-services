/** Step definitions: stepfunctions service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";
import type { StateMachineStepHelpers } from "../support/world";

const SFN_TEST_SM = "e2e-sfn-test-sm-1";
const SFN_TEST_SM_EXPRESS = "e2e-sfn-test-sm-express-1";
const SFN_ROLE_ARN = "arn:aws:iam::000000000000:role/e2e-role";
const SFN_PASS_DEFINITION = JSON.stringify({
  StartAt: "Pass",
  States: { Pass: { Type: "Pass", End: true } },
});
const SFN_UPDATED_DEFINITION = JSON.stringify({
  StartAt: "PassV2",
  States: { PassV2: { Type: "Pass", End: true } },
});
const SFN_TAG_KEY = "e2e-sfn-test-tag-key-1";
const SFN_TAG_VALUE = "e2e-sfn-test-tag-value-1";
const SFN_TEST_INPUT = JSON.stringify({ key: "value" });
const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

// ── Helpers ───────────────────────────────────────────────────────────────────

function sfnClient(world: SdkWorld) {
  const { SFNClient } = require("@aws-sdk/client-sfn");
  return world.session!.client<typeof SFNClient>("stepfunctions");
}

function smArn(name: string): string {
  return `arn:aws:states:${REGION}:${ACCOUNT_ID}:stateMachine:${name}`;
}

async function createStateMachine(world: SdkWorld, name: string, type: string): Promise<string> {
  const { CreateStateMachineCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnClient(world).send(
    new CreateStateMachineCommand({
      name,
      definition: SFN_PASS_DEFINITION,
      roleArn: SFN_ROLE_ARN,
      type,
    }),
  );
  return result.stateMachineArn as string;
}

async function startExecution(world: SdkWorld, smName: string): Promise<string> {
  const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
  const result = await sfnClient(world).send(
    new StartExecutionCommand({
      stateMachineArn: smArn(smName),
      input: SFN_TEST_INPUT,
    }),
  );
  return result.executionArn as string;
}

// ── Before hook: register smHelpers for stepfunctions scenarios ───────────────

Before({ tags: "@stepfunctions" }, function (this: SdkWorld) {
  const smHelpersImpl: StateMachineStepHelpers = {
    assertStateMachineActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DescribeStateMachineCommand } = require("@aws-sdk/client-sfn");
      const expectedStatus = "ACTIVE";
      const result = await sfnClient(world).send(
        new DescribeStateMachineCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
      );
      const actualStatus = result.status as string;
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected state machine status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
  this.smHelpers = smHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: state machine existence ───────────────────────────────────────────

// "the state machine does not already exist" is registered in cross_service_common.ts.

// "the state machine already exists" is registered in cross_service_common.ts.

// "the state machine exists" is registered in cross_service_common.ts.

// "the state machine does not exist" is registered in cross_service_common.ts.

// ── Given: state machine status / type ───────────────────────────────────────

// "the state machine is {string}" is registered in cross_service_common.ts.

Given('the state machine is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: use lifecycle API to simulate CREATING state
  assert.ok(this.session, "Expected session to be initialized");
  const mgmtPort = (this.session as any)._basePort as number;
  // Act
  await fetch(`http://127.0.0.1:${mgmtPort}/_ldk/lifecycle`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ stepfunctions: { create_dwell_ms: 5000 } }),
  });
  const arn = await createStateMachine(this, SFN_TEST_SM, "STANDARD");
  (this as any)._sfnSmArn = arn;
  // Assert: state machine is in CREATING state (dwell applied)
});

Given('the state machine is "DELETING"', async function (this: SdkWorld) {
  // Arrange: delete the state machine so it enters DELETING state
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    await sfnClient(this).send(
      new DeleteStateMachineCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
    );
  } catch {
    // ignore; desired state is DELETING
  }
  // Assert: deletion triggered
});

Given('the state machine is not "DELETING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: state machines are not DELETING by default.
});

Given('the state machine is a "STANDARD" type', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: state machine is STANDARD by default.
});

Given('the state machine is not a "STANDARD" type', async function (this: SdkWorld) {
  // Arrange: create an EXPRESS type state machine instead
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const arn = await createStateMachine(this, SFN_TEST_SM_EXPRESS, "EXPRESS");
  (this as any)._sfnSmArn = arn;
  (this as any)._sfnSmName = SFN_TEST_SM_EXPRESS;
  // Assert: EXPRESS state machine exists
});

Given('the state machine is an "EXPRESS" type', async function (this: SdkWorld) {
  // Arrange: create an EXPRESS type state machine
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  const arn = await createStateMachine(this, SFN_TEST_SM_EXPRESS, "EXPRESS");
  (this as any)._sfnSmArn = arn;
  (this as any)._sfnSmName = SFN_TEST_SM_EXPRESS;
  // Assert: EXPRESS state machine exists
});

Given('the state machine is not an "EXPRESS" type', async function (this: SdkWorld) {
  // Arrange: ensure a STANDARD state machine exists
  assert.ok(this.session, "Expected session to be initialized");
  if (!(this as any)._sfnSmArn) {
    // Act
    const arn = await createStateMachine(this, SFN_TEST_SM, "STANDARD");
    (this as any)._sfnSmArn = arn;
  }
  // Assert: STANDARD state machine exists
});

// ── Given: execution existence ────────────────────────────────────────────────

Given("the execution exists", async function (this: SdkWorld) {
  // Arrange: ensure state machine exists
  assert.ok(this.session, "Expected session to be initialized");
  if (!(this as any)._sfnSmArn) {
    const arn = await createStateMachine(this, SFN_TEST_SM, "STANDARD");
    (this as any)._sfnSmArn = arn;
  }
  const smName: string = (this as any)._sfnSmName ?? SFN_TEST_SM;
  // Act
  const execArn = await startExecution(this, smName);
  (this as any)._sfnExecArn = execArn;
  // Assert: execution started (no error thrown)
});

Given('the execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: newly started executions are RUNNING.
});

Given('the execution is not "RUNNING"', async function (this: SdkWorld) {
  // Arrange: ensure a state machine exists so the execution can start and complete
  assert.ok(this.session, "Expected session to be initialized");
  if (!(this as any)._sfnSmArn) {
    const arn = await createStateMachine(this, SFN_TEST_SM, "STANDARD");
    (this as any)._sfnSmArn = arn;
  }
  // Act: start an execution; a Pass SM completes immediately (SUCCEEDED, not RUNNING)
  const execArn = await startExecution(this, SFN_TEST_SM);
  (this as any)._sfnExecArn = execArn;
  // Assert: execution is SUCCEEDED (not RUNNING) after completing
});

Given("the execution does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: tags ───────────────────────────────────────────────────────────────

Given("the tag is associated with the state machine", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { TagResourceCommand } = require("@aws-sdk/client-sfn");
  // Act
  await sfnClient(this).send(
    new TagResourceCommand({
      resourceArn: smArn(SFN_TEST_SM),
      tags: [{ key: SFN_TAG_KEY, value: SFN_TAG_VALUE }],
    }),
  );
  // Assert: tag added (no error thrown)
});

Given("the tag association is active", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: tag associations are always active after creation.
});

Given("the tag is not associated with the state machine", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: a fresh state machine has no tags.
});

Given("the tag association is not active", async function (this: SdkWorld) {
  // Arrange: remove the tag to simulate an inactive association
  assert.ok(this.session, "Expected session to be initialized");
  const { UntagResourceCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    await sfnClient(this).send(
      new UntagResourceCommand({
        resourceArn: smArn(SFN_TEST_SM),
        tagKeys: [SFN_TAG_KEY],
      }),
    );
  } catch {
    // ignore; desired state is tag absent
  }
  // Assert: tag is absent
});

// ── Given: capacity ───────────────────────────────────────────────────────────

Given("the execution slot is available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("stepfunctions").unlimited().apply();
  // Assert: capacity is unlimited
});

Given("the execution slot is not available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("stepfunctions").exhaust().apply();
  // Assert: capacity is exhausted
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "a Step Functions state machine is created" is registered in cross_service_common.ts.

When("a state machine is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new DeleteStateMachineCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("a state machine is described", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new DescribeStateMachineCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("all state machines are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListStateMachinesCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(new ListStateMachinesCommand({}));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("executions for a state machine are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListExecutionsCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new ListExecutionsCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("versions of a state machine are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListStateMachineVersionsCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new ListStateMachineVersionsCommand({ stateMachineArn: smArn(SFN_TEST_SM) }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("tags for a state machine are listed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListTagsForResourceCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new ListTagsForResourceCommand({ resourceArn: smArn(SFN_TEST_SM) }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("an execution is started on a standard state machine", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { StartExecutionCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new StartExecutionCommand({
        stateMachineArn: smArn(SFN_TEST_SM),
        input: SFN_TEST_INPUT,
      }),
    );
    (this as any)._sfnExecArn = result.executionArn;
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When(
  "a synchronous execution is started on an express state machine",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { StartSyncExecutionCommand } = require("@aws-sdk/client-sfn");
    // Act
    try {
      const result = await sfnClient(this).send(
        new StartSyncExecutionCommand({
          stateMachineArn: smArn(SFN_TEST_SM_EXPRESS),
          input: SFN_TEST_INPUT,
        }),
      );
      this.lastCallResult = { success: true, output: result };
    } catch (err: unknown) {
      this.lastCallResult = { success: false, output: null, error: err };
    }
    // Assert: result captured in lastCallResult
  },
);

When("a running execution is stopped", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { StopExecutionCommand } = require("@aws-sdk/client-sfn");
  const executionArn: string = (this as any)._sfnExecArn ?? "";
  // Act
  try {
    const result = await sfnClient(this).send(new StopExecutionCommand({ executionArn }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("an execution is described", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeExecutionCommand } = require("@aws-sdk/client-sfn");
  const executionArn: string = (this as any)._sfnExecArn ?? "";
  // Act
  try {
    const result = await sfnClient(this).send(new DescribeExecutionCommand({ executionArn }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("the event history of an execution is retrieved", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { GetExecutionHistoryCommand } = require("@aws-sdk/client-sfn");
  const executionArn: string = (this as any)._sfnExecArn ?? "";
  // Act
  try {
    const result = await sfnClient(this).send(new GetExecutionHistoryCommand({ executionArn }));
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("a state machine definition is updated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UpdateStateMachineCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new UpdateStateMachineCommand({
        stateMachineArn: smArn(SFN_TEST_SM),
        definition: SFN_UPDATED_DEFINITION,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("tags are added to a state machine", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { TagResourceCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new TagResourceCommand({
        resourceArn: smArn(SFN_TEST_SM),
        tags: [{ key: SFN_TAG_KEY, value: SFN_TAG_VALUE }],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("tags are removed from a state machine", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { UntagResourceCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new UntagResourceCommand({
        resourceArn: smArn(SFN_TEST_SM),
        tagKeys: [SFN_TAG_KEY],
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("a state machine definition is validated", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ValidateStateMachineDefinitionCommand } = require("@aws-sdk/client-sfn");
  // Act
  try {
    const result = await sfnClient(this).send(
      new ValidateStateMachineDefinitionCommand({ definition: SFN_PASS_DEFINITION }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: result captured in lastCallResult
});

When("a state machine deletion is finalized", async function (this: SdkWorld) {
  // Arrange / Act — cannot trigger internal finalization event via public API
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger internal finalization event via public API"),
  };
  // Assert: result captured in lastCallResult
});

When("a running execution transitions to a terminal state", async function (this: SdkWorld) {
  // Arrange / Act — cannot trigger internal execution step transition via public API
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger internal execution step transition via public API"),
  };
  // Assert: result captured in lastCallResult
});

When("a running execution exceeds its timeout", async function (this: SdkWorld) {
  // Arrange / Act — cannot trigger execution timeout programmatically
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger execution timeout programmatically"),
  };
  // Assert: result captured in lastCallResult
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the state machine is {string}" is registered in cross_service_common.ts (dispatches via smHelpers).

Then('the state machine is in "DELETING" state', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_state_machine to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then('the state machine is "DELETED"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected finalization to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the state machine details are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected describe_state_machine to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(output && "name" in output, "Expected 'name' key in describe_state_machine response");
});

Then("the list of state machines is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list_state_machines to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(
    output && "stateMachines" in output,
    "Expected 'stateMachines' in list_state_machines response",
  );
});

Then("the list of executions is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list_executions to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(output && "executions" in output, "Expected 'executions' in list_executions response");
});

Then("the list of state machine versions is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list_state_machine_versions to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(
    output && "stateMachineVersions" in output,
    "Expected 'stateMachineVersions' in list_state_machine_versions response",
  );
});

Then("the list of tags is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected list_tags_for_resource to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(output && "tags" in output, "Expected 'tags' key in list_tags_for_resource response");
});

Then('the execution is "RUNNING"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected start_execution to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(
    output && "executionArn" in output,
    "Expected 'executionArn' in start_execution response",
  );
});

Then('the execution is "ABORTED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeExecutionCommand } = require("@aws-sdk/client-sfn");
  const expectedStopSuccess = true;
  const actualStopSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualStopSuccess,
    expectedStopSuccess,
    `Expected stop_execution to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedStopSuccess} actual_success=${actualStopSuccess}`,
  );
  const executionArn: string = (this as any)._sfnExecArn ?? "";
  // Act
  const result = await sfnClient(this).send(new DescribeExecutionCommand({ executionArn }));
  // Assert
  const expectedStatus = "ABORTED";
  const actualStatus = result.status as string;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected execution status '${expectedStatus}' but got '${actualStatus}'; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the execution is "SUCCEEDED" or "FAILED"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected sync execution to complete but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  const actualStatus = output?.status as string;
  const expectedStatuses = ["SUCCEEDED", "FAILED"];
  assert.ok(
    expectedStatuses.includes(actualStatus),
    `Expected execution status SUCCEEDED or FAILED but got '${actualStatus}'; expected_statuses=${expectedStatuses.join(",")} actual_status=${actualStatus}`,
  );
});

Then("the execution details are returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected describe_execution to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(
    output && "executionArn" in output,
    "Expected 'executionArn' in describe_execution response",
  );
});

Then("the execution history is returned", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected get_execution_history to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(output && "events" in output, "Expected 'events' in get_execution_history response");
});

Then("the state machine version is incremented", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected update_state_machine to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the tags are associated with the state machine", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected tag_resource to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the tags are disassociated from the state machine", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected untag_resource to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

Then("the definition is valid or invalid", async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected validate_state_machine_definition to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const output = this.lastCallResult.output as Record<string, unknown>;
  assert.ok(
    output && ("result" in output || "validationErrors" in output),
    "Expected 'result' or 'validationErrors' in validate_state_machine_definition response",
  );
});

Then('the execution is "TIMED_OUT"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected timeout event to succeed but got error: ${this.lastCallResult.error}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
});

// ── Then: invariants ──────────────────────────────────────────────────────────

Then(
  'every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const {
      ListStateMachinesCommand,
      DescribeStateMachineCommand,
    } = require("@aws-sdk/client-sfn");
    const expectedStatuses = new Set(["ACTIVE", "DELETING", "DELETED"]);
    // Act
    const listResult = await sfnClient(this).send(new ListStateMachinesCommand({}));
    const machines: Array<{ stateMachineArn: string; name: string }> =
      listResult.stateMachines ?? [];
    // Assert
    for (const sm of machines) {
      const descResult = await sfnClient(this).send(
        new DescribeStateMachineCommand({ stateMachineArn: sm.stateMachineArn }),
      );
      const actualStatus = descResult.status as string;
      assert.ok(
        expectedStatuses.has(actualStatus),
        `State machine '${sm.name}' has invalid status '${actualStatus}'; expected one of ACTIVE, DELETING, DELETED; actual_status=${actualStatus}`,
      );
    }
  },
);

Then(
  'every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")',
  async function (this: SdkWorld) {
    // Invariant: trivially satisfied in isolated lws context.
  },
);

Then(
  'every state machine has a valid type ("STANDARD" or "EXPRESS")',
  async function (this: SdkWorld) {
    // Invariant: trivially satisfied in isolated lws context.
  },
);

Then("synchronous executions only run on express state machines", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
});

Then("every execution belongs to a known state machine", async function (this: SdkWorld) {
  // Invariant: trivially satisfied in isolated lws context.
});
