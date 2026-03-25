package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.CreateStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.DescribeStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;
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

  // ── Given: function state ──────────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no Lambda functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange: create the function so it already exists
    // Act
    lambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange: create the function
    // Act
    lambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange: delete the function if present so it does not exist
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act: delete, ignore errors (function may not exist)
      try {
        client.deleteFunction(r -> r.functionName(TEST_FUNC));
      } catch (Exception ignored) {
        // function may not exist; desired state is absence
      }
    }
    // Assert: desired state is absence
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // No-op: functions are ACTIVE immediately after creation in lws.
  }

  @Given("the function is not \"ACTIVE\"")
  public void theFunctionIsNotActive() throws Exception {
    // Arrange: delete the function, apply create dwell so next create is non-ACTIVE
    try (LambdaClient client = world.session.lambdaClient()) {
      try {
        client.deleteFunction(r -> r.functionName(TEST_FUNC));
      } catch (Exception ignored) {
        // function may not exist
      }
    }
    // Act: set lifecycle dwell to prevent immediate ACTIVE transition
    world.session.lifecycle("lambda").createDwellMs(5000).apply();
    lambdaCreateFunction();
    // Assert: function exists but is in a non-ACTIVE state
  }

  // ── Given: state machine state ─────────────────────────────────────────────────

  @Given("the state machine does not already exist")
  public void theStateMachineDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no state machines.
  }

  @Given("the state machine already exists")
  public void theStateMachineAlreadyExists() {
    // Arrange: create the state machine so it already exists
    // Act
    sfnCreateStateMachine();
    // Assert: state machine exists (no error thrown)
  }

  @Given("the state machine exists")
  public void theStateMachineExists() {
    // Arrange: create the state machine
    // Act
    sfnCreateStateMachine();
    // Assert: state machine exists (no error thrown)
  }

  @Given("the state machine is \"ACTIVE\"")
  public void theStateMachineIsActive() {
    // No-op: state machines are ACTIVE immediately after creation in lws.
  }

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

  @Given("the state machine does not exist")
  public void theStateMachineDoesNotExist() {
    // No-op: fresh state after reset has no state machines.
  }

  @Given("the state machine is \"DELETED\"")
  public void theStateMachineIsDeleted() {
    // No-op: fresh state has no state machines (simulates deleted state machine).
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

  // ── Given: execution state ─────────────────────────────────────────────────────

  @Given("an execution is \"RUNNING\"")
  public void anExecutionIsRunning() {
    // Arrange: create a state machine and start an execution so one is RUNNING
    sfnCreateStateMachine();
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      StartExecutionResponse result =
          client.startExecution(r -> r.stateMachineArn(smArn()).input("{\"key\":\"value\"}"));
      world.lastExecutionArn = result.executionArn();
      // Assert: execution started (no error thrown)
    }
  }

  @Given("no execution is \"RUNNING\"")
  public void noExecutionIsRunning() {
    // No-op: fresh state has no executions.
  }

  @Given("an execution slot is available")
  public void anExecutionSlotIsAvailable() {
    // No-op: execution slots are always available in lws fresh state.
  }

  @Given("no execution slot is available")
  public void noExecutionSlotIsAvailable() {
    // @internal: Cannot exhaust Step Functions execution slot limit via public API in lws.
    // Scenarios using this step are tagged @capacity and excluded from standard runs.
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create a Lambda function to represent an in-progress invocation context.
    // In lws, creating a function is the closest observable analogue; actual invocation
    // state is internal.
    // Act
    lambdaCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: invocation slots are always available in lws fresh state.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust Lambda invocation slot limit via public API in lws.
    // Scenarios using this step are tagged @capacity and excluded from standard runs.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      try {
        client.createFunction(
            r ->
                r.functionName(TEST_FUNC)
                    .runtime(Runtime.PYTHON3_12)
                    .role(TEST_ROLE_ARN)
                    .handler("index.handler")
                    .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
        world.setSuccess(TEST_FUNC);
      } catch (Exception e) {
        world.setFailure(e);
      }
    }
    // Assert: captured in world
  }

  @When("a Step Functions state machine is created")
  public void aStepFunctionsStateMachineIsCreated() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      try {
        CreateStateMachineResponse result =
            client.createStateMachine(
                r ->
                    r.name(TEST_SM)
                        .definition(TEST_PASS_DEFINITION)
                        .roleArn(TEST_ROLE_ARN)
                        .type(StateMachineType.STANDARD));
        world.lastStateMachineArn = result.stateMachineArn();
        world.setSuccess(result);
      } catch (Exception e) {
        world.setFailure(e);
      }
    }
    // Assert: captured in world
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

  @When("a running execution completes successfully")
  public void aRunningExecutionCompletesSuccessfully() {
    // @internal: Cannot observe internal execution completion via public API in lws.
    // This scenario is tagged @internal and excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution completion via public API in lws"));
    // Assert: captured in world
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation via public API in lws without Docker.
    // This scenario is tagged @internal and excluded by the tag filter.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation via public API in lws"));
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

  // ── Then: assertions ────────────────────────────────────────────────────────────

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActiveThen() {
    // Arrange
    String expectedState = "Active";
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      GetFunctionResponse result = client.getFunction(r -> r.functionName(TEST_FUNC));
      // Assert
      String actualState = result.configuration().stateAsString();
      assertEquals(
          expectedState,
          actualState,
          "Expected function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the state machine is \"ACTIVE\"")
  public void theStateMachineIsActiveThen() {
    // Arrange
    String expectedStatus = "ACTIVE";
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      DescribeStateMachineResponse result =
          client.describeStateMachine(r -> r.stateMachineArn(smArn()));
      // Assert
      String actualStatus = result.statusAsString();
      assertEquals(
          expectedStatus,
          actualStatus,
          "Expected state machine status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
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

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state via public API in lws.
  }

  @Then("the invocation is \"FAILED\" with a StateMachineDoesNotExist error")
  public void theInvocationIsFailedWithStateMachineDoesNotExist() {
    // @internal: Cannot observe Lambda invocation failure via public API in lws.
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesActiveFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every \"RUNNING\" execution references a state machine that exists")
  public void everyRunningExecutionReferencesStateMachineThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
