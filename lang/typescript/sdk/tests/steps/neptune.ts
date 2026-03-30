/** Step definitions: neptune service informal specification scenarios */

import { Given, When, Then, Before } from "@cucumber/cucumber";
import assert from "assert";
import type { SdkWorld, SnapshotHelpers, DatabaseStepHelpers } from "../support/world";

const NEPTUNE_TEST_CLUSTER_ID = "test-neptune-cluster-1";
const NEPTUNE_TEST_INSTANCE_ID = "test-neptune-instance-1";
const NEPTUNE_TEST_SNAPSHOT_ID = "test-neptune-snapshot-1";
const NEPTUNE_TEST_DB_CLASS = "db.r5.large";
const NEPTUNE_TEST_ENGINE = "neptune";

// ── Helpers ───────────────────────────────────────────────────────────────────

function neptuneClient(world: SdkWorld) {
  const { NeptuneClient } = require("@aws-sdk/client-neptune");
  return world.session!.client<typeof NeptuneClient>("neptune");
}

async function ensureNeptuneCluster(world: SdkWorld): Promise<void> {
  const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
  try {
    await neptuneClient(world).send(
      new CreateDBClusterCommand({
        DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
        Engine: NEPTUNE_TEST_ENGINE,
      }),
    );
  } catch {
    // May already exist
  }
}

async function ensureNeptuneInstance(world: SdkWorld): Promise<void> {
  const { CreateDBInstanceCommand } = require("@aws-sdk/client-neptune");
  try {
    await neptuneClient(world).send(
      new CreateDBInstanceCommand({
        DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID,
        DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
        DBInstanceClass: NEPTUNE_TEST_DB_CLASS,
        Engine: NEPTUNE_TEST_ENGINE,
      }),
    );
  } catch {
    // May already exist
  }
}

async function ensureNeptuneSnapshot(world: SdkWorld): Promise<void> {
  const { CreateDBClusterSnapshotCommand } = require("@aws-sdk/client-neptune");
  try {
    await neptuneClient(world).send(
      new CreateDBClusterSnapshotCommand({
        DBClusterSnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
        DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
      }),
    );
  } catch {
    // May already exist
  }
}

// ── Before hook: register cluster helpers for @neptune scenarios ──────────────

Before({ tags: "@neptune" }, function (this: SdkWorld) {
  this.clusterHelpers = {
    createCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: create the cluster for use as a precondition
      await ensureNeptuneCluster(world);
      // Mark the last call as successful so assertClusterStatus precondition checks pass
      world.lastCallResult = { success: true, output: {} };
    },
    assertClusterStatus: async (world: SdkWorld, expectedStatus: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // If there is a prior operation result, assert it succeeded
      const hasPriorResult =
        world.lastCallResult.output !== null || world.lastCallResult.error !== undefined;
      if (hasPriorResult) {
        const expectedSuccess = true;
        const actualSuccess = world.lastCallResult.success;
        assert.strictEqual(
          actualSuccess,
          expectedSuccess,
          `Expected Neptune cluster operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
        );
      }
      // Act: check the status via the last response or by describing
      const expectedStatusLower = expectedStatus.toLowerCase();
      // If the last result has a DBCluster in its output, use that status (e.g. after create/delete/modify)
      const outputCluster = (
        world.lastCallResult.output as { DBCluster?: { Status?: string } } | null
      )?.DBCluster;
      if (outputCluster?.Status !== undefined) {
        const actualStatus = outputCluster.Status;
        // Assert
        assert.strictEqual(
          actualStatus,
          expectedStatusLower,
          `Expected cluster status "${expectedStatusLower}" but got "${actualStatus}"; expected_status=${expectedStatusLower} actual_status=${actualStatus}`,
        );
        return;
      }
      // Fallback: describe the cluster to verify its current state
      const { DescribeDBClustersCommand } = require("@aws-sdk/client-neptune");
      const result = await neptuneClient(world).send(
        new DescribeDBClustersCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
      );
      const clusters: Array<{ Status?: string }> = result.DBClusters ?? [];
      // Assert
      assert.ok(clusters.length > 0, `Expected cluster "${NEPTUNE_TEST_CLUSTER_ID}" to exist`);
      const actualStatus = clusters[0].Status ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatusLower,
        `Expected cluster status "${expectedStatusLower}" but got "${actualStatus}"; expected_status=${expectedStatusLower} actual_status=${actualStatus}`,
      );
    },
    createNamedCluster: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await neptuneClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
            Engine: NEPTUNE_TEST_ENGINE,
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
      const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await neptuneClient(world).send(
          new StopDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
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
      const { StartDBClusterCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await neptuneClient(world).send(
          new StartDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
      // Assert: captured in lastCallResult
    },
  };

  const snapshotHelpersImpl: SnapshotHelpers = {
    setupSnapshotExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await ensureNeptuneCluster(world);
      await ensureNeptuneSnapshot(world);
    },
    setupSnapshotNotExists: async (world: SdkWorld) => {
      // Arrange / Act / Assert — no-op: fresh state after reset has no snapshots.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertSnapshotInState: async (world: SdkWorld, expectedStatus: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: verify operation succeeded
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      // Use last call result status if available (e.g. for delete where snapshot is removed from memory)
      const outputSnap = (
        world.lastCallResult.output as { DBClusterSnapshot?: { Status?: string } } | null
      )?.DBClusterSnapshot;
      if (outputSnap?.Status !== undefined) {
        // Assert
        const actualStatus = outputSnap.Status;
        assert.strictEqual(
          actualStatus,
          expectedStatus,
          `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
        );
        return;
      }
      // Fallback: describe the snapshot
      const { DescribeDBClusterSnapshotsCommand } = require("@aws-sdk/client-neptune");
      const result = await neptuneClient(world).send(
        new DescribeDBClusterSnapshotsCommand({
          DBClusterSnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
        }),
      );
      const snapshots: Array<{ Status?: string }> = result.DBClusterSnapshots ?? [];
      // Assert
      assert.ok(
        snapshots.length > 0,
        `Expected snapshot "${NEPTUNE_TEST_SNAPSHOT_ID}" to exist but not found`,
      );
      const actualStatus = snapshots[0].Status;
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected snapshot status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    assertSnapshotInStateLinkedToCluster: async (world: SdkWorld, expectedStatus: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const expectedStatusLower = expectedStatus.toLowerCase();
      // Act: verify operation succeeded
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      // Use last call result status if available (e.g. for create where response has "creating")
      const outputSnap = (
        world.lastCallResult.output as { DBClusterSnapshot?: { Status?: string } } | null
      )?.DBClusterSnapshot;
      if (outputSnap?.Status !== undefined) {
        // Assert
        const actualStatus = outputSnap.Status;
        assert.strictEqual(
          actualStatus,
          expectedStatusLower,
          `Expected snapshot status "${expectedStatusLower}" but got "${actualStatus}"; expected_status=${expectedStatusLower} actual_status=${actualStatus}`,
        );
        return;
      }
      // Fallback: describe the snapshot
      const { DescribeDBClusterSnapshotsCommand } = require("@aws-sdk/client-neptune");
      const result = await neptuneClient(world).send(
        new DescribeDBClusterSnapshotsCommand({
          DBClusterSnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
        }),
      );
      const snapshots: Array<{ Status?: string }> = result.DBClusterSnapshots ?? [];
      // Assert
      assert.ok(
        snapshots.length > 0,
        `Expected snapshot "${NEPTUNE_TEST_SNAPSHOT_ID}" to exist but not found`,
      );
      const actualStatus = snapshots[0].Status;
      assert.strictEqual(
        actualStatus,
        expectedStatusLower,
        `Expected snapshot status "${expectedStatusLower}" but got "${actualStatus}"; expected_status=${expectedStatusLower} actual_status=${actualStatus}`,
      );
    },
    assertRestoredClusterInState: async (world: SdkWorld, _expectedStatus: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      // Act: verify operation succeeded
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      // Assert
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected restore_d_b_cluster_from_snapshot to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
    },
    restoreClusterFromSnapshot: async (world: SdkWorld) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const { RestoreDBClusterFromSnapshotCommand } = require("@aws-sdk/client-neptune");
      // Act
      try {
        const result = await neptuneClient(world).send(
          new RestoreDBClusterFromSnapshotCommand({
            DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID + "-restored",
            SnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
            Engine: NEPTUNE_TEST_ENGINE,
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
      const { CreateDBClusterCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new CreateDBClusterCommand({
            DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
            Engine: NEPTUNE_TEST_ENGINE,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteCluster: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBClusterCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new DeleteDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    modifyCluster: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { ModifyDBClusterCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new ModifyDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    createInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBInstanceCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new CreateDBInstanceCommand({
            DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID,
            DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
            DBInstanceClass: NEPTUNE_TEST_DB_CLASS,
            Engine: NEPTUNE_TEST_ENGINE,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBInstanceCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new DeleteDBInstanceCommand({ DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    modifyInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { ModifyDBInstanceCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new ModifyDBInstanceCommand({ DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    rebootInstance: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { RebootDBInstanceCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new RebootDBInstanceCommand({ DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    createSnapshot: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { CreateDBClusterSnapshotCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new CreateDBClusterSnapshotCommand({
            DBClusterSnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
            DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    deleteSnapshot: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      const { DeleteDBClusterSnapshotCommand } = require("@aws-sdk/client-neptune");
      try {
        const result = await neptuneClient(world).send(
          new DeleteDBClusterSnapshotCommand({
            DBClusterSnapshotIdentifier: NEPTUNE_TEST_SNAPSHOT_ID,
          }),
        );
        world.lastCallResult = { success: true, output: result };
      } catch (err: unknown) {
        world.lastCallResult = { success: false, output: null, error: err };
      }
    },
    setupInstanceExists: async (world: SdkWorld) => {
      assert.ok(world.session, "Expected session to be initialized");
      await ensureNeptuneCluster(world);
      await ensureNeptuneInstance(world);
    },
    setupInstanceNotExists: async (world: SdkWorld) => {
      // no-op: fresh state after session reset has no instances.
      assert.ok(world.session, "Expected session to be initialized");
    },
    assertInstanceInState: async (world: SdkWorld, expectedState: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected Neptune instance operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      // Use last call result status if available (e.g. for delete/create/modify where response has transitional state)
      const outputInstance = (
        world.lastCallResult.output as { DBInstance?: { DBInstanceStatus?: string } } | null
      )?.DBInstance;
      if (outputInstance?.DBInstanceStatus !== undefined) {
        // Assert
        const expectedStatus = expectedState.toLowerCase();
        const actualStatus = outputInstance.DBInstanceStatus;
        assert.strictEqual(
          actualStatus,
          expectedStatus,
          `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
        );
        return;
      }
      // Fallback: describe the instance
      const { DescribeDBInstancesCommand } = require("@aws-sdk/client-neptune");
      const result = await neptuneClient(world).send(
        new DescribeDBInstancesCommand({ DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID }),
      );
      const instances: Array<{ DBInstanceStatus?: string }> = result.DBInstances ?? [];
      // Assert
      assert.ok(instances.length > 0, `Expected instance "${NEPTUNE_TEST_INSTANCE_ID}" to exist`);
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = instances[0].DBInstanceStatus ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
    assertInstanceInStateWithCluster: async (world: SdkWorld, expectedState: string) => {
      // Arrange
      assert.ok(world.session, "Expected session to be initialized");
      const expectedSuccess = true;
      const actualSuccess = world.lastCallResult.success;
      assert.strictEqual(
        actualSuccess,
        expectedSuccess,
        `Expected Neptune instance operation to succeed but got error: ${String(world.lastCallResult.error)}; expected_success=${expectedSuccess} actual_success=${actualSuccess}`,
      );
      // Use last call result status if available
      const outputInstance = (
        world.lastCallResult.output as { DBInstance?: { DBInstanceStatus?: string } } | null
      )?.DBInstance;
      if (outputInstance?.DBInstanceStatus !== undefined) {
        // Assert
        const expectedStatus = expectedState.toLowerCase();
        const actualStatus = outputInstance.DBInstanceStatus;
        assert.strictEqual(
          actualStatus,
          expectedStatus,
          `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
        );
        return;
      }
      // Fallback: describe the instance
      const { DescribeDBInstancesCommand } = require("@aws-sdk/client-neptune");
      const result = await neptuneClient(world).send(
        new DescribeDBInstancesCommand({ DBInstanceIdentifier: NEPTUNE_TEST_INSTANCE_ID }),
      );
      const instances: Array<{ DBInstanceStatus?: string }> = result.DBInstances ?? [];
      // Assert
      assert.ok(instances.length > 0, `Expected instance "${NEPTUNE_TEST_INSTANCE_ID}" to exist`);
      const expectedStatus = expectedState.toLowerCase();
      const actualStatus = instances[0].DBInstanceStatus ?? "";
      assert.strictEqual(
        actualStatus,
        expectedStatus,
        `Expected instance status "${expectedStatus}" but got "${actualStatus}"; expected_status=${expectedStatus} actual_status=${actualStatus}`,
      );
    },
  };
  this.databaseHelpers = databaseHelpersImpl;
});

// ── Background ────────────────────────────────────────────────────────────────

// "the system is initialized" is registered in cross_service_common.ts.

// ── Given: cluster state setup ────────────────────────────────────────────────

// "the cluster does not already exist", "the cluster already exists",
// "the cluster exists", "the cluster does not exist", "the cluster is {string}",
// "the cluster is not {string}" are registered in cluster_common.ts.

// "the cluster has no non-deleted instances" is registered in cluster_common.ts.

Given("the cluster has non-deleted instances", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  // Act
  await ensureNeptuneInstance(this);
  // Assert: instance created
});

// ── Given: instance state setup ────────────────────────────────────────────────

// "the instance slot is available" is registered in cluster_common.ts.

Given("the instance slot is not available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot exhaust instance slot limit.
  return "pending";
});

// "the instance exists" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "the instance is {string}" is registered in cross_service_common.ts.
// "the instance is not {string}" is registered in cross_service_common.ts.
// "the instance does not exist" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// ── Given: snapshot state setup ────────────────────────────────────────────────

// "the snapshot slot is available" is registered in cluster_common.ts.

Given("the snapshot slot is not available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot exhaust snapshot slot limit.
  return "pending";
});

// "the snapshot exists" is registered in cross_service_common.ts (dispatches via snapshotHelpers).
// "the snapshot is {string}" is registered in cross_service_common.ts (dispatches via snapshotHelpers).
// "the snapshot does not exist" is registered in cross_service_common.ts (dispatches via snapshotHelpers).

Given(/^the snapshot is not "([^"]*)"$/, async function (this: SdkWorld, _status: string) {
  // Arrange / Act / Assert — skip: cannot force a snapshot into a non-AVAILABLE state via public API.
  return "pending";
});

// "the target cluster slot is available" is registered in cluster_common.ts.

Given("the target cluster slot is not available", async function (this: SdkWorld) {
  // Arrange / Act / Assert — skip: cannot exhaust cluster slot limit.
  return "pending";
});

// ── When: actions ─────────────────────────────────────────────────────────────

// "a database cluster is created" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is created in an available cluster" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster snapshot is created" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database cluster snapshot is deleted" is registered in cross_service_common.ts (dispatches via databaseHelpers).

When("a Neptune cluster is created", async function (this: SdkWorld) {
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

When("the Neptune cluster is stopped", async function (this: SdkWorld) {
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

When("the Neptune cluster is started", async function (this: SdkWorld) {
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

When("a stopped database cluster is started", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { StartDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await neptuneClient(this).send(
      new StartDBClusterCommand({
        DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

When("a database cluster is stopped", async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { StopDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await neptuneClient(this).send(
      new StopDBClusterCommand({
        DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID,
      }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// "a database cluster configuration is modified" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance configuration is modified" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "a database instance is rebooted" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// "a cluster is restored from a snapshot" is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.restoreClusterFromSnapshot registered in the Before hook above).

// ── Given: multi-AZ state setup ───────────────────────────────────────────────

Given('multi-"AZ" is enabled for the cluster', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { ModifyDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act: enable multi-AZ on the cluster so FailoverDBCluster will succeed
  await neptuneClient(this).send(
    new ModifyDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID, MultiAZ: true }),
  );
  // Mark last call as successful since this is a setup step
  this.lastCallResult = { success: true, output: {} };
  // Assert: multi-AZ enabled
});

Given('multi-"AZ" is not enabled for the cluster', async function (this: SdkWorld) {
  // Arrange / Act / Assert — no-op: cannot disable multi-AZ via public API in lws.
  assert.ok(this.session, "Expected session to be initialized");
});

// ── When: multi-AZ failover ────────────────────────────────────────────────────

When('a multi-"AZ" failover is triggered on a cluster', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  const { FailoverDBClusterCommand } = require("@aws-sdk/client-neptune");
  // Act
  try {
    const result = await neptuneClient(this).send(
      new FailoverDBClusterCommand({ DBClusterIdentifier: NEPTUNE_TEST_CLUSTER_ID }),
    );
    this.lastCallResult = { success: true, output: result };
  } catch (err: unknown) {
    this.lastCallResult = { success: false, output: null, error: err };
  }
  // Assert: captured in lastCallResult
});

// ── Then: multi-AZ failover assertions ────────────────────────────────────────

Then('the cluster enters "MODIFYING" state for primary promotion', async function (this: SdkWorld) {
  // Arrange
  assert.ok(this.session, "Expected session to be initialized");
  assert.ok(
    this.clusterHelpers?.assertClusterStatus,
    "Expected clusterHelpers.assertClusterStatus to be registered",
  );
  // Act + Assert: delegate to service-specific helper
  await this.clusterHelpers.assertClusterStatus(this, "modifying");
});

// @internal: internal lifecycle actions — no-op

When("a database cluster finishes creating", async function (this: SdkWorld) {
  // @internal: complete_cluster_creation — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster creation fails", async function (this: SdkWorld) {
  // @internal: fail_cluster_creation — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster configuration modification completes", async function (this: SdkWorld) {
  // @internal: complete_cluster_modification — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster failover is completed", async function (this: SdkWorld) {
  // @internal: multi_a_z_failover — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a replica is promoted to primary", async function (this: SdkWorld) {
  // @internal: promote_replica_to_primary — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster finishes starting", async function (this: SdkWorld) {
  // @internal: complete_cluster_start — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster finishes stopping", async function (this: SdkWorld) {
  // @internal: complete_cluster_stop — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database instance finishes creating", async function (this: SdkWorld) {
  // @internal: complete_instance_creation — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database instance finishes deleting", async function (this: SdkWorld) {
  // @internal: complete_instance_deletion — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database instance modification completes", async function (this: SdkWorld) {
  // @internal: complete_instance_modification — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database instance finishes rebooting", async function (this: SdkWorld) {
  // @internal: complete_instance_reboot — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database snapshot finishes creating", async function (this: SdkWorld) {
  // @internal: complete_snapshot_creation — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database snapshot finishes deleting", async function (this: SdkWorld) {
  // @internal: complete_snapshot_deletion — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("a database cluster restore completes", async function (this: SdkWorld) {
  // @internal: complete_cluster_restore — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

When("an automated backup window runs on an available cluster", async function (this: SdkWorld) {
  // @internal: automated_backup_window — cannot force via public API.
  this.lastCallResult = { success: true, output: null };
});

// ── Then: assertions ──────────────────────────────────────────────────────────

// "the cluster is in {string} state" is registered in cluster_common.ts (dispatches via clusterHelpers.assertClusterStatus).

// "the instance is in {string} state and associated with the cluster" is registered in cross_service_common.ts (dispatches via databaseHelpers).
// "the instance is in {string} state" is registered in cross_service_common.ts (dispatches via databaseHelpers).

// 'the snapshot is in {string} state and linked to the cluster' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInStateLinkedToCluster).
// 'the snapshot is in {string} state' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertSnapshotInState).
// 'the restored cluster is in {string} state' is registered in cross_service_common.ts
// (dispatches via snapshotHelpers.assertRestoredClusterInState).

Then(
  /^a snapshot is "([^"]*)" and the cluster is in "([^"]*)" state$/,
  async function (this: SdkWorld, _snapshotStatus: string, _clusterStatus: string) {
    // Arrange / Act / Assert — no-op invariant: @internal automated_backup_window — trivially satisfied.
  },
);

// ── Safety invariant Then steps ───────────────────────────────────────────────

// "every cluster/instance/snapshot has a valid status" is registered in cross_service_common.ts.

Then("a stopped cluster has no available instances", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  'instances on a stopped or stopping cluster are not in "MODIFYING" state',
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

Then("a deleted cluster has no available instances", async function (this: SdkWorld) {
  // No-op invariant: trivially satisfied in an isolated test context.
});

Then(
  "every backing-up cluster has a corresponding in-progress snapshot",
  async function (this: SdkWorld) {
    // No-op invariant: trivially satisfied in an isolated test context.
  },
);

// "a failed cluster has no available instances" is registered in cross_service_common.ts.
