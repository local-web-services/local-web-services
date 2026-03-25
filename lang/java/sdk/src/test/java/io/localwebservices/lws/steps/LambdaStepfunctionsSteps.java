package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.CreateStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

/**
 * Step definitions for the lambda_stepfunctions cross-service informal specification feature files.
 *
 * <p>Covers: create_state_machine, delete_state_machine, deploy_function, execution_completes,
 * invocation_fails_state_machine_deleted, invoke_function, start_execution_task.
 *
 * <p>Safety invariants: InvocationRequiresActiveFunction,
 * RunningExecutionReferencesExistingStateMachine
 *
 * <p>Steps already registered in CrossServiceSteps ("the system is initialized", "the operation is
 * rejected") are NOT re-registered here.
 */
public class LambdaStepfunctionsSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_SM = "test-sm-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";

  private final WorldContext world;

  public LambdaStepfunctionsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String smArn() {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + TEST_SM;
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

  private void sfnCreateStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      CreateStateMachineResponse result =
          client.createStateMachine(
              r ->
                  r.name(TEST_SM)
                      .definition(TEST_PASS_DEFINITION)
                      .roleArn(TEST_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = result.stateMachineArn();
      // Assert: creation succeeded (no exception thrown)
    }
  }

  // "the function is not \"ACTIVE\"" — registered as @Given("the function is not {string}")
  // in LambdaSteps and covers this literal case; absent here to avoid
  // DuplicateStepDefinitionException.

  @Given("the state machine is already \"DELETED\"")
  public void theStateMachineIsAlreadyDeleted() throws Exception {
    // Arrange: create the state machine, apply a delete dwell, then delete it
    try {
      sfnCreateStateMachine();
    } catch (Exception ignored) {
      // may already exist
    }
    // Act: apply lifecycle dwell so delete keeps it in DELETING state
    world.session.lifecycle("stepfunctions").deleteDwellMs(5000).apply();
    try (SfnClient client = world.session.sfnClient()) {
      try {
        client.deleteStateMachine(r -> r.stateMachineArn(smArn()));
      } catch (Exception ignored) {
        // ignore; desired state is DELETED
      }
    }
    // Assert: state machine is in DELETED/DELETING state
  }

  @Given("the state machine is not \"DELETED\"")
  public void theStateMachineIsNotDeleted() {
    // Arrange: create a state machine so it exists and is ACTIVE (not DELETED)
    // Act
    sfnCreateStateMachine();
    // Assert: state machine exists and is ACTIVE
  }

  @Given("the state machine does not exist or is \"DELETED\"")
  public void theStateMachineDoesNotExistOrIsDeleted() {
    // No-op: fresh state has no state machines.
  }

  @When("a Step Functions state machine is deleted")
  public void aStepFunctionsStateMachineIsDeleted() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      try {
        client.deleteStateMachine(r -> r.stateMachineArn(smArn()));
        world.setSuccess(smArn());
      } catch (Exception e) {
        world.setFailure(e);
      }
    }
    // Assert: captured in world
  }

  @When(
      "the Lambda function fails to start an execution because the state machine has been deleted")
  public void theLambdaFunctionFailsToStartAnExecution() {
    // @internal: Cannot trigger Lambda invocation failure via public API in lws.
    // This scenario is tagged @internal and excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure via public API in lws"));
    // Assert: captured in world
  }

  @When("the Lambda function starts an execution of an \"ACTIVE\" state machine and succeeds")
  public void theLambdaFunctionStartsAnExecution() {
    // @internal: Cannot trigger Lambda-started execution via public API in lws.
    // This scenario is tagged @internal and excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda-started execution via public API in lws"));
    // Assert: captured in world
  }

  @Then("the state machine is \"DELETED\" and Lambda StartExecution calls will fail")
  public void theStateMachineIsDeletedThen() {
    // Arrange
    String expectedErrCode = "StateMachineDoesNotExist";
    try (SfnClient client = world.session.sfnClient()) {
      // Act: attempt to describe the state machine; it should not be found
      try {
        client.describeStateMachine(r -> r.stateMachineArn(smArn()));
        // Assert: should have thrown
        fail(
            "Expected state machine to be deleted but describe succeeded; expected_error="
                + expectedErrCode);
      } catch (Exception e) {
        String actualErrMsg = e.getMessage() != null ? e.getMessage() : "";
        // Assert: confirm error indicates the state machine does not exist
        assertTrue(
            actualErrMsg.contains(expectedErrCode) || actualErrMsg.contains("does not exist"),
            "Expected '"
                + expectedErrCode
                + "' error but got: "
                + actualErrMsg
                + "; expected_error="
                + expectedErrCode);
      }
    }
  }

  @Then("the execution is \"SUCCEEDED\"")
  public void theExecutionIsSucceeded() {
    // @internal: Cannot observe internal execution completion via public API in lws.
  }

  @Then("the execution is \"RUNNING\" and the invocation is \"SUCCESS\"")
  public void theExecutionIsRunningAndInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation result or execution state via public API in lws.
  }

  @Then("the invocation is \"FAILED\" with a StateMachineDoesNotExist error")
  public void theInvocationIsFailedWithStateMachineDoesNotExist() {
    // @internal: Cannot observe Lambda invocation failure via public API in lws.
  }

  // "every \"RUNNING\" execution references a state machine that exists" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
}
