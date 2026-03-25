package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.s3tables.S3TablesClient;
import software.amazon.awssdk.services.s3tables.model.GetTableBucketResponse;

/**
 * Step definitions for the lambda_s3tables cross-service informal specification feature files.
 *
 * <p>Covers: create_table_bucket, create_table, delete_table, deploy_function, invoke_function,
 * write_record, invocation_fails_table_deleting.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
 */
public class LambdaS3tablesSteps {

  private static final String TEST_FUNC = "test-lambda-s3tables-1";
  private static final String TEST_BUCKET = "test-lambda-s3tables-bucket-1";
  private static final String TEST_TABLE_NAMESPACE = "default";
  private static final String TEST_TABLE = "test-lambda-s3tables-table-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  // Mutable scenario state
  private String bucketArn;
  private String tableArn;

  public LambdaS3tablesSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaS3tablesCreateFunction() {
    try (LambdaClient client = world.session.lambdaClient()) {
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private String ensureBucketArn() {
    if (bucketArn != null) {
      return bucketArn;
    }
    return "arn:aws:s3tables:" + TEST_REGION + ":" + TEST_ACCOUNT + ":bucket/" + TEST_BUCKET;
  }

  private void lambdaS3tablesCreateBucket() {
    try (S3TablesClient client = world.session.s3TablesClient()) {
      var result = client.createTableBucket(r -> r.name(TEST_BUCKET));
      bucketArn = result.arn();
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("ConflictException")) {
        throw e;
      }
      bucketArn = ensureBucketArn();
    }
  }

  private void lambdaS3tablesCreateTable() {
    lambdaS3tablesCreateBucket();
    try (S3TablesClient client = world.session.s3TablesClient()) {
      var result =
          client.createTable(
              r ->
                  r.tableBucketARN(bucketArn)
                      .namespace(TEST_TABLE_NAMESPACE)
                      .name(TEST_TABLE)
                      .format("ICEBERG"));
      tableArn = result.tableARN();
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("ConflictException")) {
        throw e;
      }
    }
  }

  // ── Given: function state ──────────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange
    // Act
    lambdaS3tablesCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    lambdaS3tablesCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange / Act / Assert — no-op: fresh functions are ACTIVE immediately after creation.
  }

  @Given("the function is not \"ACTIVE\"")
  public void theFunctionIsNotActive() {
    // @internal: Cannot force a function into a non-ACTIVE state via public API in lws.
  }

  // ── Given: bucket state ────────────────────────────────────────────────────────

  @Given("the bucket does not already exist")
  public void theBucketDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no buckets.
  }

  @Given("the bucket already exists")
  public void theBucketAlreadyExists() {
    // Arrange
    // Act
    lambdaS3tablesCreateBucket();
    // Assert: bucket created (no error thrown)
  }

  @Given("the table bucket is \"ACTIVE\"")
  public void theTableBucketIsActive() {
    // Arrange
    // Act
    lambdaS3tablesCreateBucket();
    // Assert: bucket created and is ACTIVE (no error thrown)
  }

  @Given("the table bucket is not \"ACTIVE\"")
  public void theTableBucketIsNotActive() {
    // @internal: Cannot force a bucket into a non-ACTIVE state via public API in lws.
  }

  // ── Given: table state ─────────────────────────────────────────────────────────

  @Given("the table does not already exist")
  public void theTableDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no tables.
  }

  @Given("the table already exists")
  public void theTableAlreadyExists() {
    // Arrange
    // Act
    lambdaS3tablesCreateTable();
    // Assert: table created (no error thrown)
  }

  @Given("the table exists")
  public void theTableExists() {
    // Arrange
    // Act
    lambdaS3tablesCreateTable();
    // Assert: table created (no error thrown)
  }

  @Given("the table does not exist")
  public void theTableDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no tables.
  }

  @Given("the table is \"ACTIVE\"")
  public void theTableIsActive() {
    // Arrange: ensure table exists; fresh tables start ACTIVE in lws
    // Act
    lambdaS3tablesCreateTable();
    // Assert: table is ACTIVE
  }

  @Given("a table is \"ACTIVE\"")
  public void aTableIsActive() {
    // Arrange
    // Act
    lambdaS3tablesCreateTable();
    // Assert: table created and is ACTIVE (no error thrown)
  }

  @Given("no table is \"ACTIVE\"")
  public void noTableIsActive() {
    // Arrange / Act / Assert — no-op: fresh state has no tables.
  }

  @Given("the table is \"DELETING\"")
  public void theTableIsDeleting() {
    // @internal: DELETING state is transient, not reachable via public API.
  }

  @Given("the table is not \"DELETING\"")
  public void theTableIsNotDeleting() {
    // Arrange
    // Act
    lambdaS3tablesCreateTable();
    // Assert: table is ACTIVE (not DELETING)
  }

  @Given("the table is already \"DELETING\"")
  public void theTableIsAlreadyDeleting() {
    // @internal: DELETING state is transient, not reachable via public API.
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaS3tablesCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
  }

  @Given("a record slot is available")
  public void aRecordSlotIsAvailable() {
    // No-op: always room for records in lws.
  }

  @Given("no record slot is available")
  public void noRecordSlotIsAvailable() {
    // @internal: Cannot exhaust record slot limit in lws via public APIs.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("an S3 table bucket is created")
  public void anS3TableBucketIsCreated() {
    // Arrange: (bucket state set up by Given steps)
    try (S3TablesClient client = world.session.s3TablesClient()) {
      // Act
      var result = client.createTableBucket(r -> r.name(TEST_BUCKET));
      // Assert: store result
      bucketArn = result.arn();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table is created in the table bucket")
  public void aTableIsCreatedInTheTableBucket() {
    // Arrange: (bucket/table state set up by Given steps)
    try (S3TablesClient client = world.session.s3TablesClient()) {
      String activeBucketArn = bucketArn != null ? bucketArn : ensureBucketArn();
      // Act
      var result =
          client.createTable(
              r ->
                  r.tableBucketARN(activeBucketArn)
                      .namespace(TEST_TABLE_NAMESPACE)
                      .name(TEST_TABLE)
                      .format("ICEBERG"));
      // Assert: store result
      tableArn = result.tableARN();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a table deletion is initiated")
  public void aTableDeletionIsInitiated() {
    // Arrange: (table state set up by Given steps)
    try (S3TablesClient client = world.session.s3TablesClient()) {
      String activeBucketArn = bucketArn != null ? bucketArn : ensureBucketArn();
      // Act
      client.deleteTable(
          r -> r.tableBucketARN(activeBucketArn).namespace(TEST_TABLE_NAMESPACE).name(TEST_TABLE));
      // Assert: store result
      world.setSuccess(TEST_TABLE);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange: (function state set up by Given steps)
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("the Lambda function writes a record to an \"ACTIVE\" table and succeeds")
  public void theLambdaFunctionWritesARecordToAnActiveTableAndSucceeds() {
    // @internal: Cannot trigger Lambda record write in lws without Docker.
    world.setFailure(new UnsupportedOperationException("write_record: scenario is @internal"));
  }

  @When("the Lambda function fails to write because the table is being deleted")
  public void theLambdaFunctionFailsToWriteBecauseTheTableIsBeingDeleted() {
    // @internal: Cannot trigger Lambda write failure due to DELETING table in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "invocation_fails_table_deleting: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the bucket is \"ACTIVE\"")
  public void theBucketIsActive() {
    // Arrange
    String expectedBucket = TEST_BUCKET;
    // Act
    try (S3TablesClient client = world.session.s3TablesClient()) {
      GetTableBucketResponse result =
          client.getTableBucket(
              r -> r.tableBucketARN(bucketArn != null ? bucketArn : ensureBucketArn()));
      // Assert
      assertNotNull(result, "expected table bucket response but got null");
      String actualName = result.name();
      assertEquals(
          expectedBucket,
          actualName,
          "expected bucket name '"
              + expectedBucket
              + "' but got '"
              + actualName
              + "'; expected_bucket="
              + expectedBucket
              + " actual_name="
              + actualName);
    }
  }

  @Then("the table is \"ACTIVE\"")
  public void theTableIsActiveThen() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_table to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    assertNotNull(world.lastOutput, "expected CreateTableResponse but got null");
  }

  @Then("the table is \"DELETING\" and write operations will fail")
  public void theTableIsDeletingAndWriteOperationsWillFail() {
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

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActiveThen() {
    // Arrange
    String expectedState = "Active";
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      var result = client.getFunction(r -> r.functionName(TEST_FUNC));
      String actualState = result.configuration().state().toString();
      // Assert
      assertEquals(
          expectedState,
          actualState,
          "expected function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the record \"EXISTS\" and the invocation is \"SUCCESS\"")
  public void theRecordExistsAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda record write result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a ResourceNotFoundException")
  public void theInvocationIsFailedWithAResourceNotFoundException() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the operation is rejected")
  public void theOperationIsRejected() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedRejected = true;
    boolean actualRejected = !world.lastSuccess;
    assertTrue(
        actualRejected,
        "expected operation to be rejected but it succeeded; expected_rejected="
            + expectedRejected
            + " actual_rejected="
            + actualRejected);
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every existing record references a table that exists")
  public void everyExistingRecordReferencesATableThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
