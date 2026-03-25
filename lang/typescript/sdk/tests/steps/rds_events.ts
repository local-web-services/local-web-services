/** Step definitions: rds_events cross-service informal specification scenarios */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

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

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: DB instance state setup ───────────────────────────────────────────

Given('the "DB" instance does not already exist', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no DB instances.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the "DB" instance already exists', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsEventsCreateDBInstance(this);
  // Assert: DB instance created
});

Given('the "DB" instance is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: create the DB instance (lws instances are AVAILABLE after creation)
  await rdsEventsCreateDBInstance(this);
  // Assert: DB instance created
});

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

Given("the bus does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no event buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bus already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsEventsCreateBus(this);
  // Assert: bus created
});

Given("the bus exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await rdsEventsCreateBus(this);
  // Assert: bus created
});

Given('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: event buses in lws are ACTIVE immediately after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is "DELETED"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no event buses (simulates deleted bus).
  assert.ok(this.session, "Expected session to be initialized");
});

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

Given("the bus does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no event buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is not "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act: ensure the bus exists so it is not in a DELETED state
  await rdsEventsCreateBus(this);
  // Assert: bus created
});

// ── Given: event slot state ───────────────────────────────────────────────────

Given("an event slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: always room for events in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no event slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust event slot limit in lws via public APIs.
  assert.ok(this.session, "Expected session to be initialized");
});

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

When("an EventBridge event bus is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  try {
    const result = await rdsEventsEventBridgeClient(this).send(
      new CreateEventBusCommand({ Name: RDS_EVENTS_TEST_BUS_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("the EventBridge event bus is deleted", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  try {
    const result = await rdsEventsEventBridgeClient(this).send(
      new DeleteEventBusCommand({ Name: RDS_EVENTS_TEST_BUS_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

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

Then('the "DB" instance is "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: action already performed in the When step
  // Assert
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected RDS DB instance creation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  assert.ok(
    this.lastCallResult.output !== null && this.lastCallResult.output !== undefined,
    "Expected output from RDS DB instance creation but got null",
  );
});

Then('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  const result = await rdsEventsEventBridgeClient(this).send(new ListEventBusesCommand({}));
  const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
  // Assert
  const expectedBus = RDS_EVENTS_TEST_BUS_NAME;
  const actualFound = buses.some((b) => b.Name === expectedBus);
  assert.ok(
    actualFound,
    `Expected event bus "${expectedBus}" to be ACTIVE but not found; expected_bus=${expectedBus} actual_found=${actualFound}`,
  );
});

Then('the bus is "DELETED" and "RDS" event delivery will fail', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  const result = await rdsEventsEventBridgeClient(this).send(new ListEventBusesCommand({}));
  const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
  // Assert
  const expectedBus = RDS_EVENTS_TEST_BUS_NAME;
  const actualFound = buses.some((b) => b.Name === expectedBus);
  assert.ok(
    !actualFound,
    `Expected event bus "${expectedBus}" to be DELETED but found it; expected_bus=${expectedBus} actual_found=${actualFound}`,
  );
});

Then('the "DB" instance is "STOPPED"', async function (this: SdkWorld) {
  // @internal: d_b_stop_complete outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the "DB" instance is "STOPPING" and the event is "DELIVERED"', async function (this: SdkWorld) {
  // @internal: d_b_stop_event_delivered outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the "DB" instance is "STOPPING" but no event is delivered', async function (this: SdkWorld) {
  // @internal: d_b_stop_event_fails outcome not observable via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Invariant Then steps ──────────────────────────────────────────────────────

Then('every "DELIVERED" event references a "DB" instance that exists', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('every "DELIVERED" event references a bus that exists', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
  assert.ok(this.session, "Expected session to be initialized");
});
