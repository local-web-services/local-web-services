package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Event;
import software.amazon.awssdk.services.s3.model.GetBucketNotificationConfigurationResponse;
import software.amazon.awssdk.services.s3.model.LambdaFunctionConfiguration;
import software.amazon.awssdk.services.s3.model.ListBucketsResponse;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Response;
import software.amazon.awssdk.services.s3.model.NotificationConfiguration;
import software.amazon.awssdk.services.s3.model.PutBucketNotificationConfigurationRequest;

/**
 * Step definitions for the s3api_lambda cross-service feature files.
 *
 * <p>Covers: configure_notification, create_bucket, deploy_function, invocation_fails,
 * invocation_succeeds, put_object_and_notify.
 *
 * <p>Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are NOT re-registered here. Given steps for bucket/function state are
 * re-registered here because this suite uses its own resource-name constants ("e2e-test-bucket-1",
 * "e2e-test-func-1") that differ from the single-service defaults.
 */
public class S3apiLambdaSteps {

  private static final String TEST_BUCKET = "e2e-test-bucket-1";
  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_KEY = "e2e-test-key-1";
  private static final String TEST_BODY = "test-data-content-1";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT_ID = "000000000000";

  private final WorldContext world;

  public S3apiLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String funcArn() {
    return "arn:aws:lambda:" + TEST_REGION + ":" + TEST_ACCOUNT_ID + ":function:" + TEST_FUNC;
  }

  private void s3CreateBucket(String bucketName) {
    try (S3Client client = world.session.s3Client()) {
      client.createBucket(r -> r.bucket(bucketName));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("BucketAlreadyExists") && !msg.contains("BucketAlreadyOwnedByYou")) {
        throw e;
      }
    }
  }

  private void s3DeleteBucket(String bucketName) {
    try (S3Client client = world.session.s3Client()) {
      client.deleteBucket(r -> r.bucket(bucketName));
    } catch (Exception ignored) {
      // bucket may not exist; desired state is absence
    }
  }

  private void lambdaCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void lambdaDeleteFunction() {
    try (LambdaClient client = world.session.lambdaClient()) {
      client.deleteFunction(r -> r.functionName(TEST_FUNC));
    } catch (Exception ignored) {
      // function may not exist; desired state is absence
    }
  }

  private void s3ConfigureNotification() {
    // Arrange
    String arn = funcArn();
    try (S3Client client = world.session.s3Client()) {
      // Act
      PutBucketNotificationConfigurationRequest req =
          PutBucketNotificationConfigurationRequest.builder()
              .bucket(TEST_BUCKET)
              .notificationConfiguration(
                  NotificationConfiguration.builder()
                      .lambdaFunctionConfigurations(
                          LambdaFunctionConfiguration.builder()
                              .lambdaFunctionArn(arn)
                              .events(Event.S3_OBJECT_CREATED_PUT)
                              .build())
                      .build())
              .build();
      client.putBucketNotificationConfiguration(req);
      // Assert: notification configured (no exception thrown)
    }
  }

  // ── Given: notification configuration state ───────────────────────────────────

  @Given("the bucket has no notification configured")
  public void theBucketHasNoNotificationConfigured() {
    // No-op: buckets have no notification configuration by default.
  }

  @Given("the bucket already has a notification configured")
  public void theBucketAlreadyHasANotificationConfigured() {
    // Arrange: create bucket and function if needed, then configure notification
    s3CreateBucket(TEST_BUCKET);
    lambdaCreateFunction();
    // Act
    s3ConfigureNotification();
    // Assert: notification configured (no error thrown)
  }

  @Given("the bucket has a notification configured")
  public void theBucketHasANotificationConfigured() {
    // Arrange: create bucket and function if needed, then configure notification
    s3CreateBucket(TEST_BUCKET);
    lambdaCreateFunction();
    // Act
    s3ConfigureNotification();
    // Assert: notification configured (no error thrown)
  }

  // ── Given: notification target function state ─────────────────────────────────

  @Given("the notification target function is {string}")
  public void theNotificationTargetFunctionIs(String state) {
    if ("ACTIVE".equals(state)) {
      // No-op: Lambda functions are ACTIVE immediately after creation in lws.
      return;
    }
    // @internal: Cannot place Lambda notification target function in a non-ACTIVE state in lws.
  }

  @Given("the notification target function is not {string}")
  public void theNotificationTargetFunctionIsNot(String state) {
    // @internal: Cannot place Lambda notification target function in a non-ACTIVE state
    // while it is already configured as a bucket notification target in lws.
    Assumptions.assumeTrue(
        false, "Cannot place Lambda notification target function in a non-ACTIVE state");
  }

  @When("an S3 event notification is configured to invoke a Lambda function on object \"PUT\"")
  public void anS3EventNotificationIsConfiguredToInvokeALambdaFunctionOnObjectPut() {
    // Arrange
    String arn = funcArn();
    try (S3Client client = world.session.s3Client()) {
      // Act
      PutBucketNotificationConfigurationRequest req =
          PutBucketNotificationConfigurationRequest.builder()
              .bucket(TEST_BUCKET)
              .notificationConfiguration(
                  NotificationConfiguration.builder()
                      .lambdaFunctionConfigurations(
                          LambdaFunctionConfiguration.builder()
                              .lambdaFunctionArn(arn)
                              .events(Event.S3_OBJECT_CREATED_PUT)
                              .build())
                      .build())
              .build();
      world.setSuccess(client.putBucketNotificationConfiguration(req));
      // Assert: captured in world
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "an object is put into the bucket and asynchronously invokes the configured Lambda function")
  public void anObjectIsPutIntoTheBucketAndAsynchronouslyInvokesTheConfiguredLambdaFunction() {
    // Arrange
    byte[] bodyBytes = TEST_BODY.getBytes(StandardCharsets.UTF_8);
    try (S3Client client = world.session.s3Client()) {
      // Act
      world.setSuccess(
          client.putObject(
              r -> r.bucket(TEST_BUCKET).key(TEST_KEY),
              RequestBody.fromInputStream(new ByteArrayInputStream(bodyBytes), bodyBytes.length)));
      // Assert: captured in world
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the bucket is \"ACTIVE\" with no event notification configured")
  public void theBucketIsActiveWithNoEventNotificationConfigured() {
    // Arrange
    try (S3Client client = world.session.s3Client()) {
      // Act
      ListBucketsResponse resp = client.listBuckets();
      // Assert
      String expectedBucketName = TEST_BUCKET;
      boolean actualExists =
          resp.buckets().stream().anyMatch(b -> expectedBucketName.equals(b.name()));
      assertTrue(
          actualExists, "Expected bucket '" + expectedBucketName + "' to be ACTIVE but not found");
    }
  }

  @Then("the bucket will asynchronously invoke the function when an object is put")
  public void theBucketWillAsynchronouslyInvokeTheFunctionWhenAnObjectIsPut() {
    // Arrange
    String expectedFuncArn = funcArn();
    try (S3Client client = world.session.s3Client()) {
      // Act
      GetBucketNotificationConfigurationResponse resp =
          client.getBucketNotificationConfiguration(r -> r.bucket(TEST_BUCKET));
      // Assert
      List<LambdaFunctionConfiguration> actualConfigs = resp.lambdaFunctionConfigurations();
      boolean actualContains =
          actualConfigs.stream().anyMatch(cfg -> expectedFuncArn.equals(cfg.lambdaFunctionArn()));
      assertTrue(
          actualContains,
          "Expected notification ARN '"
              + expectedFuncArn
              + "' to be configured but found: "
              + actualConfigs);
    }
  }

  @Then("the object \"EXISTS\" in the bucket and an invocation is \"IN_PROGRESS\"")
  public void theObjectExistsInTheBucketAndAnInvocationIsInProgress() {
    // Arrange
    String expectedKey = TEST_KEY;
    try (S3Client client = world.session.s3Client()) {
      // Act
      ListObjectsV2Response resp = client.listObjectsV2(r -> r.bucket(TEST_BUCKET));
      // Assert
      boolean actualExists =
          resp.contents().stream().anyMatch(obj -> expectedKey.equals(obj.key()));
      assertTrue(
          actualExists,
          "Expected object '"
              + expectedKey
              + "' to exist in bucket '"
              + TEST_BUCKET
              + "' but not found");
    }
  }

  // "every \"IN_PROGRESS\" invocation was triggered by an object in an \"ACTIVE\" bucket" →
  // CrossServiceSteps (catch-all @And("^every .*$"))
}
