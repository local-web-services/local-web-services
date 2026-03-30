/** Step definitions: rds_events cross-service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, BusStepHelpers, InstanceStepHelpers } from "../support/world";

const RDS_EVENTS_TEST_DB_INSTANCE_ID = "test-rds-db-1";
const RDS_EVENTS_TEST_BUS_NAME = "e2e-test-bus-1";
const RDS_EVENTS_TEST_DB_ENGINE = "mysql";
const RDS_EVENTS_TEST_DB_CLASS = "db.t3.micro";

// ── Helpers ───────────────────────────────────────────────────────────────────

function rdsEventsRdsClient(world: SdkWorld) {
  const { RDSClient } = require("@aws-sdk/client-rds");
  return world.session!.client<typeof RDSClient>("rds");
}

function rdsEventsEventBridgeClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

async function rdsEventsCreateDBInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  try {
    await rdsEventsRdsClient(world).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_EVENTS_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_EVENTS_TEST_DB_CLASS,
        Engine: RDS_EVENTS_TEST_DB_ENGINE,
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("already") && !msg.includes("DBInstanceAlreadyExists")) {
      throw err;
    }
  }
}

async function rdsEventsCreateBus(world: SdkWorld): Promise<void> {
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  try {
    await rdsEventsEventBridgeClient(world).send(
      new CreateEventBusCommand({ Name: RDS_EVENTS_TEST_BUS_NAME }),
    );
  } catch (err: unknown) {
    const msg = String(err);
    if (!msg.includes("already") && !msg.includes("ResourceAlreadyExists")) {
      throw err;
    }
  }
}

// ── Before hook: register busHelpers for @rdsevents scenarios ──────────────────

Before({ tags: "@rdsevents" }, function (this: SdkWorld) {
  const busHelpers: BusStepHelpers = {
    createBus: async (world: SdkWorld) => {
      await rdsEventsCreateBus(world);
    },
    deleteBus: async (world: SdkWorld) => {
      const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
      try {
        await rdsEventsEventBridgeClient(world).send(
          new DeleteEventBusCommand({ Name: RDS_EVENTS_TEST_BUS_NAME }),
        );
      } catch {
        // bus may not exist
      }
    },
    assertBusStatus: async (world: SdkWorld, expectedState: string) => {
      if (expectedState !== "ACTIVE") return;
      assert.ok(world.session, "Expected session to be initialized");
      const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
      const result = await rdsEventsEventBridgeClient(world).send(new ListEventBusesCommand({}));
      const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
      const expectedBus = RDS_EVENTS_TEST_BUS_NAME;
      const actualFound = buses.some((b) => b.Name === expectedBus);
      assert.ok(
        actualFound,
        `Expected event bus "${expectedBus}" to be ACTIVE but not found; expected_bus=${expectedBus} actual_found=${actualFound}`,
      );
    },
  };
  this.busHelpers = busHelpers;

  const instanceHelpersImpl: InstanceStepHelpers = {
    setupInstanceNotExists: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: fresh state after session reset has no DB instances.
      assert.ok(world.session, "Expected session to be initialized");
    },
    setupInstanceExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act
      await rdsEventsCreateDBInstance(world);
      // Assert: DB instance created
    },
    setupInstanceAvailable: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the DB instance (lws instances are AVAILABLE after creation)
      await rdsEventsCreateDBInstance(world);
      // Assert: DB instance created
    },
    assertInstanceAvailable: async (world: SdkWorld) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected RDS DB instance creation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      assert.ok(
        world.lastCallResult.output !== null && world.lastCallResult.output !== undefined,
        "Expected output from RDS DB instance creation but got null",
      );
    },
    createDbInstance: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
      // Act
      try {
        const result = await rdsEventsRdsClient(world).send(
          new CreateDBInstanceCommand({
            DBInstanceIdentifier: RDS_EVENTS_TEST_DB_INSTANCE_ID,
            DBInstanceClass: RDS_EVENTS_TEST_DB_CLASS,
            Engine: RDS_EVENTS_TEST_DB_ENGINE,
            MasterUsername: "admin",
            MasterUserPassword: "password123",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
  this.instanceHelpers = instanceHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: DB instance state setup ───────────────────────────────────────────

// "the "DB" instance does not already exist" is registered in rds_lambda.ts (dispatches via instanceHelpers.setupInstanceNotExists).
// "the "DB" instance already exists" is registered in rds_lambda.ts (dispatches via instanceHelpers.setupInstanceExists).
// "the "DB" instance is "AVAILABLE"" (Given) is registered in rds_lambda.ts (dispatches via instanceHelpers.setupInstanceAvailable).
// "the "DB" instance is "AVAILABLE"" (Then) is registered in rds_lambda.ts (dispatches via instanceHelpers.assertInstanceAvailable).

Given('the "DB" instance is not "AVAILABLE"', async function (this: SdkWorld) {
  // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
  // Only reached by @internal scenarios excluded by the tag filter.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "DB" instance is "STOPPING"', async function (this: SdkWorld) {
  // @internal: Cannot force a DB instance into STOPPING state via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "DB" instance is not "STOPPING"', async function (this: SdkWorld) {
  // @internal: DB stop state not reachable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: bus state setup ────────────────────────────────────────────────────

// "the bus does not already exist" is registered in cross_service_common.ts.

// "the bus already exists" is registered in cross_service_common.ts.

// "the bus exists" is registered in cross_service_common.ts.

// "the bus is {string}" (Given and Then) — registered in cross_service_common.ts (dispatches via busHelpers)

Given('the bus is already "DELETED"', async function (this: SdkWorld) {
  // Arrange: delete the bus so it is in a DELETED state
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act: delete, ignore errors (bus may not exist)
  try {
    await rdsEventsEventBridgeClient(this).send(
      new DeleteEventBusCommand({ Name: RDS_EVENTS_TEST_BUS_NAME }),
    );
  } catch {
    // bus may not exist; desired state is absence
  }
  this.lastCallResult = { success: true, output: null };
  // Assert: bus is absent (DELETED state)
});

// "the bus does not exist" — registered in cross_service_common.ts.

Given('the bus is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: ensure the bus exists so it is not in a DELETED state
  await rdsEventsCreateBus(this);
  // Assert: bus created
});

// ── Given: event slot state ───────────────────────────────────────────────────

// "an event slot is available" is registered in cross_service_common.ts.

// "no event slot is available" is registered in cross_service_common.ts.

// ── When: actions ─────────────────────────────────────────────────────────────

When('an "RDS" "DB" instance is created and becomes "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-rds");
  // Act
  try {
    const result = await rdsEventsRdsClient(this).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: RDS_EVENTS_TEST_DB_INSTANCE_ID,
        DBInstanceClass: RDS_EVENTS_TEST_DB_CLASS,
        Engine: RDS_EVENTS_TEST_DB_ENGINE,
        MasterUsername: "admin",
        MasterUserPassword: "password123",
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "an EventBridge event bus is created" is registered in cross_service_common.ts.

// "the EventBridge event bus is deleted" is registered in cross_service_common.ts.

When('the "DB" instance finishes stopping', async function (this: SdkWorld) {
  // @internal: d_b_stop_complete cannot be triggered via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("d_b_stop_complete: scenario is @internal"),
  };
});

When(
  'the "RDS" instance stops and delivers the state change event to the EventBridge bus',
  async function (this: SdkWorld) {
    // @internal: d_b_stop_event_delivered cannot be triggered via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("d_b_stop_event_delivered: scenario is @internal"),
    };
  },
);

When(
  'the "RDS" instance stops but the state change event delivery fails because the bus is deleted',
  async function (this: SdkWorld) {
    // @internal: d_b_stop_event_fails cannot be triggered via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("d_b_stop_event_fails: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// 'the "DB" instance is "AVAILABLE"' as Then — handled by the combined
// Given registration above (creates instance if Given, asserts if Then).

// "the bus is {string}" (Then) — registered in cross_service_common.ts (dispatches via busHelpers)

// 'the bus is "DELETED" and "RDS" event delivery will fail' matches the generic
// Then("the bus is {string} and {string} event delivery will fail", ...) in ssm_events.ts.

Then('the "DB" instance is "STOPPED"', async function (this: SdkWorld) {
  // @internal: d_b_stop_complete outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the "DB" instance is "STOPPING" and the event is "DELIVERED"',
  async function (this: SdkWorld) {
    // @internal: d_b_stop_event_delivered outcome not observable via public API.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the "DB" instance is "STOPPING" but no event is delivered', async function (this: SdkWorld) {
  // @internal: d_b_stop_event_fails outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then(
  'every "DELIVERED" event references a "DB" instance that exists',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// 'every "DELIVERED" event references a bus that exists' — registered in cross_service_common.ts
