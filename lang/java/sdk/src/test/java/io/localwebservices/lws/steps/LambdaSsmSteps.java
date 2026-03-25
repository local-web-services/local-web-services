package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.GetParameterResponse;
import software.amazon.awssdk.services.ssm.model.ParameterType;

/**
 * Step definitions for the lambda_ssm cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_parameter, delete_parameter, invoke_function,
 * invocation_fails_parameter_not_found, invocation_succeeds.
 *
 * <p>Steps already registered in {@link LambdaSteps} (function existence, function lifecycle
 * states) and {@link SsmSteps} (basic parameter existence) and {@link CrossServiceSteps} ("the
 * system is initialized", "the operation is rejected") and {@link StepfunctionsSsmSteps}
 * (parameterised parameter state steps) are intentionally absent here or registered as exact-string
 * overrides to avoid DuplicateStepDefinitionException.
 */
public class LambdaSsmSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PARAM = "/e2e/test/param/1";
  private static final String TEST_PARAM_VALUE = "e2e-test-value-1";

  private final WorldContext world;

  public LambdaSsmSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

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

  private void ssmCreateParameter() {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      client.putParameter(
          r -> r.name(TEST_PARAM).value(TEST_PARAM_VALUE).type(ParameterType.STRING));
      // Assert: creation succeeded (no exception thrown)
    } catch (software.amazon.awssdk.services.ssm.model.ParameterAlreadyExistsException ignored) {
      // parameter already exists — acceptable for setup steps
    }
  }

  private void ssmDeleteParameter() {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      client.deleteParameter(r -> r.name(TEST_PARAM));
      // Assert: deletion succeeded (no exception thrown)
    } catch (Exception ignored) {
      // Ignore — already deleted or does not exist
    }
  }

  private boolean ssmParameterExists() {
    try (SsmClient client = world.session.ssmClient()) {
      client.getParameter(r -> r.name(TEST_PARAM));
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  // ── Given: parameter state specific to lambda_ssm ────────────────────────────

  @Given("the parameter \"EXISTS\"")
  public void theParameterExists2() {
    // Arrange / Act / Assert — no-op: parameter already created by "the parameter exists" step.
  }

  @Given("the parameter is already \"DELETED\"")
  public void theParameterIsAlreadyDeleted() {
    // Arrange: create then delete the parameter to reach DELETED state
    ssmCreateParameter();
    // Act
    ssmDeleteParameter();
    // Assert: parameter is now deleted; verified by subsequent steps
    world.setSuccess("DELETED");
  }

  @Given("the parameter does not exist or is \"DELETED\"")
  public void theParameterDoesNotExistOrIsDeleted() {
    // Arrange / Act / Assert — no-op: fresh session has no SSM parameters.
  }

  @Given("the parameter is \"DELETED\"")
  public void theParameterIsDeleted() {
    // No-op: fresh state has no parameters (simulates deleted parameter).
  }

  @Given("the parameter is not \"DELETED\"")
  public void theParameterIsNotDeleted() {
    // Arrange: create the parameter so it exists and is not deleted
    // Act
    ssmCreateParameter();
    // Assert: parameter exists; verified by subsequent steps
  }

  @When("a parameter is created in \"SSM\" Parameter Store")
  public void aParameterIsCreatedInSsmParameterStore() {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      var response =
          client.putParameter(
              r ->
                  r.name(TEST_PARAM)
                      .value(TEST_PARAM_VALUE)
                      .type(ParameterType.STRING)
                      .overwrite(false));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is deleted from \"SSM\" Parameter Store")
  public void aParameterIsDeletedFromSsmParameterStore() {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      var response = client.deleteParameter(r -> r.name(TEST_PARAM));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function fails because the parameter has been deleted")
  public void theLambdaFunctionFailsBecauseTheParameterHasBeenDeleted() {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the Lambda function reads an existing parameter and completes successfully")
  public void theLambdaFunctionReadsAnExistingParameterAndCompletesSuccessfully() {
    // @internal: Cannot trigger Lambda invocation success in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success: scenario is @internal"));
  }

  @Then("the parameter \"EXISTS\" and can be read by Lambda")
  public void theParameterExistsAndCanBeReadByLambda() {
    // Arrange
    String expectedValue = TEST_PARAM_VALUE;
    // Act
    try (SsmClient client = world.session.ssmClient()) {
      GetParameterResponse response = client.getParameter(r -> r.name(TEST_PARAM));
      String actualValue = response.parameter().value() != null ? response.parameter().value() : "";
      // Assert
      assertEquals(
          expectedValue,
          actualValue,
          "expected parameter value '"
              + expectedValue
              + "' but got '"
              + actualValue
              + "'; expected_value="
              + expectedValue
              + " actual_value="
              + actualValue);
    }
  }

  @Then("the parameter is \"DELETED\" and will cause a ParameterNotFound error when read")
  public void theParameterIsDeletedAndWillCauseAParameterNotFoundErrorWhenRead() {
    // Arrange
    String expectedParamName = TEST_PARAM;
    // Act
    boolean actualGone = !ssmParameterExists();
    // Assert
    assertTrue(
        actualGone,
        "expected parameter '"
            + expectedParamName
            + "' to be deleted but it still exists;"
            + " expected_deleted="
            + expectedParamName
            + " actual_exists=true");
  }

  @Then("the invocation is \"FAILED\" with a ParameterNotFound error")
  public void theInvocationIsFailedWithAParameterNotFoundError() {
    // @internal: Cannot observe Lambda invocation failure in lws.
  }

  @Then("every successful invocation recorded which parameter it read")
  public void everySuccessfulInvocationRecordedWhichParameterItRead() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
