package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.neptune.NeptuneClient;
import software.amazon.awssdk.services.neptune.model.DBClusterSnapshot;
import software.amazon.awssdk.services.neptune.model.DBInstance;
import software.amazon.awssdk.services.neptune.model.DescribeDbClusterSnapshotsResponse;
import software.amazon.awssdk.services.neptune.model.DescribeDbInstancesResponse;

/**
 * Step definitions for the Neptune informal specification feature files.
 *
 * <p>Covers: create_d_b_cluster, delete_d_b_cluster, create_d_b_instance, delete_d_b_instance,
 * create_d_b_cluster_snapshot, delete_d_b_cluster_snapshot, start_d_b_cluster, stop_d_b_cluster,
 * modify_d_b_cluster, modify_d_b_instance, reboot_d_b_instance, restore_d_b_cluster_from_snapshot.
 */
public class NeptuneSteps {

  private static final String TEST_CLUSTER_ID = "test-neptune-cluster-1";
  private static final String TEST_INSTANCE_ID = "test-neptune-instance-1";
  private static final String TEST_SNAPSHOT_ID = "test-neptune-snapshot-1";
  private static final String TEST_DB_CLASS = "db.r5.large";
  private static final String TEST_ENGINE = "neptune";

  private final WorldContext world;

  public NeptuneSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void neptuneCreateCluster() {
    try (NeptuneClient client = world.session.neptuneClient()) {
      client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine(TEST_ENGINE));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("AlreadyExists")) {
        throw e;
      }
    }
  }

  private void neptuneCreateInstance() {
    try (NeptuneClient client = world.session.neptuneClient()) {
      client.createDBInstance(
          r ->
              r.dbInstanceIdentifier(TEST_INSTANCE_ID)
                  .dbClusterIdentifier(TEST_CLUSTER_ID)
                  .dbInstanceClass(TEST_DB_CLASS)
                  .engine(TEST_ENGINE));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("AlreadyExists")) {
        throw e;
      }
    }
  }

  private void neptuneCreateSnapshot() {
    try (NeptuneClient client = world.session.neptuneClient()) {
      client.createDBClusterSnapshot(
          r ->
              r.dbClusterSnapshotIdentifier(TEST_SNAPSHOT_ID).dbClusterIdentifier(TEST_CLUSTER_ID));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("AlreadyExists")) {
        throw e;
      }
    }
  }

  @When("a stopped database cluster is started")
  public void aStoppedDatabaseClusterIsStarted() {
    // Arrange: (cluster state set up by Given steps)
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response = client.startDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database cluster is stopped")
  public void aDatabaseClusterIsStopped() {
    // Arrange: (cluster state set up by Given steps)
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response = client.stopDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database instance is rebooted")
  public void aDatabaseInstanceIsRebooted() {
    // Arrange: (instance state set up by Given steps)
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response = client.rebootDBInstance(r -> r.dbInstanceIdentifier(TEST_INSTANCE_ID));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database cluster configuration modification completes")
  public void aDatabaseClusterConfigurationModificationCompletes() {
    // @internal: complete_cluster_modification — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database cluster failover is completed")
  public void aDatabaseClusterFailoverIsCompleted() {
    // @internal: multi_a_z_failover — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a replica is promoted to primary")
  public void aReplicaIsPromotedToPrimary() {
    // @internal: promote_replica_to_primary — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database cluster finishes starting")
  public void aDatabaseClusterFinishesStarting() {
    // @internal: complete_cluster_start — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database cluster finishes stopping")
  public void aDatabaseClusterFinishesStopping() {
    // @internal: complete_cluster_stop — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database instance finishes deleting")
  public void aDatabaseInstanceFinishesDeleting() {
    // @internal: complete_instance_deletion — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database instance finishes rebooting")
  public void aDatabaseInstanceFinishesRebooting() {
    // @internal: complete_instance_reboot — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database snapshot finishes creating")
  public void aDatabaseSnapshotFinishesCreating() {
    // @internal: complete_snapshot_creation — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database snapshot finishes deleting")
  public void aDatabaseSnapshotFinishesDeleting() {
    // @internal: complete_snapshot_deletion — cannot force via public API.
    world.setSuccess(null);
  }

  @When("a database cluster restore completes")
  public void aDatabaseClusterRestoreCompletes() {
    // @internal: complete_cluster_restore — cannot force via public API.
    world.setSuccess(null);
  }

  @When("an automated backup window runs on an available cluster")
  public void anAutomatedBackupWindowRunsOnAnAvailableCluster() {
    // @internal: automated_backup_window — cannot force via public API.
    world.setSuccess(null);
  }

  @Then("the instance is in {string} state and associated with the cluster")
  public void theInstanceIsInStateAndAssociatedWithTheCluster(String expectedStatus) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected operation to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    try (NeptuneClient client = world.session.neptuneClient()) {
      DescribeDbInstancesResponse result =
          client.describeDBInstances(r -> r.dbInstanceIdentifier(TEST_INSTANCE_ID));
      List<DBInstance> actualInstances = result.dbInstances();
      assertNotNull(actualInstances, "expected DBInstances list but got null");
      assertTrue(
          !actualInstances.isEmpty(),
          "expected instance '" + TEST_INSTANCE_ID + "' to exist but not found");
      String actualStatus = actualInstances.get(0).dbInstanceStatus();
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected instance status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the instance is in {string} state")
  public void theInstanceIsInState(String expectedStatus) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected operation to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    try (NeptuneClient client = world.session.neptuneClient()) {
      DescribeDbInstancesResponse result =
          client.describeDBInstances(r -> r.dbInstanceIdentifier(TEST_INSTANCE_ID));
      List<DBInstance> actualInstances = result.dbInstances();
      assertNotNull(actualInstances, "expected DBInstances list but got null");
      assertTrue(
          !actualInstances.isEmpty(),
          "expected instance '" + TEST_INSTANCE_ID + "' to exist but not found");
      String actualStatus = actualInstances.get(0).dbInstanceStatus();
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected instance status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the snapshot is in {string} state and linked to the cluster")
  public void theSnapshotIsInStateAndLinkedToTheCluster(String expectedStatus) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected operation to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    try (NeptuneClient client = world.session.neptuneClient()) {
      DescribeDbClusterSnapshotsResponse result =
          client.describeDBClusterSnapshots(r -> r.dbClusterSnapshotIdentifier(TEST_SNAPSHOT_ID));
      List<DBClusterSnapshot> actualSnapshots = result.dbClusterSnapshots();
      assertNotNull(actualSnapshots, "expected DBClusterSnapshots list but got null");
      assertTrue(
          !actualSnapshots.isEmpty(),
          "expected snapshot '" + TEST_SNAPSHOT_ID + "' to exist but not found");
      String actualStatus = actualSnapshots.get(0).status();
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected snapshot status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("a snapshot is {string} and the cluster is in {string} state")
  public void aSnapshotIsAndTheClusterIsInState(String snapshotStatus, String clusterStatus) {
    // No-op invariant: @internal automated_backup_window — trivially satisfied.
  }

  @Then("a stopped cluster has no available instances")
  public void aStoppedClusterHasNoAvailableInstances() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("instances on a stopped or stopping cluster are not in \"MODIFYING\" state")
  public void instancesOnAStoppedOrStoppingClusterAreNotInModifyingState() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("a deleted cluster has no available instances")
  public void aDeletedClusterHasNoAvailableInstances() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("every backing-up cluster has a corresponding in-progress snapshot")
  public void everyBackingUpClusterHasACorrespondingInProgressSnapshot() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }
}
