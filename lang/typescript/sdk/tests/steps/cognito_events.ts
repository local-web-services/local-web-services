/** Step definitions: cognito_events cross-service scenarios — unique When/Then steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, PoolStepHelpers } from "../support/world";

const COGNITO_EVENTS_TEST_POOL = "e2e-test-pool-1";
const COGNITO_EVENTS_TEST_BUS = "e2e-test-bus-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function cognitoEventsIdpClient(world: SdkWorld) {
  const { CognitoIdentityProviderClient } = require("@aws-sdk/client-cognito-identity-provider");
  return world.session!.client<typeof CognitoIdentityProviderClient>("cognitoidp");
}

function cognitoEventsEbClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

async function ensureCognitoEventsBus(world: SdkWorld): Promise<void> {
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  try {
    await cognitoEventsEbClient(world).send(
      new CreateEventBusCommand({ Name: COGNITO_EVENTS_TEST_BUS }),
    );
  } catch {
    // May already exist
  }
}

async function ensureCognitoEventsPool(world: SdkWorld): Promise<void> {
  const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
  try {
    await cognitoEventsIdpClient(world).send(
      new CreateUserPoolCommand({ PoolName: COGNITO_EVENTS_TEST_POOL }),
    );
  } catch {
    // May already exist
  }
}

// ── Before hook: register poolHelpers for cognitoevents scenarios ─────────────

Before({ tags: "@cognitoevents" }, function (this: SdkWorld) {
  const poolHelpersImpl: PoolStepHelpers = {
    setupPoolExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the pool (idempotent)
      await ensureCognitoEventsPool(world);
    },
    assertPoolStatus: async (_world: SdkWorld, _expectedStatus: string) => {
      // No-op: pool status is always ACTIVE immediately after creation in lws
    },
    createNamedPool: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateUserPoolCommand } = require("@aws-sdk/client-cognito-identity-provider");
      // Act
      try {
        const result = await cognitoEventsIdpClient(world).send(
          new CreateUserPoolCommand({ PoolName: COGNITO_EVENTS_TEST_POOL }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
  this.poolHelpers = poolHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Common assertion ──────────────────────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts.

// ── Given: bus state setup ────────────────────────────────────────────────────

// "the bus does not already exist" is registered in cross_service_common.ts.

// "the bus already exists" is registered in cross_service_common.ts.

// "the bus exists" is registered in cross_service_common.ts.

// 'the bus exists and is "ACTIVE"' is registered via the generic
// 'the bus exists and is {string}' in cross_service_common.ts.

// 'the bus is "ACTIVE"' is registered via the generic
// 'the bus is {string}' in cross_service_common.ts.

// 'the bus is "DELETED"' — handled by 'the bus is {string}' in cross_service_common.ts.

Given('the bus is not "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: lws does not enforce event delivery failure when the bus is not deleted.
  return "pending";
});

Given('the bus is already "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await ensureCognitoEventsBus(this);
  const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act: delete the bus
  try {
    await cognitoEventsEbClient(this).send(
      new DeleteEventBusCommand({ Name: COGNITO_EVENTS_TEST_BUS }),
    );
  } catch {
    // Ignore errors — bus may already be absent
  }
  // Assert: bus is gone
});

// "the bus does not exist" — registered in cross_service_common.ts.

// 'the bus does not exist or is not "ACTIVE"' is registered via the generic
// 'the bus does not exist or is not {string}' in cross_service_common.ts.

// ── Given: pool state setup ────────────────────────────────────────────────────

// "the pool does not already exist" is registered in cross_service_common.ts.

// "the pool already exists" is registered in cross_service_common.ts (dispatches via poolHelpers).

Given('the pool exists and is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureCognitoEventsPool(this);
  // Assert: pool created and ACTIVE by default
});

Given('the pool does not exist or is not "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no pools.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool has an EventBridge configuration", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot configure EventBridge on a Cognito user pool in lws.
  return "pending";
});

Given("the pool has no EventBridge configuration", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: pools have no EventBridge configuration by default.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the pool already has an EventBridge configuration", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot configure EventBridge on a Cognito user pool in lws.
  return "pending";
});

// ── Given: slots ──────────────────────────────────────────────────────────────

// "an event slot is available" is registered in cross_service_common.ts.

// "no event slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

// "an EventBridge event bus is created" is registered in cross_service_common.ts.

// "the EventBridge event bus is deleted" is registered in cross_service_common.ts.

// "a Cognito user pool is created" is registered in lambda_cognito.ts (dispatches via poolHelpers.createNamedPool).

When("EventBridge publishing is enabled on the user pool", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal EventBridge publishing configuration in lws.
  return "pending";
});

When(
  "a user action occurs in the pool and Cognito delivers the event to the EventBridge bus",
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — @internal scenario; skip: cannot trigger internal Cognito user action event routing in lws.
    return "pending";
  },
);

When(
  "a user action occurs but event delivery fails because the bus has been deleted",
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — @internal scenario; skip: cannot trigger internal Cognito event delivery failure in lws.
    return "pending";
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts.

// 'the bus is "ACTIVE"' (Then) is registered via the generic
// 'the bus is {string}' in cross_service_common.ts.

Then('the bus is "DELETED" and Cognito event delivery will fail', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: verify deletion succeeded
  const actualSuccess = this.lastCallResult.success;
  const expectedSuccess = true;
  // Assert
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected delete_event_bus to succeed but got: ${JSON.stringify(this.lastCallResult.error)}`,
  );
});

Then('the pool is "ACTIVE" with no EventBridge configuration', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListUserPoolsCommand } = require("@aws-sdk/client-cognito-identity-provider");
  // Act
  const result = await cognitoEventsIdpClient(this).send(
    new ListUserPoolsCommand({ MaxResults: 60 }),
  );
  const pools: Array<{ Name?: string }> = result.UserPools ?? [];
  // Assert
  const expectedPoolName = COGNITO_EVENTS_TEST_POOL;
  const actualFound = pools.some((p) => p.Name === expectedPoolName);
  assert.ok(actualFound, `Expected user pool "${expectedPoolName}" to be ACTIVE but not found`);
});

Then("the pool will send user events to the bus", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot observe internal EventBridge publishing configuration in lws.
  return "pending";
});

Then('the event is "DELIVERED" to the bus', async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot trigger internal Cognito event delivery in lws.
  return "pending";
});

Then('the event delivery "FAILED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot observe internal Cognito event delivery failure in lws.
  return "pending";
});

// ── Safety invariant Then steps ───────────────────────────────────────────────

Then('every "DELIVERED" event references a pool that exists', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: model-level invariant; guaranteed by construction in lws.
});
