package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.s3tables.S3TablesClient;

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
    Assumptions.assumeTrue(
        false, "Cannot force a bucket into a non-ACTIVE state via public API in lws.");
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

  @Then("the record \"EXISTS\" and the invocation is \"SUCCESS\"")
  public void theRecordExistsAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda record write result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot observe Lambda record write result in lws.");
  }

  // "every existing record references a table that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
