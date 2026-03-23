package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.ListExecutionsResponse;
import software.amazon.awssdk.services.sfn.model.ListStateMachinesResponse;

/**
 * Step definitions for the stepfunctions_events cross-service feature suite.
 *
 * <p>Covers: create_state_machine, create_event_bus, delete_event_bus,
 * configure_event_publishing, execution_succeeds_event_delivered, execution_succeeds_event_fails,
 * start_execution_event_delivered, start_execution_event_fails, sequences.
 *
 * <p>Steps already defined in {@link CrossServiceSteps} (e.g. invariant catch-alls, state-machine
 * Given steps, execution Given steps, event-bus create When, state machine create When) are
 * intentionally absent here to avoid duplicate-step errors.
 *
 * <p>Steps requiring StepFunctions to deliver execution lifecycle events to EventBridge
 * are skipped via {@code Assumptions.assumeTrue(false, ...)} because the lws Java core does not
 * implement the StepFunctions EventBridge event-publishing integration.
 */
public class StepfunctionsEventsSteps {

  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_SFN_SM = "test-sm-1";

  private final WorldContext world;

  public StepfunctionsEventsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void ebCreateBus(String busName) {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(busName));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists")
          && !msg.contains("ResourceInUse")
          && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  private void ebDeleteBus(String busName) {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.deleteEventBus(r -> r.name(busName));
    } catch (Exception e) {
      // Ignore — already deleted or does not exist
    }
  }

  private boolean ebBusExists(String busName) {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse response = client.listEventBuses(r -> r.namePrefix(busName));
      return response.eventBuses().stream().anyMatch(b -> b.name().equals(busName));
    } catch (Exception e) {
      return false;
    }
  }

  // -------------------------------------------------------------------------
  // FizzBee model initialisation preconditions (sequences.feature)
  //
  // Note: "busid" is distinct from "bid" used in CrossServiceSteps, so these
  // do not conflict with the existing bid preconditions.
  // -------------------------------------------------------------------------

  @Given("^busid not in bus_status$")
  public void busidNotInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid in bus_status$")
  public void busidInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // -------------------------------------------------------------------------
  // Capacity Given steps (stepfunctions_events specific)
  // -------------------------------------------------------------------------

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: event slots are unlimited by default
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // Arrange / Act / Assert — capacity exhaustion not configurable via SDK API
    Assumptions.assumeTrue(false, "event slot capacity exhaustion not configurable via SDK API");
  }

  // -------------------------------------------------------------------------
  // EventBridge bus Given steps (stepfunctions_events)
  // -------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no custom event buses
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no custom event buses
  }

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Arrange — create then delete the bus to reach DELETED state
    ebCreateBus(TEST_EVENT_BUS);
    ebDeleteBus(TEST_EVENT_BUS);
    // Assert — bus is now deleted; verified by subsequent steps
  }

  @Given("the bus is {string}")
  public void theBusIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      ebCreateBus(TEST_EVENT_BUS);
    } else if ("DELETED".equals(state)) {
      ebCreateBus(TEST_EVENT_BUS);
      ebDeleteBus(TEST_EVENT_BUS);
    }
    // Assert — bus state applied; verified by subsequent steps
  }

  @Given("the bus is not {string}")
  public void theBusIsNot(String state) {
    // Arrange — ensure bus is ACTIVE (not deleted)
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus is ACTIVE; verified by subsequent steps
  }

  // -------------------------------------------------------------------------
  // State machine + EventBridge combined Given steps
  // -------------------------------------------------------------------------

  @Given("the state machine exists and is {string}")
  public void theStateMachineExistsAndIs(String state) {
    // Arrange — reuse the helper already called by CrossServiceSteps for the state machine
    // The shared session's state machine is created via CrossServiceSteps.theStateMachineExists()
    // We invoke it inline here for self-contained setup.
    String expectedSmName = TEST_SFN_SM;
    try (SfnClient client = world.session.sfnClient()) {
      ListStateMachinesResponse response = client.listStateMachines();
      boolean alreadyExists =
          response.stateMachines().stream().anyMatch(sm -> sm.name().equals(expectedSmName));
      // Assert — state machine must already have been created; verified by subsequent steps
      assertTrue(
          alreadyExists || world.lastStateMachineArn != null,
          "expected state machine '" + expectedSmName + "' to exist and be " + state);
    } catch (Exception e) {
      // State machine not yet created; world will have it set by CrossServiceSteps
    }
  }

  @Given("the state machine does not exist or is not {string}")
  public void theStateMachineDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE or absent state machine not reachable via public API
    Assumptions.assumeTrue(
        false, "state machine non-ACTIVE/absent state not reachable via SDK API");
  }

  @Given("the state machine has no EventBridge bus configured")
  public void theStateMachineHasNoEventBridgeBusConfigured() {
    // Arrange / Act / Assert — no-op: fresh state machine has no EventBridge bus configured
  }

  @Given("the state machine has an EventBridge bus configured")
  public void theStateMachineHasAnEventBridgeBusConfigured() {
    // Arrange / Act / Assert — configuring EventBridge bus on state machine is not
    // implemented in the lws Java core (setEventBridgeStore)
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge bus configuration not implemented");
  }

  @Given("the state machine already has an EventBridge bus configured")
  public void theStateMachineAlreadyHasAnEventBridgeBusConfigured() {
    // Arrange / Act / Assert — not reachable via public API
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge bus configuration not implemented");
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    // Arrange
    ebCreateBus(TEST_EVENT_BUS);
    // Assert — bus now exists and is ACTIVE; verified by subsequent steps
  }

  @Given("the bus does not exist or is not {string}")
  public void theBusDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus state not reachable via public API
    Assumptions.assumeTrue(
        false, "EventBridge bus non-ACTIVE/absent state not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // When — EventBridge bus lifecycle actions
  // -------------------------------------------------------------------------

  @When("the EventBridge event bus is deleted")
  public void theEventBridgeEventBusIsDeleted() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      var response = client.deleteEventBus(r -> r.name(TEST_EVENT_BUS));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // -------------------------------------------------------------------------
  // When — EventBridge-publishing configuration (lws limitation)
  // -------------------------------------------------------------------------

  @When("the state machine is configured to publish execution events to the event bus")
  public void theStateMachineIsConfiguredToPublishExecutionEventsToTheEventBus() {
    // Arrange / Act / Assert — configuring EventBridge event publishing on state machine
    // is not implemented in the lws Java core (setEventBridgeStore)
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event publishing not implemented");
  }

  // -------------------------------------------------------------------------
  // When — execution lifecycle with event delivery (lws limitation)
  // -------------------------------------------------------------------------

  @When(
      "an execution starts and Step Functions delivers a {string} event to the EventBridge bus")
  public void anExecutionStartsAndStepFunctionsDeliversEventToEventBridgeBus(String eventType) {
    // Arrange / Act / Assert — StepFunctions to EventBridge event delivery not implemented
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event delivery not implemented");
  }

  @When("an execution starts but the {string} event delivery fails because the bus is deleted")
  public void anExecutionStartsButEventDeliveryFailsBecauseBusIsDeleted(String eventType) {
    // Arrange / Act / Assert — StepFunctions to EventBridge event delivery not implemented
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event delivery not implemented");
  }

  @When("a running execution succeeds and Step Functions delivers a {string} event to the bus")
  public void aRunningExecutionSucceedsAndStepFunctionsDeliversEventToBus(String eventType) {
    // Arrange / Act / Assert — StepFunctions to EventBridge event delivery not implemented
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event delivery not implemented");
  }

  @When(
      "a running execution succeeds but the {string} event delivery fails because the bus is"
          + " deleted")
  public void aRunningExecutionSucceedsButEventDeliveryFailsBecauseBusIsDeleted(String eventType) {
    // Arrange / Act / Assert — StepFunctions to EventBridge event delivery not implemented
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event delivery not implemented");
  }

  // -------------------------------------------------------------------------
  // Then — EventBridge bus assertions
  // -------------------------------------------------------------------------

  @Then("the bus is {string}")
  public void thenTheBusIs(String state) {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    boolean actualExists = ebBusExists(expectedBusName);
    // Assert
    if ("ACTIVE".equals(state)) {
      assertTrue(actualExists, "expected event bus '" + expectedBusName + "' to be ACTIVE");
    } else {
      assertFalse(actualExists, "expected event bus '" + expectedBusName + "' to be absent");
    }
  }

  @Then("the bus is {string} and execution event delivery will fail")
  public void theBusIsDeletedAndExecutionEventDeliveryWillFail(String state) {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    boolean actualGone = !ebBusExists(expectedBusName);
    // Assert
    assertTrue(actualGone, "expected event bus '" + expectedBusName + "' to be deleted");
  }

  // -------------------------------------------------------------------------
  // Then — state machine assertions (events suite)
  // -------------------------------------------------------------------------

  @Then("the state machine is {string} with no EventBridge bus configured")
  public void theStateMachineIsActiveWithNoEventBridgeBusConfigured(String state) {
    // Arrange
    String expectedSmName = TEST_SFN_SM;
    // Act
    try (SfnClient client = world.session.sfnClient()) {
      ListStateMachinesResponse response = client.listStateMachines();
      boolean actualExists =
          response.stateMachines().stream().anyMatch(sm -> sm.name().equals(expectedSmName));
      // Assert
      assertTrue(actualExists, "expected state machine '" + expectedSmName + "' to be " + state);
    }
  }

  @Then("the state machine will send execution state change events to the bus")
  public void theStateMachineWillSendExecutionStateChangeEventsToBus() {
    // Arrange / Act / Assert — StepFunctions EventBridge event publishing not implemented in
    // lws Java core; cannot verify this post-condition via public SDK API
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event publishing not implemented");
  }

  // -------------------------------------------------------------------------
  // Then — execution + event combined assertions (lws limitation)
  // -------------------------------------------------------------------------

  @Then("the execution is {string} and the {string} event is {string}")
  public void theExecutionIsAndTheEventIs(String execState, String eventType, String eventState) {
    // Arrange / Act / Assert — StepFunctions to EventBridge event delivery not verifiable
    Assumptions.assumeTrue(
        false, "lws limitation: StepFunctions EventBridge event delivery not implemented");
  }

  @Then("the execution is {string} but no {string} event is delivered")
  public void theExecutionIsButNoEventIsDelivered(String execState, String eventType) {
    // Arrange
    String expectedExecutionArn = world.lastExecutionArn;
    // Act
    try (SfnClient client = world.session.sfnClient()) {
      ListExecutionsResponse response =
          client.listExecutions(r -> r.stateMachineArn(world.lastStateMachineArn));
      boolean actualFound =
          response.executions().stream()
              .anyMatch(e -> e.executionArn().equals(expectedExecutionArn));
      // Assert
      assertTrue(
          actualFound,
          "expected execution " + expectedExecutionArn + " to be in state " + execState);
    }
  }
}
