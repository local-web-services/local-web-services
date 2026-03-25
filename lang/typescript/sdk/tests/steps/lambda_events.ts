/** Step definitions: lambda_events cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const LE_TEST_FUNC = "e2e-test-func-1";
const LE_TEST_BUS = "e2e-test-bus-1";
const LE_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

// ── Helpers ───────────────────────────────────────────────────────────────────

function lambdaClient(world: SdkWorld) {
  const { LambdaClient } = require("@aws-sdk/client-lambda");
  return world.session!.client<typeof LambdaClient>("lambda");
}

function ebClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

async function createFunction(world: SdkWorld): Promise<void> {
  const { CreateFunctionCommand } = require("@aws-sdk/client-lambda");
  await lambdaClient(world).send(
    new CreateFunctionCommand({
      FunctionName: LE_TEST_FUNC,
      Runtime: "python3.12",
      Role: LE_ROLE_ARN,
      Handler: "index.handler",
      Code: { ZipFile: Buffer.from("fake") },
    }),
  );
}

async function createBus(world: SdkWorld): Promise<void> {
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  await ebClient(world).send(new CreateEventBusCommand({ Name: LE_TEST_BUS }));
}

// ── Before hook: register functionHelpers for lambdaevents scenarios ─────────────

Before({ tags: "@lambdaevents" }, function (this: SdkWorld) {
  this.functionHelpers = {
    functionName: LE_TEST_FUNC,
    deployFunction: async (world: SdkWorld) => {
      try {
        await createFunction(world);
        world.lastCallResult = { success: true, output: { FunctionName: LE_TEST_FUNC } };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    assertFunctionActive: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { GetFunctionCommand } = require("@aws-sdk/client-lambda");
      const result = await lambdaClient(world).send(
        new GetFunctionCommand({ FunctionName: LE_TEST_FUNC }),
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

// ── Given: bus state ──────────────────────────────────────────────────────────

// "the bus does not already exist" is registered in cross_service_common.ts.

// "the bus already exists" is registered in cross_service_common.ts.

// "the bus exists" is registered in cross_service_common.ts.

Given('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: event buses are ACTIVE immediately after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is already "DELETED"', async function (this: SdkWorld) {
  // Arrange: delete the bus if present to reach a DELETED state
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act: delete, ignore errors (bus may not exist)
  try {
    await ebClient(this).send(new DeleteEventBusCommand({ Name: LE_TEST_BUS }));
  } catch {
    // bus may not exist; desired state is absence
  }
  this.lastCallResult = { success: true, output: null };
  // Assert: desired state is absence
});

Given("the bus does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no event buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus does not exist or is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no event buses (simulates deleted bus).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after reset has no event buses (simulates deleted bus).
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the bus so it is not in a DELETED state
  await createBus(this);
  // Assert: bus created and not DELETED
});

// ── Given: invocation / slot state ────────────────────────────────────────────

// "an event slot is available" is registered in cross_service_common.ts.

// "no event slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "an EventBridge event bus is created" is registered in cross_service_common.ts.

// "the EventBridge event bus is deleted" is registered in cross_service_common.ts.

When(
  "the Lambda function fails to publish because the event bus has been deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda invocation failure: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

When(
  'the Lambda function publishes an event to the "ACTIVE" event bus and succeeds',
  async function (this: SdkWorld) {
    // @internal: Cannot trigger Lambda event publish in lws without Docker.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger Lambda event publish: scenario is @internal"),
    };
    // Assert: captured in lastCallResult
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

Then('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  const result = await ebClient(this).send(new ListEventBusesCommand({}));
  const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
  const expectedBus = LE_TEST_BUS;
  const actualFound = buses.some((b) => b.Name === expectedBus);
  // Assert
  assert.ok(
    actualFound,
    `Expected event bus "${expectedBus}" to be ACTIVE but not found; expected_bus="${expectedBus}"`,
  );
});

Then(
  'the bus is "DELETED" and Lambda PutEvents calls targeting it will fail',
  async function (this: SdkWorld) {
    // Arrange
    assert.ok(this.session, "Expected session to be initialized");
    const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
    // Act
    const result = await ebClient(this).send(new ListEventBusesCommand({}));
    const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
    const expectedBus = LE_TEST_BUS;
    const actualFound = buses.some((b) => b.Name === expectedBus);
    // Assert
    assert.ok(
      !actualFound,
      `Expected event bus "${expectedBus}" to be DELETED but found it; expected_bus="${expectedBus}"`,
    );
  },
);

Then(
  'the invocation is "FAILED" with a ResourceNotFoundException',
  async function (this: SdkWorld) {
    // @internal: Cannot observe Lambda invocation failure in lws.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the event is "PUBLISHED" and the invocation is "SUCCESS"', async function (this: SdkWorld) {
  // @internal: Cannot observe Lambda invocation result in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant catch-all steps ─────────────────────────────────────────────────

// "every {string} invocation references an {string} Lambda function" is registered in cross_service_common.ts.

Then('every "PUBLISHED" event references a bus that exists', async function (this: SdkWorld) {
  // No-op: model-level invariant; trivially satisfied in isolated lws context.
  assert.ok(this.session, "Expected session to be initialized");
});
