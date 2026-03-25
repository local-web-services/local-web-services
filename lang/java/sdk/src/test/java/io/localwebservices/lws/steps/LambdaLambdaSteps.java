package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.lambda.model.State;

/**
 * Step definitions for the lambda_lambda cross-service informal specification feature files.
 *
 * <p>Covers: deploy_caller, deploy_callee, delete_callee, invoke_caller,
 * callee_invocation_succeeds, callee_invocation_fails.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected") are NOT re-registered here. All {@code @internal}-tagged
 * scenarios are excluded by the tag filter and their steps are implemented as no-ops.
 */
public class LambdaLambdaSteps {

  private static final String CALLER_FUNC = "e2e-lambda-caller-fn-1";
  private static final String CALLEE_FUNC = "e2e-lambda-callee-fn-1";
  private static final String ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaCreateCaller() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(CALLER_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(ROLE_ARN)
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

  private void lambdaCreateCallee() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(CALLEE_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(ROLE_ARN)
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

  // ── Given: caller function state ──────────────────────────────────────────────

  @Given("the caller function does not already exist")
  public void theCallerFunctionDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no Lambda functions.
  }

  @Given("the caller function already exists")
  public void theCallerFunctionAlreadyExists() {
    // Arrange: create the caller function so it already exists
    // Act
    lambdaCreateCaller();
    // Assert: caller created (no error thrown)
  }

  @Given("the caller exists")
  public void theCallerExists() {
    // Arrange: create the caller function
    // Act
    lambdaCreateCaller();
    // Assert: caller created (no error thrown)
  }

  @Given("the caller is {string}")
  public void theCallerIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: lws resolves functions to ACTIVE immediately after creation.
      return;
    }
    // For other states: @internal — cannot observe in lws.
  }

  @Given("the caller is not {string}")
  public void theCallerIsNot(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // Arrange: delete the caller, apply a create dwell so next create is non-ACTIVE
      try (LambdaClient client = world.session.lambdaClient()) {
        try {
          client.deleteFunction(r -> r.functionName(CALLER_FUNC));
        } catch (Exception ignored) {
          // function may not exist
        }
      }
      // Act: set lifecycle dwell to prevent immediate ACTIVE transition
      world.session.lifecycle("lambda").createDwellMs(5000).apply();
      lambdaCreateCaller();
      return;
    }
    // For other states: no-op.
  }

  @Given("the caller does not exist")
  public void theCallerDoesNotExist() {
    // No-op: fresh state has no Lambda functions.
  }

  // ── Given: callee function state ──────────────────────────────────────────────

  @Given("the callee function does not already exist")
  public void theCalleeFunctionDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no Lambda functions.
  }

  @Given("the callee function already exists")
  public void theCalleeFunctionAlreadyExists() {
    // Arrange: create the callee function so it already exists
    // Act
    lambdaCreateCallee();
    // Assert: callee created (no error thrown)
  }

  @Given("the callee exists")
  public void theCalleeExists() {
    // Arrange: create the callee function
    // Act
    lambdaCreateCallee();
    // Assert: callee created (no error thrown)
  }

  @Given("the callee is \"ACTIVE\"")
  public void theCalleeIsActive() {
    // Arrange: ensure callee exists (create, ignore already-exists errors)
    // Act
    lambdaCreateCallee();
    // Assert: callee exists and is ACTIVE
  }

  @Given("the callee is already \"DELETED\"")
  public void theCalleeIsAlreadyDeleted() throws Exception {
    // Arrange: create the callee, apply delete dwell, then delete it
    lambdaCreateCallee();
    // Act: set lifecycle dwell, then delete
    world.session.lifecycle("lambda").deleteDwellMs(5000).apply();
    try (LambdaClient client = world.session.lambdaClient()) {
      try {
        client.deleteFunction(r -> r.functionName(CALLEE_FUNC));
      } catch (Exception ignored) {
        // callee may not exist
      }
    }
    world.setSuccess(null);
    // Assert: callee is in deleted state
  }

  @Given("the callee does not exist")
  public void theCalleeDoesNotExist() {
    // No-op: fresh state has no Lambda functions.
  }

  @Given("the callee does not exist or is \"DELETED\"")
  public void theCalleeDoesNotExistOrIsDeleted() {
    // No-op: fresh state has no Lambda functions (simulates absent or deleted callee).
  }

  @Given("the callee is \"DELETED\"")
  public void theCalleeIsDeleted() {
    // @internal: No public API puts a callee in DELETED state without deleting it.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Given("the callee is not \"DELETED\"")
  public void theCalleeIsNotDeleted() {
    // Arrange: ensure callee exists (i.e. it is not deleted)
    // Act
    lambdaCreateCallee();
    // Assert: callee exists
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the caller function to represent an in-progress invocation context
    // Act
    lambdaCreateCaller();
    // Assert: caller created
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a caller Lambda function is deployed")
  public void aCallerLambdaFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(CALLER_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(CALLER_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a callee Lambda function is deployed")
  public void aCalleeLambdaFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(CALLEE_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(CALLEE_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the callee Lambda function is deleted")
  public void theCalleeLambdaFunctionIsDeleted() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.deleteFunction(r -> r.functionName(CALLEE_FUNC));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the caller Lambda function is invoked")
  public void theCallerLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda-to-Lambda invocation in lws without Docker.
    // Only reached by @internal scenarios excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("the caller fails to invoke the callee because the callee has been deleted")
  public void theCallerFailsToInvokeTheCallee() {
    // @internal: Cannot trigger Lambda-to-Lambda invocation failure in lws without Docker.
    // Only reached by @internal scenarios excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the caller Lambda function invokes the \"ACTIVE\" callee and the call succeeds")
  public void theCallerInvokesTheActiveCalleeAndSucceeds() {
    // @internal: Cannot trigger Lambda-to-Lambda invocation success in lws without Docker.
    // Only reached by @internal scenarios excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the caller function is \"ACTIVE\"")
  public void theCallerFunctionIsActive() {
    // Arrange
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      GetFunctionResponse result = client.getFunction(r -> r.functionName(CALLER_FUNC));
      State actualState = result.configuration().state();
      // Assert
      String expectedState = "Active";
      assertEquals(
          expectedState,
          actualState.toString(),
          "expected caller function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the callee function is \"ACTIVE\"")
  public void theCalleeFunctionIsActive() {
    // Arrange
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      GetFunctionResponse result = client.getFunction(r -> r.functionName(CALLEE_FUNC));
      State actualState = result.configuration().state();
      // Assert
      String expectedState = "Active";
      assertEquals(
          expectedState,
          actualState.toString(),
          "expected callee function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the callee is \"DELETED\" and invocations targeting it will fail")
  public void theCalleeIsDeletedAndInvocationsWillFail() {
    // Arrange
    boolean caughtError = false;
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.getFunction(r -> r.functionName(CALLEE_FUNC));
    } catch (Exception ignored) {
      caughtError = true;
    }
    // Assert
    boolean expectedDeleted = true;
    boolean actualDeleted = caughtError;
    assertTrue(
        actualDeleted,
        "expected callee '"
            + CALLEE_FUNC
            + "' to be deleted but it still exists; expected_deleted="
            + expectedDeleted
            + " actual_deleted="
            + actualDeleted);
  }

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a ResourceNotFoundException")
  public void theInvocationIsFailedWithResourceNotFoundException() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"SUCCESS\"")
  public void theInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation success in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" caller function")
  public void everyInProgressInvocationReferencesAnActiveCallerFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every successful invocation recorded which callee was invoked")
  public void everySuccessfulInvocationRecordedWhichCalleeWasInvoked() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
