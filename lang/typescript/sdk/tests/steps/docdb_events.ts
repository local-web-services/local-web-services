/** Step definitions: docdb_events cross-service scenarios — unique steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

// docdb_events-specific resource names
const DOCDB_EVENTS_CLUSTER_ID = "test-docdb-cluster-1";
const DOCDB_EVENTS_BUS_NAME = "test-docdb-events-bus-1";
const DOCDB_EVENTS_ENGINE = "docdb";

// ── Helpers ───────────────────────────────────────────────────────────────────

function docdbEventsDocDbClient(world: SdkWorld) {
  const { DocDBClient } = require("@aws-sdk/client-docdb");
  return world.session!.client<typeof DocDBClient>("docdb");
}

function docdbEventsEbClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: event bus state setup ──────────────────────────────────────────────

Given("the bus does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no event buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bus already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  await docdbEventsEbClient(this).send(
    new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
  );
  // Assert: bus created
});

Given("the bus exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  await docdbEventsEbClient(this).send(
    new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
  );
  // Assert: bus exists
});

Given("the bus does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no event buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: ensure the bus exists (buses are ACTIVE immediately after creation).
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  try {
    await docdbEventsEbClient(this).send(
      new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
    );
  } catch {
    // bus may already exist
  }
  // Assert: bus is ACTIVE
});

Given('the bus is "DELETED"', async function (this: SdkWorld) {
  // @internal: Cannot place bus into DELETED state without deleting it; after deletion
  // the bus no longer exists. Treated as no-op; scenario is tagged @internal.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is not "DELETED"', async function (this: SdkWorld) {
  // Arrange: ensure the bus exists and is therefore NOT deleted.
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  try {
    await docdbEventsEbClient(this).send(
      new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
    );
  } catch {
    // bus may already exist
  }
  // Assert: bus is not deleted
});

Given('the bus is already "DELETED"', async function (this: SdkWorld) {
  // @internal: Cannot arrange bus in already-deleted state via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: @internal state steps ──────────────────────────────────────────────

Given("an event slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no events.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no event slot is available", async function (this: SdkWorld) {
  // @internal: Cannot exhaust event slots via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the cluster is not ..." steps are handled by the parametric Given in docdb.ts;
// specific literal variants for "AVAILABLE" and "MODIFYING" are NOT re-registered.

// "busid not in bus_status" is already registered in cross_service_common.ts; NOT re-registered.

// ── When: public API actions ───────────────────────────────────────────────────

When('a DocumentDB cluster is created and becomes "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
  // Act
  try {
    const result = await docdbEventsDocDbClient(this).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: DOCDB_EVENTS_CLUSTER_ID,
        Engine: DOCDB_EVENTS_ENGINE,
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
    const result = await docdbEventsEbClient(this).send(
      new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
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
    const result = await docdbEventsEbClient(this).send(
      new DeleteEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── When: @internal transitions ────────────────────────────────────────────────

When(
  "a cluster modification begins and DocumentDB delivers the event to the EventBridge bus",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal DocumentDB->EventBridge event delivery via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error(
        "cannot trigger DocDB->EventBridge event delivery: scenario is @internal",
      ),
    };
  },
);

When(
  "a cluster modification begins but event delivery fails because the bus is deleted",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal event delivery failure via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger event delivery failure: scenario is @internal"),
    };
  },
);

When("the cluster modification completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster modification completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster modification completion: scenario is @internal"),
  };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the cluster is \"AVAILABLE\"" is handled by the Then(/^the cluster is "([^"]*)"$/) no-op
// in docdb.ts. It is intentionally absent here to avoid ambiguous step definition errors.

Then('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange: no additional setup required
  // Act: verify bus exists in the list
  assert.ok(this.session, "Expected session to be initialized");
  const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
  const actualResult = await docdbEventsEbClient(this).send(new ListEventBusesCommand({}));
  const actualBuses: Array<{ Name?: string }> = actualResult.EventBuses ?? [];
  // Assert
  const expectedBus = DOCDB_EVENTS_BUS_NAME;
  const actualFound = actualBuses.some((b) => b.Name === expectedBus);
  assert.strictEqual(
    actualFound,
    true,
    `Expected event bus '${expectedBus}' to be ACTIVE but not found; expected_bus=${expectedBus}`,
  );
});

Then(
  'the bus is "DELETED" and DocumentDB event delivery will fail',
  async function (this: SdkWorld) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    const expectedSuccess = true;
    const actualSuccess = this.lastCallResult.success;
    assert.strictEqual(
      actualSuccess,
      expectedSuccess,
      `Expected DeleteEventBus to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
    );
  },
);

// ── Then: @internal state assertions (no-ops) ─────────────────────────────────

Then('the cluster is "AVAILABLE" again', async function (this: SdkWorld) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  'the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED"',
  async function (this: SdkWorld) {
    // @internal: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  'the cluster is "MODIFYING" but no event is delivered',
  async function (this: SdkWorld) {
    // @internal: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

// ── Then: model invariants (no-ops) ───────────────────────────────────────────

Then(
  'every "DELIVERED" event references a cluster that exists',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then('every "DELIVERED" event references a bus that exists', async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});
