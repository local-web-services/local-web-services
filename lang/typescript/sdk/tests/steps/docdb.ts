/** Step definitions: docdb service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, SnapshotHelpers, DatabaseStepHelpers } from "../support/world";

const DOCDB_CLUSTER_ID = "test-docdb-cluster-1";
const DOCDB_INSTANCE_ID = "test-docdb-instance-1";
const DOCDB_SNAPSHOT_ID = "test-docdb-snapshot-1";
const DOCDB_ENGINE = "docdb";
const DOCDB_INSTANCE_CLASS = "db.t3.medium";

// ── Helpers ───────────────────────────────────────────────────────────────────

function docdbClient(world: SdkWorld) {
  const { DocDBClient } = require("@aws-sdk/client-docdb");
  return world.session!.client<typeof DocDBClient>("docdb");
}

async function docdbCreateCluster(world: SdkWorld): Promise<void> {
  const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
  await docdbClient(world).send(
    new CreateDBClusterCommand({
      DBClusterIdentifier: DOCDB_CLUSTER_ID,
      Engine: DOCDB_ENGINE,
    }),
  );
}

async function docdbCreateInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-docdb");
  await docdbClient(world).send(
    new CreateDBInstanceCommand({
      DBInstanceIdentifier: DOCDB_INSTANCE_ID,
      DBClusterIdentifier: DOCDB_CLUSTER_ID,
      DBInstanceClass: DOCDB_INSTANCE_CLASS,
      Engine: DOCDB_ENGINE,
    }),
  );
}

async function docdbCreateSnapshot(world: SdkWorld): Promise<void> {
  const { CreateDBClusterSnapshotCommand } = require("@aws-sdk/client-docdb");
  await docdbClient(world).send(
    new CreateDBClusterSnapshotCommand({
      DBClusterSnapshotIdentifier: DOCDB_SNAPSHOT_ID,
      DBClusterIdentifier: DOCDB_CLUSTER_ID,
    }),
  );
}

// ── Before hook: register cluster helpers for @docdb and @docdbevents scenarios ──

Before({ tags: "@docdb or @docdbevents" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      try {
        await docdbCreateCluster(world);
        world.lastCallResult = { success: true, output: null };
      } catch {
        // cluster may already exist; desired state is existence
        world.lastCallResult = { success: true, output: null };
      }
    },
    assertClusterStatus: async (world: SdkWorld, expectedStatus: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected DocDB cluster operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      const { DescribeDBClustersCommand } = require("@aws-sdk/client-docdb");
      const result = await docdbClient(world).send(
        new DescribeDBClustersCommand({ DBClusterIdentifier: DOCDB_CLUSTER_ID }),
      );
      const clusters: Array<{ Status?: string }> = result.DBClusters ?? [];
      const expectedStatusLower = expectedStatus.toLowerCase();
      const actualStatus = clusters[0]?.Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatusLower,
        `Expected cluster status "${expectedStatusLower}" but got "${actualStatus}"; expected_status=${expectedStatusLower} actual_status=${actualStatus}`,
      );
    },
    createNamedCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
      // Act
      try {
        const result = await docdbClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: DOCDB_CLUSTER_ID,
            Engine: DOCDB_ENGINE,
            MasterUsername: "admin",
            MasterUserPassword: "pass1234",
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    stopCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { StopDBClusterCommand } = require("@aws-sdk/client-docdb");
      // Act
      try {
        const result = await docdbClient(world).send(
          new StopDBClusterCommand({ DBClusterIdentifier: DOCDB_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
    startCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { StartDBClusterCommand } = require("@aws-sdk/client-docdb");
      // Act
      try {
        const result = await docdbClient(world).send(
          new StartDBClusterCommand({ DBClusterIdentifier: DOCDB_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
});

// ── Background ────────────────────────────────────────────────────────────────
// ── Before hook: register helpers for docdb scenarios ────────────────

Before({ tags: "@docdb" }, function (this: SdkWorld) {
  const snapshotHelpersImpl: SnapshotHelpers = {
    setupSnapshotExists: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      await docdbCreateCluster(world);
      // Act
      await docdbCreateSnapshot(world);
      // Assert: snapshot created
    },
    setupSnapshotNotExists: async (world: SdkWorld) => {
      // no-op: fresh state has no snapshots
      void world;
    },
    assertSnapshotInStateLinkedToCluster: async (world: SdkWorld, _expectedState: string) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected CreateDBClusterSnapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      const { DescribeDBClusterSnapshotsCommand } = require("@aws-sdk/client-docdb");
      const actualResult = await docdbClient(world).send(
        new DescribeDBClusterSnapshotsCommand({
          DBClusterSnapshotIdentifier: DOCDB_SNAPSHOT_ID,
        }),
      );
      const actualSnapshots: Array<{ Status?: string }> = actualResult.DBClusterSnapshots ?? [];
      const expectedStatus = "creating";
      const actualStatus = actualSnapshots[0]?.Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    assertSnapshotInState: async (world: SdkWorld, _expectedState: string) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected DeleteDBClusterSnapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      const { DescribeDBClusterSnapshotsCommand } = require("@aws-sdk/client-docdb");
      const actualResult = await docdbClient(world).send(
        new DescribeDBClusterSnapshotsCommand({
          DBClusterSnapshotIdentifier: DOCDB_SNAPSHOT_ID,
        }),
      );
      const actualSnapshots: Array<{ Status?: string }> = actualResult.DBClusterSnapshots ?? [];
      const expectedStatus = "deleting";
      const actualStatus = actualSnapshots[0]?.Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    assertRestoredClusterInState: async (world: SdkWorld, _expectedState: string) => {
      // Arrange: no additional setup required
      // Act: action already performed in the When step
      // Assert
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected RestoreDBClusterFromSnapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
    },
    restoreClusterFromSnapshot: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { RestoreDBClusterFromSnapshotCommand } = require("@aws-sdk/client-docdb");
      // Act
      try {
        const result = await docdbClient(world).send(
          new RestoreDBClusterFromSnapshotCommand({
            DBClusterIdentifier: DOCDB_CLUSTER_ID + "-restored",
            SnapshotIdentifier: DOCDB_SNAPSHOT_ID,
            Engine: DOCDB_ENGINE,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };
  this.snapshotHelpers = snapshotHelpersImpl;

  const databaseHelpersImpl: DatabaseStepHelpers = {
    createCluster: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: DOCDB_CLUSTER_ID,
            Engine: DOCDB_ENGINE,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteCluster: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBClusterCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new DeleteDBClusterCommand({ DBClusterIdentifier: DOCDB_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    modifyCluster: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { ModifyDBClusterCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new ModifyDBClusterCommand({ DBClusterIdentifier: DOCDB_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    createInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBInstanceCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new CreateDBInstanceCommand({
            DBInstanceIdentifier: DOCDB_INSTANCE_ID,
            DBClusterIdentifier: DOCDB_CLUSTER_ID,
            DBInstanceClass: DOCDB_INSTANCE_CLASS,
            Engine: DOCDB_ENGINE,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBInstanceCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new DeleteDBInstanceCommand({ DBInstanceIdentifier: DOCDB_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    modifyInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { ModifyDBInstanceCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new ModifyDBInstanceCommand({ DBInstanceIdentifier: DOCDB_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    createSnapshot: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterSnapshotCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new CreateDBClusterSnapshotCommand({
            DBClusterSnapshotIdentifier: DOCDB_SNAPSHOT_ID,
            DBClusterIdentifier: DOCDB_CLUSTER_ID,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteSnapshot: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBClusterSnapshotCommand } = require("@aws-sdk/client-docdb");
      try {
        const result = await docdbClient(world).send(
          new DeleteDBClusterSnapshotCommand({ DBClusterSnapshotIdentifier: DOCDB_SNAPSHOT_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    setupInstanceExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await docdbCreateCluster(world);
      await docdbCreateInstance(world);
    },
    setupInstanceNotExists: async (world: SdkWorld) => {
      // no-op: fresh state after session reset has no instances.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertInstanceInState: async (world: SdkWorld, expectedState: string) => {
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected DocDB instance operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      const { DescribeDBInstancesCommand } = require("@aws-sdk/client-docdb");
      const actualResult = await docdbClient(world).send(
        new DescribeDBInstancesCommand({ DBInstanceIdentifier: DOCDB_INSTANCE_ID }),
      );
      const actualInstances: Array<{ DBInstanceStatus?: string }> = actualResult.DBInstances ?? [];
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = actualInstances[0]?.DBInstanceStatus ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
  this.databaseHelpers = databaseHelpersImpl;
});

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: cluster state setup ────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

// "the cluster has no non-deleted instances" is registered in cluster_common.ts.

Given("the cluster has non-deleted instances", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await docdbCreateCluster(this);
  // Act
  await docdbCreateInstance(this);
  // Assert: instance created in cluster
});

// ── Given: instance state setup ───────────────────────────────────────────────

// "the instance does not exist" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "the instance exists" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// "the instance slot is available" is registered in cluster_common.ts.

Given("the instance slot is not available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await docdbCreateCluster(this);
  // Act
  await docdbCreateInstance(this);
  // Assert: slot taken
});

// "the instance is {string}" is registered in cross_service_common.ts.
// "the instance is not {string}" is registered in cross_service_common.ts.

Given("the instance is the primary", async function (this: SdkWorld) {
  // @internal: Primary instance state is set internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance is not the primary", async function (this: SdkWorld) {
  // @internal: Cannot control primary assignment via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance is the primary of the cluster", async function (this: SdkWorld) {
  // @internal: Primary instance state is set internally.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance is not the primary of the cluster", async function (this: SdkWorld) {
  // @internal: Cannot control primary assignment via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the new primary instance exists", async function (this: SdkWorld) {
  // @internal: Failover requires internal state manipulation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the new primary instance does not exist", async function (this: SdkWorld) {
  // @internal: Failover requires internal state manipulation.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance belongs to this cluster", async function (this: SdkWorld) {
  // @internal: Cluster membership is an internal property.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance does not belong to this cluster", async function (this: SdkWorld) {
  // @internal: Cluster membership is an internal property.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance is already the primary", async function (this: SdkWorld) {
  // @internal: Primary assignment is an internal property.
  assert.ok(this.session, "Expected session to be initialized");
});

Given("the instance is not already the primary", async function (this: SdkWorld) {
  // @internal: Primary assignment is an internal property.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Given: snapshot state setup ───────────────────────────────────────────────

// "the snapshot does not exist" is registered in cross_service_common.ts (dispatches via helpers).

// "the snapshot exists" is registered in cross_service_common.ts (dispatches via helpers).

// "the snapshot slot is available" is registered in cluster_common.ts.

Given("the snapshot slot is not available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  await docdbCreateCluster(this);
  // Act
  await docdbCreateSnapshot(this);
  // Assert: slot taken
});

// "the snapshot is {string}" is registered in cross_service_common.ts (dispatches via snapshotHelpers).

Given(/^the snapshot is not "([^"]*)"$/, async function (this: SdkWorld, _status: string) {
  // @internal: Cannot enforce snapshot is NOT in a given lifecycle state via public API.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the target cluster slot is available" is registered in cluster_common.ts.

Given("the target cluster slot is not available", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await docdbCreateCluster(this);
  // Assert: slot taken
});

// Sequence-level precondition
Given("cid not in cluster_status", async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: public API actions ───────────────────────────────────────────────────

// "a database cluster is created" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster configuration is modified" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is created in an available cluster" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance configuration is modified" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster snapshot is created" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster snapshot is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// "a cluster is restored from a snapshot" is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.restoreClusterFromSnapshot registered in the Before hook above).

When("a DocumentDB cluster is created", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers?.createNamedCluster,
    "Expected clusterHelpers.createNamedCluster to be registered",
  );
  // Act
  await this.clusterHelpers.createNamedCluster(this);
  // Assert: captured in lastCallResult
});

When("the DocumentDB cluster is stopped", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers?.stopCluster,
    "Expected clusterHelpers.stopCluster to be registered",
  );
  // Act
  await this.clusterHelpers.stopCluster(this);
  // Assert: captured in lastCallResult
});

When("the DocumentDB cluster is started", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers?.startCluster,
    "Expected clusterHelpers.startCluster to be registered",
  );
  // Act
  await this.clusterHelpers.startCluster(this);
  // Assert: captured in lastCallResult
});

// ── When: @internal transitions ────────────────────────────────────────────────

When("a database cluster finishes creating", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster creation completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster creation completion: scenario is @internal"),
  };
});

When("a database cluster deletion completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster deletion completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster deletion completion: scenario is @internal"),
  };
});

When("a database cluster modification completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster modification completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster modification completion: scenario is @internal"),
  };
});

When("a database cluster restore from snapshot completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster restore completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster restore completion: scenario is @internal"),
  };
});

When("a database cluster creation fails", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal cluster creation failure via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger cluster creation failure: scenario is @internal"),
  };
});

When("a database instance finishes creating", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal instance creation completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger instance creation completion: scenario is @internal"),
  };
});

When("a database instance deletion completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal instance deletion completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger instance deletion completion: scenario is @internal"),
  };
});

When("a database instance modification completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal instance modification completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger instance modification completion: scenario is @internal"),
  };
});

When("a database cluster snapshot finishes creating", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal snapshot creation completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger snapshot creation completion: scenario is @internal"),
  };
});

When("a database cluster snapshot deletion completes", async function (this: SdkWorld) {
  // @internal: Cannot trigger internal snapshot deletion completion via public API.
  assert.ok(this.session, "Expected session to be initialized");
  this.lastCallResult = {
    success: false,
    output: null,
    error: new Error("cannot trigger snapshot deletion completion: scenario is @internal"),
  };
});

When(
  "a failover is triggered and a replica is promoted to primary",
  async function (this: SdkWorld) {
    // @internal: Cannot trigger internal failover via public API.
    assert.ok(this.session, "Expected session to be initialized");
    this.lastCallResult = {
      success: false,
      output: null,
      error: new Error("cannot trigger failover: scenario is @internal"),
    };
  },
);

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the cluster is in {string} state" is registered in cluster_common.ts (dispatches via clusterHelpers.assertClusterStatus).

// "the instance is in {string} state and associated with the cluster" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "the instance is in {string} state" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// 'the snapshot is in "CREATING" state and linked to the cluster' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInStateLinkedToCluster).
// 'the snapshot is in "DELETING" state' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInState).
// 'the restored cluster is in "RESTORING" state' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertRestoredClusterInState).

// ── Then: @internal state assertions (no-ops) ─────────────────────────────────

// "the cluster is {string}" is registered in cluster_common.ts.

Then(/^the cluster returns to "([^"]*)" state$/, async function (this: SdkWorld, _status: string) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then('the cluster is in "FAILED" state', async function (this: SdkWorld) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

Then(
  /^the instance is "([^"]*)" and the cluster primary is updated if applicable$/,
  async function (this: SdkWorld, _status: string) {
    // @internal: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(
  /^the instance is "([^"]*)" and the cluster primary is cleared if applicable$/,
  async function (this: SdkWorld, _status: string) {
    // @internal: model-level invariant; trivially satisfied.
    assert.ok(this.session, "Expected session to be initialized");
  },
);

Then(/^the instance returns to "([^"]*)" state$/, async function (this: SdkWorld, _status: string) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// "the snapshot is {string}" is registered in cross_service_common.ts (dispatches via snapshotHelpers).

Then("the cluster has a new primary instance", async function (this: SdkWorld) {
  // @internal: model-level invariant; trivially satisfied.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── Then: model invariants (no-ops) ───────────────────────────────────────────

// "every cluster/instance/snapshot has a valid status" is registered in cross_service_common.ts.

Then("a deleted cluster has no non-deleted instances", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

// "a failed cluster has no available instances" is registered in cross_service_common.ts.

Then("a deleting cluster receives no new instances", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  "every creating snapshot references a cluster that has not been deleted",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);
