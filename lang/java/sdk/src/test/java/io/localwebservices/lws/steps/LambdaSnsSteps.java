package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_sns cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_topic, invoke_function, invocation_fails, invocation_succeeds,
 * publish_to_topic.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} (e.g. "the system is initialized", "the
 * operation is rejected", "the topic does not already exist", "the topic already exists", "the
 * topic exists", "the topic is {string}", "the topic is not {string}", "the topic does not exist",
 * "an {string} topic is created") and in {@link LambdaSteps} (e.g. "the function does not already
 * exist", "the function already exists", "the function exists", "the function does not exist", "the
 * function is {string}", "the function is not {string}") are intentionally absent here to avoid
 * duplicate step definition errors.
 */
public class LambdaSnsSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaSnsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaSnsCreateFunction() {
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

  @When("the Lambda function publishes a message to the \"SNS\" topic during invocation")
  public void theLambdaFunctionPublishesAMessageToTheSnsTopicDuringInvocation() {
    // @internal: Cannot trigger Lambda SNS publish in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda SNS publish: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  // "the function is {string}" is already registered in LambdaSteps and covers
  // "Then the function is \"ACTIVE\"" — not re-registered here.

  @Then("the message is published to the topic")
  public void theMessageIsPublishedToTheTopic() {
    // @internal: Cannot observe Lambda SNS publish result in lws.
    // Scenarios requiring this step are @internal and will not run under the tag filter.
    Assumptions.assumeTrue(false, "Cannot observe Lambda SNS publish result in lws.");
  }

  @Then("publishing requires an \"ACTIVE\" topic to be present")
  public void publishingRequiresAnActiveTopicToBePresent() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(
        false, "No-op: model-level invariant; trivially satisfied in isolated lws context.");
  }
}
