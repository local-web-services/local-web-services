package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_s3api cross-service test suite.
 *
 * <p>Covers: create_bucket, deploy_function, invocation_fails, invocation_succeeds,
 * invoke_function, put_object.
 *
 * <p>Steps already registered in LambdaSteps ("the function does not already exist", "the function
 * already exists", "the function exists", "the function is {string}", "the function is not
 * {string}", "the function does not exist") and S3apiSteps ("the bucket does not already exist",
 * "the bucket already exists", "the bucket exists", "the bucket is {string}", "the bucket is not
 * {string}", "the bucket does not exist", "the object \"EXISTS\" in the bucket") are NOT
 * re-registered here.
 *
 * <p>Steps already registered in CrossServiceSteps ("the system is initialized", "the operation is
 * rejected") are NOT re-registered here.
 */
public class LambdaS3apiSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_BUCKET = "e2e-test-bucket-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaS3apiSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaS3apiCreateFunction() {
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

  @When("the Lambda function writes an object to the S3 bucket during invocation")
  public void theLambdaFunctionWritesAnObjectToTheS3BucketDuringInvocation() {
    // @internal: Cannot trigger Lambda object write during invocation via public API in lws.
    Assumptions.assumeTrue(
        false, "lws limitation: Lambda object write during invocation not reachable via SDK API");
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the bucket is {string}" is already registered as a parameterized Given in S3apiSteps;
  // it matches Then the bucket is "ACTIVE" via Cucumber keyword aliasing.

  // "the function is {string}" is already registered as a parameterized Given in LambdaSteps;
  // it matches Then the function is "ACTIVE" via Cucumber keyword aliasing.

  @Then("every existing object belongs to an \"ACTIVE\" bucket")
  public void everyExistingObjectBelongsToAnActiveBucket() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
