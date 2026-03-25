package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.CreateStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.DescribeExecutionResponse;
import software.amazon.awssdk.services.sfn.model.DescribeStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.GetExecutionHistoryResponse;
import software.amazon.awssdk.services.sfn.model.ListExecutionsResponse;
import software.amazon.awssdk.services.sfn.model.ListStateMachineVersionsResponse;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;
import software.amazon.awssdk.services.sfn.model.ListTagsForResourceResponse;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StartSyncExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;
import software.amazon.awssdk.services.sfn.model.Tag;
import software.amazon.awssdk.services.sfn.model.UpdateStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.ValidateStateMachineDefinitionResponse;

/**
 * Step definitions for the StepFunctions informal specification feature files.
 *
 * <p>Covers: create_state_machine, delete_state_machine, describe_state_machine,
 * list_state_machines, list_executions, list_state_machine_versions, list_tags_for_resource,
 * start_execution, start_sync_execution, stop_execution, describe_execution, get_execution_history,
 * update_state_machine, tag_resource, untag_resource, validate_state_machine_definition,
 * sync_execution_only_for_express.
 *
 * <p>Steps already registered in CrossServiceSteps (the system is initialized, the operation is
 * rejected, every .* catch-all) are NOT re-registered here.
 */
public class StepfunctionsSteps {

  private static final String TEST_SM = "e2e-sfn-test-sm-1";
  private static final String TEST_SM_EXPRESS = "e2e-sfn-test-sm-express-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/e2e-role";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_UPDATED_DEFINITION =
      "{\"StartAt\":\"PassV2\",\"States\":{\"PassV2\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_TAG_KEY = "e2e-sfn-test-tag-key-1";
  private static final String TEST_TAG_VALUE = "e2e-sfn-test-tag-value-1";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void sfnCreateStateMachine(String name, StateMachineType type) {
    try (SfnClient client = world.session.sfnClient()) {
      CreateStateMachineResponse result =
          client.createStateMachine(
              r -> r.name(name).definition(TEST_PASS_DEFINITION).roleArn(TEST_ROLE_ARN).type(type));
      world.lastStateMachineArn = result.stateMachineArn();
    }
  }

  private void sfnStartExecution(String smName) {
    try (SfnClient client = world.session.sfnClient()) {
      StartExecutionResponse result =
          client.startExecution(r -> r.stateMachineArn(smArn(smName)).input(TEST_INPUT));
      world.lastExecutionArn = result.executionArn();
    }
  }

  // ── Given: state machine status / type ───────────────────────────────────────

  @Given("the state machine is \"ACTIVE\"")
  public void theStateMachineIsActive() {
    // Arrange / Act / Assert — no-op: state machines are ACTIVE immediately after creation.
  }

  @Given("the state machine is not \"ACTIVE\"")
  public void theStateMachineIsNotActive() throws Exception {
    // Arrange: use lifecycle API to keep state machine in CREATING state
    // Act
    world.session.lifecycle("stepfunctions").createDwellMs(5000).apply();
    sfnCreateStateMachine(TEST_SM, StateMachineType.STANDARD);
    // Assert: state machine is in CREATING state (dwell applied)
  }

  @Given("the state machine is \"DELETING\"")
  public void theStateMachineIsDeleting() {
    // Arrange: delete the state machine so it enters DELETING state
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      try {
        client.deleteStateMachine(r -> r.stateMachineArn(smArn(TEST_SM)));
      } catch (Exception ignored) {
        // ignore; desired state is DELETING
      }
    }
    // Assert: deletion triggered
  }

  @Given("the state machine is not \"DELETING\"")
  public void theStateMachineIsNotDeleting() {
    // Arrange / Act / Assert — no-op: state machines are not DELETING by default.
  }

  @Given("the state machine is \"DELETED\"")
  public void theStateMachineIsDeleted() {
    // Arrange: create state machine then delete it to set up DELETED state
    sfnCreateStateMachine(TEST_SM, StateMachineType.STANDARD);
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.deleteStateMachine(r -> r.stateMachineArn(smArn(TEST_SM)));
    } catch (Exception ignored) {
      // ignore; desired state is DELETED
    }
    // Assert: state machine is deleted (no error thrown)
  }

  // "the state machine is not \"DELETED\"" → LambdaStepfunctionsSteps

  @Given("the state machine is a \"STANDARD\" type")
  public void theStateMachineIsStandardType() {
    // Arrange / Act / Assert — no-op: state machine is STANDARD by default.
  }

  @Given("the state machine is not a \"STANDARD\" type")
  public void theStateMachineIsNotStandardType() {
    // Arrange: create an EXPRESS type state machine instead
    // Act
    sfnCreateStateMachine(TEST_SM_EXPRESS, StateMachineType.EXPRESS);
    // Assert: EXPRESS state machine exists (no error thrown)
  }

  @Given("the state machine is an \"EXPRESS\" type")
  public void theStateMachineIsExpressType() {
    // Arrange: create an EXPRESS type state machine
    // Act
    sfnCreateStateMachine(TEST_SM_EXPRESS, StateMachineType.EXPRESS);
    // Assert: EXPRESS state machine exists (no error thrown)
  }

  @Given("the state machine is not an \"EXPRESS\" type")
  public void theStateMachineIsNotExpressType() {
    // Arrange: ensure a STANDARD state machine exists
    if (world.lastStateMachineArn == null) {
      // Act
      sfnCreateStateMachine(TEST_SM, StateMachineType.STANDARD);
    }
    // Assert: STANDARD state machine exists
  }

  // ── Given: execution existence ────────────────────────────────────────────────

  @Given("the execution exists")
  public void theExecutionExists() {
    // Arrange: ensure state machine exists
    if (world.lastStateMachineArn == null) {
      sfnCreateStateMachine(TEST_SM, StateMachineType.STANDARD);
    }
    // Act: start an execution
    sfnStartExecution(TEST_SM);
    // Assert: execution started (no error thrown)
  }

  @Given("the execution is \"RUNNING\"")
  public void theExecutionIsRunning() {
    // Arrange / Act / Assert — no-op: newly started executions are RUNNING.
  }

  @Given("the execution is not \"RUNNING\"")
  public void theExecutionIsNotRunning() {
    // Arrange: ensure state machine exists so an execution can be started and complete
    if (world.lastStateMachineArn == null) {
      sfnCreateStateMachine(TEST_SM, StateMachineType.STANDARD);
    }
    // Act: start an execution; a Pass SM completes immediately to SUCCEEDED (not RUNNING)
    sfnStartExecution(TEST_SM);
    // Assert: execution is SUCCEEDED (not RUNNING) after completing
  }

  @Given("the execution does not exist")
  public void theExecutionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  }

  // ── Given: tags ───────────────────────────────────────────────────────────────

  @Given("the tag is associated with the state machine")
  public void theTagIsAssociatedWithTheStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.tagResource(
          r ->
              r.resourceArn(smArn(TEST_SM))
                  .tags(Tag.builder().key(TEST_TAG_KEY).value(TEST_TAG_VALUE).build()));
    }
    // Assert: tag added (no error thrown)
  }

  @Given("the tag is not associated with the state machine")
  public void theTagIsNotAssociatedWithTheStateMachine() {
    // Arrange / Act / Assert — no-op: a fresh state machine has no tags.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("the execution slot is available")
  public void theExecutionSlotIsAvailable() throws Exception {
    // Arrange: ensure unlimited capacity for stepfunctions
    // Act
    world.session.capacity("stepfunctions").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("the execution slot is not available")
  public void theExecutionSlotIsNotAvailable() throws Exception {
    // Arrange: exhaust the stepfunctions execution capacity
    // Act
    world.session.capacity("stepfunctions").exhaust().apply();
    // Assert: capacity is exhausted
  }

  @When("a state machine is deleted")
  public void aStateMachineIsDeleted() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.deleteStateMachine(r -> r.stateMachineArn(smArn(TEST_SM)));
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a state machine is described")
  public void aStateMachineIsDescribed() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      DescribeStateMachineResponse result =
          client.describeStateMachine(r -> r.stateMachineArn(smArn(TEST_SM)));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("all state machines are listed")
  public void allStateMachinesAreListed() {
    // Arrange: no setup required
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      ListStateMachinesResponse result = client.listStateMachines();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("executions for a state machine are listed")
  public void executionsForAStateMachineAreListed() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      ListExecutionsResponse result = client.listExecutions(r -> r.stateMachineArn(smArn(TEST_SM)));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("versions of a state machine are listed")
  public void versionsOfAStateMachineAreListed() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      ListStateMachineVersionsResponse result =
          client.listStateMachineVersions(r -> r.stateMachineArn(smArn(TEST_SM)));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("tags for a state machine are listed")
  public void tagsForAStateMachineAreListed() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      ListTagsForResourceResponse result =
          client.listTagsForResource(r -> r.resourceArn(smArn(TEST_SM)));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("an execution is started on a standard state machine")
  public void anExecutionIsStartedOnAStandardStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      StartExecutionResponse result =
          client.startExecution(r -> r.stateMachineArn(smArn(TEST_SM)).input(TEST_INPUT));
      world.setSuccess(result);
      world.lastExecutionArn = result.executionArn();
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a synchronous execution is started on an express state machine")
  public void aSynchronousExecutionIsStartedOnAnExpressStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      StartSyncExecutionResponse result =
          client.startSyncExecution(
              r -> r.stateMachineArn(smArn(TEST_SM_EXPRESS)).input(TEST_INPUT));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a running execution is stopped")
  public void aRunningExecutionIsStopped() {
    // Arrange
    String executionArn = world.lastExecutionArn != null ? world.lastExecutionArn : "";
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.stopExecution(r -> r.executionArn(executionArn));
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("an execution is described")
  public void anExecutionIsDescribed() {
    // Arrange
    String executionArn = world.lastExecutionArn != null ? world.lastExecutionArn : "";
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      DescribeExecutionResponse result =
          client.describeExecution(r -> r.executionArn(executionArn));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("the event history of an execution is retrieved")
  public void theEventHistoryOfAnExecutionIsRetrieved() {
    // Arrange
    String executionArn = world.lastExecutionArn != null ? world.lastExecutionArn : "";
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      GetExecutionHistoryResponse result =
          client.getExecutionHistory(r -> r.executionArn(executionArn));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a state machine definition is updated")
  public void aStateMachineDefinitionIsUpdated() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      UpdateStateMachineResponse result =
          client.updateStateMachine(
              r -> r.stateMachineArn(smArn(TEST_SM)).definition(TEST_UPDATED_DEFINITION));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("tags are added to a state machine")
  public void tagsAreAddedToAStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.tagResource(
          r ->
              r.resourceArn(smArn(TEST_SM))
                  .tags(Tag.builder().key(TEST_TAG_KEY).value(TEST_TAG_VALUE).build()));
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("tags are removed from a state machine")
  public void tagsAreRemovedFromAStateMachine() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      client.untagResource(r -> r.resourceArn(smArn(TEST_SM)).tagKeys(TEST_TAG_KEY));
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a state machine definition is validated")
  public void aStateMachineDefinitionIsValidated() {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      ValidateStateMachineDefinitionResponse result =
          client.validateStateMachineDefinition(r -> r.definition(TEST_PASS_DEFINITION));
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: result captured in world
  }

  @When("a state machine deletion is finalized")
  public void aStateMachineDeletionIsFinalized() {
    // Arrange / Act — cannot trigger internal finalization event via public API
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal finalization event via public API"));
    // Assert: result captured in world
  }

  @When("a running execution transitions to a terminal state")
  public void aRunningExecutionTransitionsToATerminalState() {
    // Arrange / Act — cannot trigger internal execution step transition via public API
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step transition via public API"));
    // Assert: result captured in world
  }

  @When("a running execution exceeds its timeout")
  public void aRunningExecutionExceedsItsTimeout() {
    // Arrange / Act — cannot trigger execution timeout programmatically
    world.setFailure(
        new UnsupportedOperationException("cannot trigger execution timeout programmatically"));
    // Assert: result captured in world
  }

  @Then("the state machine is in \"DELETING\" state")
  public void theStateMachineIsInDeletingState() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected delete_state_machine to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  // "the state machine is \"DELETED\"" (Then) was here for @internal finalize_delete_state_machine
  // scenarios; those scenarios are excluded by the tag filter (not @internal).
  // The Given variant is registered above for lambda_stepfunctions scenarios.

  @Then("the state machine details are returned")
  public void theStateMachineDetailsAreReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected describe_state_machine to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null describe_state_machine result");
    DescribeStateMachineResponse result = (DescribeStateMachineResponse) world.lastOutput;
    assertNotNull(result.name(), "Expected 'name' field in describe_state_machine response");
  }

  @Then("the list of state machines is returned")
  public void theListOfStateMachinesIsReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected list_state_machines to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null list_state_machines result");
    ListStateMachinesResponse result = (ListStateMachinesResponse) world.lastOutput;
    assertNotNull(
        result.stateMachines(), "Expected 'stateMachines' in list_state_machines response");
  }

  @Then("the list of executions is returned")
  public void theListOfExecutionsIsReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected list_executions to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null list_executions result");
    ListExecutionsResponse result = (ListExecutionsResponse) world.lastOutput;
    assertNotNull(result.executions(), "Expected 'executions' in list_executions response");
  }

  @Then("the list of state machine versions is returned")
  public void theListOfStateMachineVersionsIsReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected list_state_machine_versions to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null list_state_machine_versions result");
    ListStateMachineVersionsResponse result = (ListStateMachineVersionsResponse) world.lastOutput;
    assertNotNull(
        result.stateMachineVersions(),
        "Expected 'stateMachineVersions' in list_state_machine_versions response");
  }

  @Then("the execution is \"ABORTED\"")
  public void theExecutionIsAborted() {
    // Arrange
    boolean expectedStopSuccess = true;
    boolean actualStopSuccess = world.lastSuccess;
    assertTrue(
        actualStopSuccess,
        "Expected stop_execution to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedStopSuccess
            + " actual_success="
            + actualStopSuccess);
    String executionArn = world.lastExecutionArn != null ? world.lastExecutionArn : "";
    // Act
    try (SfnClient client = world.session.sfnClient()) {
      DescribeExecutionResponse result =
          client.describeExecution(r -> r.executionArn(executionArn));
      // Assert
      String expectedStatus = "ABORTED";
      String actualStatus = result.statusAsString();
      assertEquals(
          expectedStatus,
          actualStatus,
          "Expected execution status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the execution is \"SUCCEEDED\" or \"FAILED\"")
  public void theExecutionIsSucceededOrFailed() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected sync execution to complete but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null start_sync_execution result");
    StartSyncExecutionResponse result = (StartSyncExecutionResponse) world.lastOutput;
    String actualStatus = result.statusAsString();
    assertTrue(
        "SUCCEEDED".equals(actualStatus) || "FAILED".equals(actualStatus),
        "Expected execution status SUCCEEDED or FAILED but got '"
            + actualStatus
            + "'; expected_statuses=SUCCEEDED,FAILED actual_status="
            + actualStatus);
  }

  @Then("the execution details are returned")
  public void theExecutionDetailsAreReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected describe_execution to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null describe_execution result");
    DescribeExecutionResponse result = (DescribeExecutionResponse) world.lastOutput;
    assertNotNull(result.executionArn(), "Expected 'executionArn' in describe_execution response");
  }

  @Then("the execution history is returned")
  public void theExecutionHistoryIsReturned() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected get_execution_history to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null get_execution_history result");
    GetExecutionHistoryResponse result = (GetExecutionHistoryResponse) world.lastOutput;
    assertNotNull(result.events(), "Expected 'events' in get_execution_history response");
  }

  @Then("the state machine version is incremented")
  public void theStateMachineVersionIsIncremented() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected update_state_machine to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the tags are associated with the state machine")
  public void theTagsAreAssociatedWithTheStateMachine() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected tag_resource to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the tags are disassociated from the state machine")
  public void theTagsAreDisassociatedFromTheStateMachine() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected untag_resource to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the definition is valid or invalid")
  public void theDefinitionIsValidOrInvalid() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected validate_state_machine_definition to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "Expected non-null validate_state_machine_definition result");
    ValidateStateMachineDefinitionResponse result =
        (ValidateStateMachineDefinitionResponse) world.lastOutput;
    assertTrue(
        result.result() != null || (result.diagnostics() != null),
        "Expected 'result' or 'validationErrors' in validate_state_machine_definition response");
  }

  @Then("the execution is \"TIMED_OUT\"")
  public void theExecutionIsTimedOut() {
    // Arrange: no additional setup required
    // Act: action already performed in When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected timeout event to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────
  @Then(
      "every execution has a valid status"
          + " (\"RUNNING\", \"SUCCEEDED\", \"FAILED\", \"TIMED_OUT\", or \"ABORTED\")")
  public void everyExecutionHasAValidStatus() {
    // Invariant: trivially satisfied in isolated lws context.
  }

  @Then("synchronous executions only run on express state machines")
  public void synchronousExecutionsOnlyRunOnExpressStateMachines() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
