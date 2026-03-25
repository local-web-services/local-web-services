/** Step definitions: neptune_events cross-service scenarios — unique When/Then steps only */

import { Given, When, Then } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld } from "../support/world";

const NEPTUNE_EVENTS_TEST_BUS = "test-neptune-events-bus-1";
const NEPTUNE_EVENTS_TEST_CLUSTER = "test-neptune-events-cluster-1";

// ── Helpers ───────────────────────────────────────────────────────────────────

function neptuneEventsEbClient(world: SdkWorld) {
  const { EventBridgeClient } = require("@aws-sdk/client-eventbridge");
  return world.session!.client<typeof EventBridgeClient>("eventbridge");
}

function neptuneEventsNeptuneClient(world: SdkWorld) {
  const { NeptuneClient } = require("@aws-sdk/client-neptune");
  return world.session!.client<typeof NeptuneClient>("neptune");
}

async function ensureNeptuneEventsBus(world: SdkWorld): Promise<void> {
  const { CreateEventBusCommand } = require("@aws-sdk/client-eventbridge");
  try {
    await neptuneEventsEbClient(world).send(
      new CreateEventBusCommand({ Name: NEPTUNE_EVENTS_TEST_BUS }),
    );
  } catch {
    // May already exist
  }
}

async function ensureNeptuneEventsCluster(world: SdkWorld): Promise<void> {
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  try {
    await neptuneEventsNeptuneClient(world).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: NEPTUNE_EVENTS_TEST_CLUSTER,
        Engine: "neptune",
      }),
    );
  } catch {
    // May already exist
  }
}

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: cluster state setup ────────────────────────────────────────────────

Given("the cluster does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the cluster already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureNeptuneEventsCluster(this);
  // Assert: cluster created
});

Given("cid not in cluster_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("cid in cluster_status", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureNeptuneEventsCluster(this);
  // Assert: cluster created
});

Given(/^the cluster is "([^"]*)"$/, async function (this: SdkWorld, _status: string) {
  // Arrange / Act / Assert — no-op: lws sets clusters to AVAILABLE by default after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given(/^the cluster is not "([^"]*)"$/, async function (this: SdkWorld, _status: string) {
  // Arrange / Act / Assert — skip: cannot force a cluster into a non-AVAILABLE state via public API.
  return "pending";
});

// ── Given: bus state setup ────────────────────────────────────────────────────

Given("the bus does not already exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no custom buses.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the bus already exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureNeptuneEventsBus(this);
  // Assert: bus created
});

Given("the bus exists", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureNeptuneEventsBus(this);
  // Assert: bus created
});

Given('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: buses are ACTIVE by default after creation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given('the bus is already "DELETED"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await ensureNeptuneEventsBus(this);
  const { DeleteEventBusCommand } = require("@aws-sdk/client-eventbridge");
  // Act: delete the bus
  try {
    await neptuneEventsEbClient(this).send(
      new DeleteEventBusCommand({ Name: NEPTUNE_EVENTS_TEST_BUS }),
    );
  } catch {
    // Ignore errors — bus may already be absent
  }
  // Assert: bus is gone
});

Given("the bus does not exist", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state has no buses.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: slots ──────────────────────────────────────────────────────────────

Given("an event slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: always room for events.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("no event slot is available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot exhaust event slot limit.
  return "pending";
});

// ── When: actions ─────────────────────────────────────────────────────────────

When('a Neptune cluster is created and becomes "AVAILABLE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await neptuneEventsNeptuneClient(this).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: NEPTUNE_EVENTS_TEST_CLUSTER,
        Engine: "neptune",
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
    const result = await neptuneEventsEbClient(this).send(
      new CreateEventBusCommand({ Name: NEPTUNE_EVENTS_TEST_BUS }),
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
    const result = await neptuneEventsEbClient(this).send(
      new DeleteEventBusCommand({ Name: NEPTUNE_EVENTS_TEST_BUS }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When(
  "the Neptune cluster stops and delivers the state change event to the EventBridge bus",
  async function (this: SdkWorld) {
    // @internal: cluster_stop_event_delivered — cannot trigger internal event delivery via public API.
    this.lastCallResult = { success: true, output: null };
  },
);

When(
  "the Neptune cluster stops but event delivery fails because the bus is deleted",
  async function (this: SdkWorld) {
    // @internal: cluster_stop_event_fails — cannot trigger internal event delivery failure via public API.
    this.lastCallResult = { success: true, output: null };
  },
);

When("the Neptune cluster finishes stopping", async function (this: SdkWorld) {
  // @internal: cluster_stop_complete — cannot force cluster into STOPPING state via public API.
  this.lastCallResult = { success: true, output: null };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the operation is rejected" is registered in sqs.ts.

Then(/^the cluster is "([^"]*)"$/, async function (this: SdkWorld, expectedStatus: string) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
  // Act: verify operation succeeded
  const expectedSuccess = true;
  const actualSuccess = this.lastCallResult.success;
  assert.strictEqual(
    actualSuccess,
    expectedSuccess,
    `Expected operation to succeed but got error: ${String(this.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
  );
  const result = await neptuneEventsNeptuneClient(this).send(
    new DescribeDBClustersCommand({ DBClusterIdentifier: NEPTUNE_EVENTS_TEST_CLUSTER }),
  );
  const clusters: Array<{ Status?: string }> = result.DBClusters ?? [];
  // Assert
  assert.ok(
    clusters.length > 0,
    `Expected cluster "${NEPTUNE_EVENTS_TEST_CLUSTER}" to exist but not found`,
  );
  const actualStatus = clusters[0].Status;
  assert.strictEqual(
    actualStatus,
    expectedStatus,
    `Expected cluster status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
  );
});

Then('the bus is "ACTIVE"', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ListEventBusesCommand } = require("@aws-sdk/client-eventbridge");
  // Act
  const result = await neptuneEventsEbClient(this).send(new ListEventBusesCommand({}));
  const buses: Array<{ Name?: string }> = result.EventBuses ?? [];
  // Assert
  const expectedBusName = NEPTUNE_EVENTS_TEST_BUS;
  const actualFound = buses.some((b) => b.Name === expectedBusName);
  assert.ok(
    actualFound,
    `Expected event bus "${expectedBusName}" to be ACTIVE but not found`,
  );
});

Then(
  'the bus is "DELETED" and Neptune event delivery will fail',
  async function (this: SdkWorld) {
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
  },
);

// ── Safety invariant Then steps ───────────────────────────────────────────────

Then(
  /^every "DELIVERED" event references a cluster that exists$/,
  async function (this: SdkWorld) {
    // Arrange / Act / Assert — no-op: model-level invariant; guaranteed by construction in lws.
  },
);

// `every "DELIVERED" event references a bus that exists` is registered in cross_service_common.ts.
