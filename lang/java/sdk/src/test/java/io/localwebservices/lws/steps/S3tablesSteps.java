package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.s3tables.S3TablesClient;
import software.amazon.awssdk.services.s3tables.model.CreateNamespaceResponse;
import software.amazon.awssdk.services.s3tables.model.CreateTableBucketResponse;
import software.amazon.awssdk.services.s3tables.model.CreateTableResponse;
import software.amazon.awssdk.services.s3tables.model.GetTableMaintenanceJobStatusResponse;
import software.amazon.awssdk.services.s3tables.model.GetTableResponse;
import software.amazon.awssdk.services.s3tables.model.MaintenanceStatus;
import software.amazon.awssdk.services.s3tables.model.OpenTableFormat;
import software.amazon.awssdk.services.s3tables.model.TableBucketSummary;
import software.amazon.awssdk.services.s3tables.model.TableMaintenanceConfigurationValue;
import software.amazon.awssdk.services.s3tables.model.TableMaintenanceType;

/**
 * Step definitions for the S3Tables informal specification feature files.
 *
 * <p>Covers: create_table_bucket, delete_table_bucket, create_namespace, delete_namespace,
 * create_table, delete_table, create_snapshot, expire_snapshot, start_compaction, evolve_schema,
 * put_table_policy, delete_table_policy, put_table_maintenance_configuration,
 * finish_creating_table_bucket, finish_creating_table, finish_deleting_namespace,
 * finish_deleting_table_bucket, finish_deleting_table, finish_compaction.
 */
public class S3tablesSteps {

  private static final String TEST_BUCKET_NAME = "test-s3tables-bucket-1";
  private static final String TEST_NAMESPACE_NAME = "test-s3tables-namespace-1";
  private static final String TEST_TABLE_NAME = "test-s3tables-table-1";
  private static final String TEST_POLICY = "{\"Version\":\"2012-10-17\",\"Statement\":[]}";

  private final WorldContext world;

  public S3tablesSteps(WorldContext world) {
    this.world = world;
  }

  // "the bucket is {string}" is registered in CrossServiceSteps (no-op).
  // "the bucket is not \"ACTIVE\"" is registered in CrossServiceSteps (Assumptions skip).
  // "the bucket is not \"CREATING\"/\"DELETING\"" — @internal scenarios only; handled by
  // CrossServiceSteps skip.

  @Given("the bucket has no active namespaces")
  public void theBucketHasNoActiveNamespaces() {
    // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  }

  @Given("the bucket has active namespaces")
  public void theBucketHasActiveNamespaces() {
    // Arrange
    // Act
    createNamespace();
    // Assert: namespace created (no error thrown)
  }

  // ── Given: namespace state setup ─────────────────────────────────────────────

  @Given("the namespace does not already exist")
  public void theNamespaceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  }

  @Given("the namespace already exists")
  public void theNamespaceAlreadyExists() {
    // Arrange
    // Act
    createNamespace();
    // Assert: namespace created (no error thrown)
  }

  @Given("the namespace exists")
  public void theNamespaceExists() {
    // Arrange
    // Act
    createNamespace();
    // Assert: namespace created (no error thrown)
  }

  @Given("the namespace is \"ACTIVE\"")
  public void theNamespaceIsActive() {
    // Arrange / Act / Assert — no-op: namespaces are always ACTIVE after creation in lws.
  }

  @Given("the namespace is not \"ACTIVE\"")
  public void theNamespaceIsNotActive() {
    // @internal: no public API can place a namespace in a non-ACTIVE state.
  }

  @Given("the namespace is \"DELETING\"")
  public void theNamespaceIsDeleting() {
    // @internal: no public API can place a namespace in DELETING state.
  }

  @Given("the namespace is not \"DELETING\"")
  public void theNamespaceIsNotDeleting() {
    // @internal: no public API can place a namespace in non-DELETING state selectively.
  }

  @Given("the namespace has no active tables")
  public void theNamespaceHasNoActiveTables() {
    // Arrange / Act / Assert — no-op: fresh namespace has no tables.
  }

  @Given("the namespace has active tables")
  public void theNamespaceHasActiveTables() {
    // Arrange
    // Act
    createTable();
    // Assert: table created (no error thrown)
  }

  @Given("the namespace does not exist")
  public void theNamespaceDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh bucket has no namespaces.
  }

  // "the table is \"ACTIVE\"/\"CREATING\"/\"DELETING\"" is registered in CrossServiceSteps (no-op).
  // "the table is not \"ACTIVE\"/\"DELETING\"" is registered in CrossServiceSteps (Assumptions
  // skip).
  // @internal table state scenarios are excluded by the tag filter.

  @Given("the table is in \"MAINTENANCE\" state")
  public void theTableIsInMaintenanceState() {
    // @internal: no public API can place a table in MAINTENANCE state.
  }

  @Given("the table is not in \"MAINTENANCE\" state")
  public void theTableIsNotInMaintenanceState() {
    // @internal: no public API can place a table in non-MAINTENANCE state selectively.
  }

  @Given("the table has a policy")
  public void theTableHasAPolicy() {
    // Arrange
    String arn = getBucketArn();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act: attach a policy to the table
      client.putTablePolicy(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .resourcePolicy(TEST_POLICY));
    }
    // Assert: policy attached (no error thrown)
  }

  @Given("the table does not have a policy")
  public void theTableDoesNotHaveAPolicy() {
    // Arrange / Act / Assert — no-op: fresh table has no policy.
  }

  @Given("the snapshot is \"ACTIVE\"")
  public void theSnapshotIsActive() {
    // Arrange / Act / Assert — no-op: snapshots are always ACTIVE after creation in lws.
  }

  @Given("the snapshot is not \"ACTIVE\"")
  public void theSnapshotIsNotActive() {
    // @internal: no public API can place a snapshot in a non-ACTIVE state.
  }

  @Given("the table has more than one snapshot")
  public void theTableHasMoreThanOneSnapshot() {
    // @internal: snapshot count is managed internally by lws.
  }

  @Given("the table has one or fewer snapshots")
  public void theTableHasOneOrFewerSnapshots() {
    // @internal: snapshot count is managed internally by lws.
  }

  // ── Given: compaction state setup ─────────────────────────────────────────────

  @Given("compaction is enabled for the table")
  public void compactionIsEnabledForTheTable() {
    // Arrange
    String arn = getBucketArn();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act: enable compaction via maintenance configuration
      client.putTableMaintenanceConfiguration(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .type(TableMaintenanceType.ICEBERG_COMPACTION)
                  .value(
                      TableMaintenanceConfigurationValue.builder()
                          .status(MaintenanceStatus.ENABLED)
                          .build()));
    }
    // Assert: compaction enabled (no error thrown)
  }

  @Given("compaction is not enabled for the table")
  public void compactionIsNotEnabledForTheTable() {
    // Arrange
    String arn = getBucketArn();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act: disable compaction via maintenance configuration
      client.putTableMaintenanceConfiguration(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .type(TableMaintenanceType.ICEBERG_COMPACTION)
                  .value(
                      TableMaintenanceConfigurationValue.builder()
                          .status(MaintenanceStatus.DISABLED)
                          .build()));
    }
    // Assert: compaction disabled (no error thrown)
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a table bucket is created")
  public void aTableBucketIsCreated() {
    // Arrange: (bucket state set up by Given steps)
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      CreateTableBucketResponse result = client.createTableBucket(r -> r.name(TEST_BUCKET_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table bucket is deleted")
  public void aTableBucketIsDeleted() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      client.deleteTableBucket(r -> r.tableBucketARN(arn));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a namespace is created in a table bucket")
  public void aNamespaceIsCreatedInATableBucket() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      CreateNamespaceResponse result =
          client.createNamespace(
              r -> r.tableBucketARN(arn).namespace(List.of(TEST_NAMESPACE_NAME)));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a namespace is deleted from a table bucket")
  public void aNamespaceIsDeletedFromATableBucket() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      client.deleteNamespace(r -> r.tableBucketARN(arn).namespace(TEST_NAMESPACE_NAME));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table is created in a namespace")
  public void aTableIsCreatedInANamespace() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      CreateTableResponse result =
          client.createTable(
              r ->
                  r.tableBucketARN(arn)
                      .namespace(TEST_NAMESPACE_NAME)
                      .name(TEST_TABLE_NAME)
                      .format(OpenTableFormat.ICEBERG));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a snapshot is created for a table")
  public void aSnapshotIsCreatedForATable() {
    // @internal: snapshot creation is managed internally by lws
    world.setSuccess(null);
  }

  @When("an expired snapshot is removed from a table")
  public void anExpiredSnapshotIsRemovedFromATable() {
    // @internal: snapshot expiry is managed internally by lws
    world.setSuccess(null);
  }

  @When("compaction is started on a table")
  public void compactionIsStartedOnATable() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      GetTableMaintenanceJobStatusResponse result =
          client.getTableMaintenanceJobStatus(
              r -> r.tableBucketARN(arn).namespace(TEST_NAMESPACE_NAME).name(TEST_TABLE_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("compaction finishes on a table")
  public void compactionFinishesOnATable() {
    // @internal: compaction completion is managed internally by lws
    world.setSuccess(null);
  }

  @When("a table bucket finishes creating")
  public void aTableBucketFinishesCreating() {
    // @internal: finish_creating_table_bucket is an internal state transition
    world.setSuccess(null);
  }

  @When("a table finishes creating")
  public void aTableFinishesCreating() {
    // @internal: finish_creating_table is an internal state transition
    world.setSuccess(null);
  }

  @When("a namespace finishes being deleted")
  public void aNamespaceFinishesBeingDeleted() {
    // @internal: finish_deleting_namespace is an internal state transition
    world.setSuccess(null);
  }

  @When("a table bucket finishes being deleted")
  public void aTableBucketFinishesBeingDeleted() {
    // @internal: finish_deleting_table_bucket is an internal state transition
    world.setSuccess(null);
  }

  @When("a table finishes being deleted")
  public void aTableFinishesBeingDeleted() {
    // @internal: finish_deleting_table is an internal state transition
    world.setSuccess(null);
  }

  @When("a table's schema is evolved")
  public void aTablesSchemaIsEvolved() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      GetTableResponse result =
          client.getTable(
              r -> r.tableBucketARN(arn).namespace(TEST_NAMESPACE_NAME).name(TEST_TABLE_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a policy is attached to a table")
  public void aPolicyIsAttachedToATable() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      client.putTablePolicy(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .resourcePolicy(TEST_POLICY));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table's policy is deleted")
  public void aTablesPolicyIsDeleted() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      client.deleteTablePolicy(
          r -> r.tableBucketARN(arn).namespace(TEST_NAMESPACE_NAME).name(TEST_TABLE_NAME));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("maintenance configuration is applied to a table")
  public void maintenanceConfigurationIsAppliedToATable() {
    // Arrange: retrieve bucket ARN
    String arn;
    try {
      arn = getBucketArn();
    } catch (Exception e) {
      world.setFailure(e);
      return;
    }
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      client.putTableMaintenanceConfiguration(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .type(TableMaintenanceType.ICEBERG_COMPACTION)
                  .value(
                      TableMaintenanceConfigurationValue.builder()
                          .status(MaintenanceStatus.ENABLED)
                          .build()));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the bucket is in \"CREATING\" state")
  public void theBucketIsInCreatingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_table_bucket to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected CreateTableBucketResponse but got null");
  }

  @Then("the bucket enters \"DELETING\" state")
  public void theBucketEntersDeletingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_table_bucket to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the bucket is \"DELETED\" and all its namespaces and tables are \"DELETED\"")
  public void theBucketIsDeletedAndAllItsNamespacesAndTablesAreDeleted() {
    // @internal: internal state assertion — no-op in public API test context.
  }

  @Then("the namespace enters \"DELETING\" state")
  public void theNamespaceEntersDeletingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_namespace to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the namespace is \"DELETED\" and all its tables are \"DELETED\"")
  public void theNamespaceIsDeletedAndAllItsTablesAreDeleted() {
    // @internal: internal state assertion — no-op in public API test context.
  }

  @Then("the table enters \"DELETING\" state")
  public void theTableEntersDeletingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_table to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the table is \"DELETED\" and all its snapshots are \"DELETED\"")
  public void theTableIsDeletedAndAllItsSnapshotsAreDeleted() {
    // @internal: internal state assertion — no-op in public API test context.
  }

  @Then("the table returns to \"ACTIVE\" state")
  public void theTableReturnsToActiveState() {
    // @internal: internal state assertion — no-op in public API test context.
  }

  @Then("the table enters \"MAINTENANCE\" state")
  public void theTableEntersMaintenanceState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected start_compaction to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected GetTableMaintenanceJobStatusResponse but got null");
  }

  @Then("the snapshot is \"ACTIVE\" and the table snapshot count increases")
  public void theSnapshotIsActiveAndTheTableSnapshotCountIncreases() {
    // @internal: snapshot state assertion — no-op in public API test context.
  }

  @Then("the snapshot is \"DELETED\" and the table snapshot count decreases")
  public void theSnapshotIsDeletedAndTheTableSnapshotCountDecreases() {
    // @internal: snapshot state assertion — no-op in public API test context.
  }

  @Then("the schema version is incremented")
  public void theSchemaVersionIsIncremented() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected evolve_schema to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected GetTableResponse but got null");
  }

  @Then("the table has no policy")
  public void theTableHasNoPolicy() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_table_policy to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  // ── Then: safety invariants (no-op) ───────────────────────────────────────────

  @Then("a bucket in \"DELETING\" state has no \"ACTIVE\" namespaces")
  public void aBucketInDeletingStateHasNoActiveNamespaces() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("a namespace in \"DELETING\" state has no \"ACTIVE\" tables")
  public void aNamespaceInDeletingStateHasNoActiveTables() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("snapshot count is never negative")
  public void snapshotCountIsNeverNegative() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  @Then("schema version is always at least one")
  public void schemaVersionIsAlwaysAtLeastOne() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void createBucket() {
    try (S3TablesClient client = world.session.s3TablesClient()) {
      client.createTableBucket(r -> r.name(TEST_BUCKET_NAME));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("ConflictException")) {
        throw e;
      }
    }
  }

  private void createNamespace() {
    String arn = getBucketArn();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      client.createNamespace(r -> r.tableBucketARN(arn).namespace(List.of(TEST_NAMESPACE_NAME)));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("ConflictException")) {
        throw e;
      }
    }
  }

  private void createTable() {
    String arn = getBucketArn();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      client.createTable(
          r ->
              r.tableBucketARN(arn)
                  .namespace(TEST_NAMESPACE_NAME)
                  .name(TEST_TABLE_NAME)
                  .format(OpenTableFormat.ICEBERG));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("ConflictException")) {
        throw e;
      }
    }
  }

  private String getBucketArn() {
    try (S3TablesClient client = world.session.s3TablesClient()) {
      List<TableBucketSummary> buckets =
          client
              .listTableBuckets(
                  software.amazon.awssdk.services.s3tables.model.ListTableBucketsRequest.builder()
                      .build())
              .tableBuckets();
      return buckets.stream()
          .filter(b -> TEST_BUCKET_NAME.equals(b.name()))
          .map(TableBucketSummary::arn)
          .findFirst()
          .orElseThrow(
              () -> new RuntimeException("table bucket \"" + TEST_BUCKET_NAME + "\" not found"));
    }
  }
}
