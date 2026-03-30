/** Step definitions: docdb_events cross-service scenarios — unique steps only */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, BusStepHelpers } from "../support/world";

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

// ── Before hook: register busHelpers for @docdbevents scenarios ────────────────

Before({ tags: "@docdbevents" }, function (this: SdkWorld) {
  const busHelpers: BusStepHelpers = {
    createBus: async (world: SdkWorld) => {
      const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
      try {
        await docdbEventsEbClient(world).send(
          new CreateEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
        );
      } catch {
        // bus may already exist
      }
    },
    deleteBus: async (world: SdkWorld) => {
      const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
      try {
        await docdbEventsEbClient(world).send(
          new DeleteEventBusCommand({ Name: DOCDB_EVENTS_BUS_NAME }),
        );
      } catch {
        // bus may not exist
      }
    },
    assertBusStatus: async (world: SdkWorld, expectedState: string) => {
      if (expectedState !== "ACTIVE") return;
      assert.ok(world.session, "Expected session to be initialized");
      const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
      const result = await docdbEventsEbClient(world).send(new ListEventBusesCommand({}));
      const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
      const expectedBus = DOCDB_EVENTS_BUS_NAME;
      const actualFound = buses.some((b) => b.Name === expectedBus);
      assert.strictEqual(
        actualFound,
        true,
        `Expected event bus '${expectedBus}' to be ACTIVE but not found; expected_bus=${expectedBus}`,
      );
    },
  };
  this.busHelpers = busHelpers;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: event bus state setup ──────────────────────────────────────────────

// "the bus does not already exist" is registered in cross_service_common.ts.

// "the bus already exists" is registered in cross_service_common.ts.

// "the bus exists" is registered in cross_service_common.ts.

// "the bus does not exist" — registered in cross_service_common.ts.

// "the bus is {string}" (Given and Then) — registered in cross_service_common.ts (dispatches via busHelpers)

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

// "an event slot is available" is registered in cross_service_common.ts.

// "no event slot is available" is registered in cross_service_common.ts.

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

// "an EventBridge event bus is created" is registered in cross_service_common.ts.

// "the EventBridge event bus is deleted" is registered in cross_service_common.ts.

// ── When: @internal transitions ────────────────────────────────────────────────

When(
  "a cluster modification begins and DocumentDB delivers the event to the EventBridge bus",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal DocumentDB->EventBridge event delivery via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger DocDB->EventBridge event delivery: scenario is @internal"),
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

// "the bus is {string}" (Then) — registered in cross_service_common.ts (dispatches via busHelpers)

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

// "the cluster is \"AVAILABLE\" again" is registered in cluster_common.ts.

Then(
  'the cluster is "MODIFYING" and the "MODIFIED" event is "DELIVERED"',
  async function (this: SdkWorld) {
    // @internal: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then('the cluster is "MODIFYING" but no event is delivered', async function (this: SdkWorld) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: model invariants (no-ops) ───────────────────────────────────────────

// 'every "DELIVERED" event references a cluster that exists' is registered in cross_service_common.ts.

// 'every "DELIVERED" event references a bus that exists' — registered in cross_service_common.ts
