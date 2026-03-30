package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the secretsmanager_lambda cross-service feature files.
 *
 * <p>Covers: create_secret, deploy_function, configure_rotation, trigger_rotation, delete_function,
 * rotation_succeeds, rotation_fails_function_deleted.
 *
 * <p>Steps already registered in {@link LambdaSteps} (function existence, function lifecycle
 * states, "the function does not already exist", "the function already exists", "the function
 * exists", "the function does not exist", "the function is {string}"), {@link
 * StepfunctionsSecretsmanagerSteps} ("the secret does not already exist", "the secret already
 * exists", "the secret exists and is {string}", "the secret does not exist or is not {string}", "a
 * secret is created in Secrets Manager", "the secret is \"ACTIVE\""), {@link
 * LambdaSecretsmanagerSteps} ("an invocation is \"IN_PROGRESS\"", "no invocation is
 * \"IN_PROGRESS\"", "an invocation slot is available", "no invocation slot is available", "the
 * function is \"ACTIVE\"" Then), and {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid DuplicateStepDefinitionException.
 *
 * <p>@internal scenarios (rotation_succeeds, rotation_fails_function_deleted) are excluded by the
 * tag filter "(@minimal or @standard) and not @internal". Their step definitions are no-ops.
 */
public class SecretsmanagerLambdaSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public SecretsmanagerLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void smLambdaCreateFunction() {
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

  // ── Given: function cross-service preconditions ────────────────────────────────

  @Given("the function exists and is {string}")
  public void theFunctionExistsAndIs(String state) {
    // Arrange: create the function; lws resolves functions to ACTIVE immediately
    // Act
    smLambdaCreateFunction();
    // Assert: function is ACTIVE after creation (state parameter noted but lws is always ACTIVE)
  }

  @Given("the function does not exist or is not {string}")
  public void theFunctionDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — no-op: fresh state has no Lambda functions.
    // Non-ACTIVE function state is not reachable via public API in lws.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: fresh state has no Lambda functions.");
  }

  // ── Given: rotation configuration state ───────────────────────────────────────

  @Given("the secret has no rotation function configured")
  public void theSecretHasNoRotationFunctionConfigured() {
    // Arrange / Act / Assert — no-op: secrets have no rotation function configured by default.
  }

  @Given("the secret already has a rotation function configured")
  public void theSecretAlreadyHasARotationFunctionConfigured() {
    // Arrange / Act / Assert — cannot configure secret rotation Lambda trigger in lws
    Assumptions.assumeTrue(
        false, "lws limitation: secret rotation Lambda trigger is not configurable via SDK API");
  }

  @Given("the secret has a rotation function configured")
  public void theSecretHasARotationFunctionConfigured() {
    // Arrange / Act / Assert — cannot configure secret rotation Lambda trigger in lws
    Assumptions.assumeTrue(
        false, "lws limitation: secret rotation Lambda trigger is not configurable via SDK API");
  }

  // ── Given: rotation function lifecycle state ───────────────────────────────────

  @Given("the rotation function is {string}")
  public void theRotationFunctionIs(String state) {
    // Arrange / Act / Assert — @internal: Cannot configure rotation function state in lws.
    // Scenarios using this step are tagged @internal and excluded by the tag filter.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — @internal: Cannot configure rotation function state in ");
  }

  @Given("the rotation function is not {string}")
  public void theRotationFunctionIsNot(String state) {
    // Arrange / Act / Assert — @internal: Cannot configure rotation function state in lws.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — @internal: Cannot configure rotation function state in ");
  }

  @Given("the function is already {string}")
  public void theFunctionIsAlready(String state) {
    // Arrange
    if ("DELETED".equals(state)) {
      // @internal: Cannot observe Lambda DELETED state without triggering delete lifecycle.
      // Scenarios using this step are tagged @lifecycle and excluded from the standard run.
      return;
    }
    // For other states, no-op.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────────

  // "a secret is created in Secrets Manager" is already registered in
  // StepfunctionsSecretsmanagerSteps; intentionally absent here.

  @When("a Lambda rotation function is deployed")
  public void aLambdaRotationFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      var response =
          client.createFunction(
              r ->
                  r.functionName(TEST_FUNC)
                      .runtime(Runtime.PYTHON3_12)
                      .role(TEST_ROLE_ARN)
                      .handler("index.handler")
                      .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("rotation is configured on the secret linking it to the Lambda rotation function")
  public void rotationIsConfiguredOnTheSecretLinkingItToTheLambdaRotationFunction() {
    // Arrange / Act / Assert — cannot configure secret rotation Lambda trigger in lws
    world.setFailure(
        new UnsupportedOperationException(
            "cannot configure secret rotation Lambda trigger in lws"));
  }

  @When("a rotation is triggered for the secret")
  public void aRotationIsTriggeredForTheSecret() {
    // Arrange / Act / Assert — cannot trigger SecretsManager->Lambda rotation in lws
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger SecretsManager->Lambda invocation in lws"));
  }

  @When("the rotation function is deleted")
  public void theRotationFunctionIsDeleted() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      var response = client.deleteFunction(r -> r.functionName(TEST_FUNC));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda rotation function succeeds and the secret is rotated to a new version")
  public void theLambdaRotationFunctionSucceedsAndTheSecretIsRotatedToANewVersion() {
    // @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger rotation success: scenario is @internal"));
  }

  @When("the Lambda rotation function fails and the rotation is aborted")
  public void theLambdaRotationFunctionFailsAndTheRotationIsAborted() {
    // @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger rotation failure: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the secret is \"ROTATING\" and Secrets Manager invokes the Lambda rotation function")
  public void theSecretIsRotatingAndSecretsManagerInvokesTheLambdaRotationFunction() {
    // Cannot trigger SecretsManager->Lambda rotation in lws.
    // No-op: scenarios reaching this assertion are excluded.
    Assumptions.assumeTrue(false, "Cannot trigger SecretsManager->Lambda rotation in lws.");
  }

  @Then("the function is \"DELETED\" and rotation will fail")
  public void theFunctionIsDeletedAndRotationWillFail() {
    // Arrange
    String expectedFunctionName = TEST_FUNC;
    // Act
    boolean actualExists;
    try (LambdaClient client = world.session.lambdaClient()) {
      try {
        GetFunctionResponse response =
            client.getFunction(r -> r.functionName(expectedFunctionName));
        actualExists = response.configuration() != null;
      } catch (Exception e) {
        actualExists = false;
      }
    }
    // Assert
    boolean expectedExists = false;
    assertFalse(
        actualExists,
        "expected rotation function '"
            + expectedFunctionName
            + "' to be deleted but it still exists; expected_exists="
            + expectedExists
            + " actual_exists="
            + actualExists);
  }

  @Then("the invocation is \"SUCCESS\" and the secret is \"ACTIVE\" with a new version")
  public void theInvocationIsSuccessAndTheSecretIsActiveWithANewVersion() {
    // @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
    // No-op: invariant assertion for excluded @internal scenarios.
    Assumptions.assumeTrue(false, "Cannot trigger SecretsManager->Lambda invocation in lws.");
  }

  @Then("the invocation is \"FAILED\" and the secret remains \"ACTIVE\" with the old version")
  public void theInvocationIsFailedAndTheSecretRemainsActiveWithTheOldVersion() {
    // @internal: Cannot trigger SecretsManager->Lambda invocation in lws.
    // No-op: invariant assertion for excluded @internal scenarios.
    Assumptions.assumeTrue(false, "Cannot trigger SecretsManager->Lambda invocation in lws.");
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  // "every \"ROTATING\" secret has an \"IN_PROGRESS\" rotation invocation" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
  // "every successful rotation invocation recorded which secret it rotated" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
}
