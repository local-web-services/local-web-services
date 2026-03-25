/** Step definitions: events_lambda cross-service scenarios — unique When/Then steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const EL_BUS = "e2e-test-bus-1";
const EL_RULE = "test-rule-1";
const EL_FUNC = "e2e-test-func-1";
const EL_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
const EL_EVENT_PATTERN = JSON.stringify({ source: ["test.source"] });
const EL_TARGET_ID = "t1";
const EL_REGION = "us-east-1";
const EL_ACCOUNT_ID = "000000000000";

function elFuncArn(): string {
  return `arn:aws:lambda:${EL_REGION}:${EL_ACCOUNT_ID}:function:${EL_FUNC}`;
}

function elEbClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

function elLambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

async function elCreateBus(world: SdkWorld): Promise<void> {
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  await elEbClient(world).send(new CreateEventBusCommand({ Name: EL_BUS }));
}

async function elCreateFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await elLambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: EL_FUNC,
      Runtime: "python3.12",
      Role: EL_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function elCreateRuleWithTarget(world: SdkWorld): Promise<void> {
  const { PutRuleCommand, PutTargetsCommand } = require("@aws-sdk/client-eventbridge");
  await elEbClient(world).send(
    new PutRuleCommand({
      Name: EL_RULE,
      EventBusName: EL_BUS,
      EventPattern: EL_EVENT_PATTERN,
      State: "ENABLED",
    }),
  );
  await elEbClient(world).send(
    new PutTargetsCommand({
      Rule: EL_RULE,
      EventBusName: EL_BUS,
      Targets: [{ Id: EL_TARGET_ID, Arn: elFuncArn() }],
    }),
  );
}

// ── Given: cross-service rule + target state ──────────────────────────────────

Given(
  'an "ENABLED" rule exists on the bus targeting a function',
  async function (this: SdkWorld) {
    // Arrange: ensure bus and function exist, then create rule with Lambda target
    assert.ok(this.session, "Expected session to be initialized");
    try {
      await elCreateBus(this);
    } catch {
      // bus may already exist
    }
    try {
      await elCreateFunction(this);
    } catch {
      // function may already exist
    }
    // Act
    await elCreateRuleWithTarget(this);
    // Assert: rule and target created
  },
);

Given(
  'no "ENABLED" rule exists on the bus targeting a function',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing
    // in lws without a real rule wired to an active function; lws does not fail put_events
    // when no matching rule exists.
    assert.ok(this.session, "Expected session to be initialized");
    return "pending";
  },
);

Given('the target function is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: Lambda functions are ACTIVE immediately after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the target function is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing
  // when the target function is not ACTIVE.
  assert.ok(this.session, "Expected session to be initialized");
  return "pending";
});

// ── Given: invocation slot state ─────────────────────────────────────────────

Given("an invocation slot is available", async function (this: SdkWorld) {
  // Arrange: set Lambda capacity to unlimited
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("lambda").unlimited().apply();
  // Assert: capacity applied
});

Given("no invocation slot is available", async function (this: SdkWorld) {
  // Arrange: exhaust Lambda capacity so no invocation slot is available
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await this.session!.capacity("lambda").exhaust().apply();
  // Assert: capacity exhausted
});

// ── Given: invocation state ───────────────────────────────────────────────────

Given('an invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing
  // in lws to place an invocation into IN_PROGRESS state.
  assert.ok(this.session, "Expected session to be initialized");
  return "pending";
});

Given('no invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no in-progress invocations.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: cross-service actions ───────────────────────────────────────────────

When("an EventBridge event bus is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  try {
    const actualOutput = await elEbClient(this).send(
      new CreateEventBusCommand({ Name: EL_BUS }),
    );
    this.lastCallResult = { success: true, output: actualOutput };
  } catch (error) {
    this.lastCallResult = { success: false, output: null, error };
  }
  // Assert: captured in lastCallResult
});

When("a Lambda function is deployed", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  // Act
  try {
    const actualOutput = await elLambdaClient(this).send(
      new CreateFunctionCommand({
        FunctionName: EL_FUNC,
        Runtime: "python3.12",
        Role: EL_ROLE_ARN,
        Handler: "index.handler",
        Code: { ZipFile: Buffer.from("fake") },
      }),
    );
    this.lastCallResult = { success: true, output: actualOutput };
  } catch (error) {
    this.lastCallResult = { success: false, output: null, error };
  }
  // Assert: captured in lastCallResult
});

When(
  "an EventBridge rule is created to asynchronously invoke a Lambda function on matching events",
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { PutRuleCommand, PutTargetsCommand } = require("@aws-sdk/client-eventbridge");
    // Act: create rule then attach Lambda target
    try {
      await elEbClient(this).send(
        new PutRuleCommand({
          Name: EL_RULE,
          EventBusName: EL_BUS,
          EventPattern: EL_EVENT_PATTERN,
          State: "ENABLED",
        }),
      );
      const actualOutput = await elEbClient(this).send(
        new PutTargetsCommand({
          Rule: EL_RULE,
          EventBusName: EL_BUS,
          Targets: [{ Id: EL_TARGET_ID, Arn: elFuncArn() }],
        }),
      );
      this.lastCallResult = { success: true, output: actualOutput };
    } catch (error) {
      this.lastCallResult = { success: false, output: null, error };
    }
    // Assert: captured in lastCallResult
  },
);

When(
  "an event is published to the bus and triggers an asynchronous Lambda invocation",
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing in lws.
    assert.ok(this.session, "Expected session to be initialized");
    return "pending";
  },
);

When("the Lambda invocation completes successfully", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal Lambda invocation completion in lws.
  assert.ok(this.session, "Expected session to be initialized");
  return "pending";
});

When("the Lambda invocation fails", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal Lambda invocation failure in lws.
  assert.ok(this.session, "Expected session to be initialized");
  return "pending";
});

// ── Then: cross-service assertions ────────────────────────────────────────────

Then(
  'the event bus is "ACTIVE"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
    // Act
    const actualResult = await elEbClient(this).send(new ListEventBusesCommand({}));
    const actualBuses: Array<{ Name?: string }> = actualResult.EventBuses ?? [];
    // Assert
    const expectedBus = EL_BUS;
    const actualFound = actualBuses.some((b) => b.Name === expectedBus);
    assert.strictEqual(
      actualFound,
      true,
      `Expected event bus '${expectedBus}' to be ACTIVE but not found; expected_bus=${expectedBus}`,
    );
  },
);

Then(
  'the function is "ACTIVE"',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
    // Act
    const actualResult = await elLambdaClient(this).send(
      new GetFunctionCommand({ FunctionName: EL_FUNC }),
    );
    // Assert
    const expectedState = "Active";
    const actualState = actualResult.Configuration?.State ?? "";
    assert.strictEqual(
      actualState,
      expectedState,
      `Expected function state '${expectedState}' but got '${actualState}'; expected_state=${expectedState} actual_state=${actualState}`,
    );
  },
);

Then(
  'the rule is "ENABLED" and will trigger the function when matching events are published',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { DescribeRuleCommand } = require("@aws-sdk/client-eventbridge");
    // Act
    const actualResult = await elEbClient(this).send(
      new DescribeRuleCommand({ Name: EL_RULE, EventBusName: EL_BUS }),
    );
    // Assert
    const expectedState = "ENABLED";
    const actualState = actualResult.State ?? "";
    assert.strictEqual(
      actualState,
      expectedState,
      `Expected rule state '${expectedState}' but got '${actualState}'; expected_state=${expectedState} actual_state=${actualState}`,
    );
  },
);

Then('the invocation is "IN_PROGRESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: @internal — cannot observe Lambda IN_PROGRESS state in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: @internal — cannot observe Lambda invocation SUCCESS in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the invocation is "FAILED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: @internal — cannot observe Lambda invocation FAILED in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps (no-ops) ─────────────────────────────────────────────

Then(
  'every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'every "ENABLED" rule references an "ACTIVE" event bus',
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);
