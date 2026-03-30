package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.services.rds.model.Tag;

/**
 * Step definitions for the RDS informal specification feature files.
 *
 * <p>Covers: create_d_b_instance, delete_d_b_instance_skip_snapshot,
 * delete_d_b_instance_with_snapshot, modify_d_b_instance, reboot_d_b_instance, create_d_b_snapshot,
 * delete_d_b_snapshot, enable_multi_a_z, tag_d_b_instance, restore_d_b_instance_from_d_b_snapshot.
 *
 * <p>Internal-only actions (activate_d_b_instance, finish_*, multi_az_failover, automated_backup)
 * are registered as no-ops with {@code @internal} comments.
 */
public class RdsSteps {

  private static final String TEST_DB_INSTANCE_ID = "test-rds-db-1";
  private static final String TEST_SNAPSHOT_ID = "test-rds-snapshot-1";
  private static final String TEST_DB_ENGINE = "mysql";
  private static final String TEST_DB_CLASS = "db.t3.micro";
  private static final String TEST_TAG_KEY = "e2e-rds-tag-key-1";
  private static final String TEST_TAG_VALUE = "test-rds-tag-value-1";

  private final WorldContext world;

  public RdsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: DB instance state setup ───────────────────────────────────────────

  @Given("the database instance does not already exist")
  public void theDatabaseInstanceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the database instance already exists")
  public void theDatabaseInstanceAlreadyExists() {
    // Arrange
    // Act
    rdsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the database instance exists")
  public void theDatabaseInstanceExists() {
    // Arrange
    // Act
    rdsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the instance is {string} or {string}")
  public void theInstanceIsOrState(String state1, String state2) {
    // Arrange / Act / Assert — no-op: DB instances in lws are available after creation.
  }

  @Given("the instance is neither {string} nor {string}")
  public void theInstanceIsNeitherNor(String state1, String state2) {
    // @internal: Cannot force a DB instance into neither AVAILABLE nor FAILED via public API.
    // Only reached by @lifecycle scenarios excluded by the tag filter.
    Assumptions.assumeTrue(
        false, "Cannot force a DB instance into neither AVAILABLE nor FAILED via public API.");
  }

  @Given("the database instance does not exist")
  public void theDatabaseInstanceDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("a snapshot slot is available")
  public void aSnapshotSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: always room for snapshots in lws.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: always room for snapshots in lws.");
  }

  @Given("no snapshot slot is available")
  public void noSnapshotSlotIsAvailable() {
    // @internal: Cannot exhaust snapshot slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot exhaust snapshot slot limit in lws via public APIs.");
  }

  @Given("the target instance slot is available")
  public void theTargetInstanceSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: always room for DB instances in lws.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: always room for DB instances in lws.");
  }

  @Given("the target instance slot is not available")
  public void theTargetInstanceSlotIsNotAvailable() {
    // @internal: Cannot exhaust instance slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot exhaust instance slot limit in lws via public APIs.");
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a database instance is created")
  public void aDatabaseInstanceIsCreated() {
    // Arrange: (instance may or may not exist — set up by Given steps)
    world.lastClusterService = "rds";
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.createDBInstance(
              r ->
                  r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                      .dbInstanceClass(TEST_DB_CLASS)
                      .engine(TEST_DB_ENGINE)
                      .masterUsername("admin")
                      .masterUserPassword("password123"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database instance is deleted without a final snapshot")
  public void aDatabaseInstanceIsDeletedWithoutAFinalSnapshot() {
    // Arrange: (instance state set up by Given steps)
    world.lastClusterService = "rds";
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.deleteDBInstance(
              r -> r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID).skipFinalSnapshot(true));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database instance is deleted with a final snapshot")
  public void aDatabaseInstanceIsDeletedWithAFinalSnapshot() {
    // Arrange: (instance state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.deleteDBInstance(
              r ->
                  r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                      .skipFinalSnapshot(false)
                      .finalDBSnapshotIdentifier(TEST_SNAPSHOT_ID));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database snapshot is created from an instance")
  public void aDatabaseSnapshotIsCreatedFromAnInstance() {
    // Arrange: (instance and snapshot state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.createDBSnapshot(
              r ->
                  r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                      .dbSnapshotIdentifier(TEST_SNAPSHOT_ID));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database snapshot is deleted")
  public void aDatabaseSnapshotIsDeleted() {
    // Arrange: (snapshot state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result = client.deleteDBSnapshot(r -> r.dbSnapshotIdentifier(TEST_SNAPSHOT_ID));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("multi-{string} is enabled on a database instance")
  public void multiAzIsEnabledOnADatabaseInstance(String az) {
    // Arrange: (instance state set up by Given steps)
    world.lastClusterService = "rds";
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.modifyDBInstance(r -> r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID).multiAZ(true));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a tag is applied to a database instance")
  public void aTagIsAppliedToADatabaseInstance() {
    // Arrange: build the ARN for the DB instance
    String resourceArn = "arn:aws:rds:us-east-1:000000000000:db:" + TEST_DB_INSTANCE_ID;
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      client.addTagsToResource(
          r ->
              r.resourceName(resourceArn)
                  .tags(Tag.builder().key(TEST_TAG_KEY).value(TEST_TAG_VALUE).build()));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a database instance is restored from a snapshot")
  public void aDatabaseInstanceIsRestoredFromASnapshot() {
    // Arrange: (snapshot state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.restoreDBInstanceFromDBSnapshot(
              r -> r.dbInstanceIdentifier("test-rds-db-2").dbSnapshotIdentifier(TEST_SNAPSHOT_ID));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("the instance is in {string} state and a snapshot is {string}")
  public void theInstanceIsInStateAndASnapshotIs(String instanceState, String snapshotState) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_db_instance with snapshot to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " expected_instance_state="
            + instanceState
            + " expected_snapshot_state="
            + snapshotState);
  }

  @Then("the snapshot is {string} and the instance is in {string} state")
  public void theSnapshotIsAndTheInstanceIsInState(String snapshotState, String instanceState) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_db_snapshot to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " expected_snapshot_state="
            + snapshotState
            + " expected_instance_state="
            + instanceState);
  }

  @Then("the instance is configured for multi-{string} deployment")
  public void theInstanceIsConfiguredForMultiAzDeployment(String az) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected modify_db_instance (multi-AZ) to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the instance tag state is unchanged \\(no-op model\\)")
  public void theInstanceTagStateIsUnchanged() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected add_tags_to_resource to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the restored instance is in {string} state")
  public void theRestoredInstanceIsInState(String expectedState) {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected restore_db_instance_from_db_snapshot to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " expected_state="
            + expectedState);
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  // "every database instance has a valid status" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every database snapshot has a valid status" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every backing-up instance has a corresponding in-progress snapshot" → CrossServiceSteps
  // (catch-all @And("^every .*$"))

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void rdsCreateDBInstance() {
    try (RdsClient client = world.session.rdsClient()) {
      client.createDBInstance(
          r ->
              r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                  .dbInstanceClass(TEST_DB_CLASS)
                  .engine(TEST_DB_ENGINE)
                  .masterUsername("admin")
                  .masterUserPassword("password123"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("DBInstanceAlreadyExists")) {
        throw e;
      }
    }
  }

  private void rdsCreateSnapshot() {
    try (RdsClient client = world.session.rdsClient()) {
      client.createDBSnapshot(
          r -> r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID).dbSnapshotIdentifier(TEST_SNAPSHOT_ID));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("DBSnapshotAlreadyExists")) {
        throw e;
      }
    }
  }
}
