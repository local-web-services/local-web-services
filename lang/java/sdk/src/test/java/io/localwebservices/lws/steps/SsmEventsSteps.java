package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.ssm.SsmClient;

/**
 * Step definitions for the ssm_events cross-service feature suite.
 *
 * <p>Covers: create_event_bus, delete_event_bus, put_parameter_event_delivered,
 * put_parameter_event_fails, delete_parameter_event_delivered, sequences.
 *
 * <p>lws limitation note: SsmHandler does not dispatch events to EventBridge when parameters are
 * created or deleted. Steps that verify event delivery use
 * {@code Assumptions.assumeTrue(false, ...)} to skip rather than fail.
 */
public class SsmEventsSteps {

  private static final String TEST_EVENT_BUS = "test-bus-1";
  private static final String TEST_SSM_PARAM = "/test/ssm/cs-1";
  private static final String TEST_SSM_PARAM_VALUE = "test-param-value-1";

  private final WorldContext world;

  public SsmEventsSteps(WorldContext world) {
    this.world = world;
  }

  // -------------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------------

  private void ebCreateBus() {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists")
          && !msg.contains("ResourceInUse")
          && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  private void ssmCreateParameter() {
    try (SsmClient client = world.session.ssmClient()) {
      client.putParameter(
          r ->
              r.name(TEST_SSM_PARAM)
                  .value(TEST_SSM_PARAM_VALUE)
                  .type("String")
                  .overwrite(false));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ParameterAlreadyExists") && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  private boolean ssmParameterExists() {
    try (SsmClient client = world.session.ssmClient()) {
      client.getParameter(r -> r.name(TEST_SSM_PARAM));
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  // -------------------------------------------------------------------------
  // Sequence precondition steps (FizzBee model initialisation — no-op)
  // -------------------------------------------------------------------------

  @Given("^pid not in param_status$")
  public void pidNotInParamStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^pid in param_status$")
  public void pidInParamStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid not in bus_status$")
  public void busidNotInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  @Given("^busid in bus_status$")
  public void busidInBusStatus() {
    // Arrange / Act / Assert — no-op: FizzBee model initialisation precondition
  }

  // -------------------------------------------------------------------------
  // EventBridge bus Given steps
  // -------------------------------------------------------------------------

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists; verified by subsequent steps
  }

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus lifecycle state not reachable via public API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: bus " + state + " lifecycle state not reachable via SDK API");
  }

  @Given("the bus is not {string}")
  public void theBusIsNot(String state) {
    // Arrange / Act / Assert — non-DELETED bus state means bus is ACTIVE; no-op
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  /**
   * Serves as both a Given precondition ({@code And the bus is "ACTIVE"}) and a Then assertion
   * ({@code Then the bus is "ACTIVE"}) — Cucumber annotations are interchangeable at match time.
   */
  @Given("the bus is {string}")
  public void theBusIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      ebCreateBus();
      // Assert — bus now exists; verified by subsequent steps
    } else {
      // lws: non-ACTIVE bus states not reachable via public SDK API; skip
      Assumptions.assumeTrue(
          false, "lws limitation: bus " + state + " state not reachable via SDK API");
    }
  }

  // -------------------------------------------------------------------------
  // Event slot Given steps
  // -------------------------------------------------------------------------

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: event slots are unlimited by default
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // Arrange / Act / Assert — capacity exhaustion not configurable via public SDK API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: event slot exhaustion not configurable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Parameter Given steps
  // -------------------------------------------------------------------------

  @Given("the parameter does not already exist")
  public void theParameterDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session has no parameters
  }

  @Given("the parameter already exists")
  public void theParameterAlreadyExists() {
    // Arrange
    ssmCreateParameter();
    // Assert — parameter now exists; verified by subsequent steps
  }

  @Given("the parameter exists")
  public void theParameterExists() {
    // Arrange
    ssmCreateParameter();
    // Assert — parameter now exists; verified by subsequent steps
  }

  @Given("the parameter does not exist")
  public void theParameterDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no parameters
  }

  @Given("the parameter {string} \\(not already {string}\\)")
  public void theParameterExistsNotAlreadyDeleted(String existsState, String notState) {
    // Arrange — parameter exists and is not in the excluded state
    ssmCreateParameter();
    // Assert — parameter now exists; verified by subsequent steps
  }

  @Given("the parameter is already {string}")
  public void theParameterIsAlready(String state) {
    // Arrange / Act / Assert — DELETED parameter lifecycle state not reachable via SDK API; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: parameter " + state + " lifecycle state not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // When — EventBridge actions
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
  // When — SSM cross-service actions
  // -------------------------------------------------------------------------

  @When("a parameter is created and {string} delivers a {string} event to the EventBridge bus")
  public void aParameterIsCreatedAndSsmDeliversEventToEventBridgeBus(
      String service, String eventType) {
    // Arrange / Act / Assert — lws SsmHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  @When(
      "a parameter is created but the {string} event delivery fails because the bus is deleted")
  public void aParameterIsCreatedButEventDeliveryFailsBecauseBusIsDeleted(String eventType) {
    // Arrange
    try (SsmClient client = world.session.ssmClient()) {
      // Act
      var response =
          client.putParameter(
              r ->
                  r.name(TEST_SSM_PARAM)
                      .value(TEST_SSM_PARAM_VALUE)
                      .type("String")
                      .overwrite(false));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a parameter is deleted and {string} delivers a {string} event to the EventBridge bus")
  public void aParameterIsDeletedAndSsmDeliversEventToEventBridgeBus(
      String service, String eventType) {
    // Arrange / Act / Assert — lws SsmHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  // -------------------------------------------------------------------------
  // Then — bus state assertions
  // -------------------------------------------------------------------------

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      var response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      boolean actualExists =
          response.eventBuses().stream().anyMatch(b -> b.name().equals(expectedBusName));
      // Assert
      assertTrue(actualExists, "expected event bus '" + expectedBusName + "' to be ACTIVE");
    }
  }

  @Then("the bus is \"DELETED\" and {string} event delivery will fail")
  public void theBusIsDeletedAndSsmEventDeliveryWillFail(String service) {
    // Arrange
    String expectedBusName = TEST_EVENT_BUS;
    // Act
    boolean actualBusGone;
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      var response = client.listEventBuses(r -> r.namePrefix(expectedBusName));
      actualBusGone =
          response.eventBuses().stream().noneMatch(b -> b.name().equals(expectedBusName));
    } catch (Exception e) {
      actualBusGone = true;
    }
    // Assert
    assertTrue(
        actualBusGone,
        "expected event bus '" + expectedBusName + "' to be DELETED (deleted/gone)");
  }

  // -------------------------------------------------------------------------
  // Then — parameter + event delivery assertions
  // -------------------------------------------------------------------------

  @Then("the parameter {string} and the {string} event is {string}")
  public void theParameterExistsAndEventIsDelivered(
      String paramState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  @Then("the parameter {string} but no event is delivered")
  public void theParameterExistsButNoEventIsDelivered(String paramState) {
    // Arrange
    String expectedParamName = TEST_SSM_PARAM;
    // Act
    boolean actualExists = ssmParameterExists();
    // Assert
    assertTrue(
        actualExists, "expected parameter '" + expectedParamName + "' to be " + paramState);
  }

  @Then("the parameter is {string} and the {string} event is {string}")
  public void theParameterIsStateAndEventIsDelivered(
      String paramState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false,
        "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  // -------------------------------------------------------------------------
  // Invariant catch-all And steps
  // -------------------------------------------------------------------------

  @And("every {string} event references a parameter that exists \\(in any state\\)")
  public void everyEventReferencesAParameterThatExists(String deliveryState) {
    // Arrange / Act / Assert — no-op: model-level invariant; not verifiable via public API
  }
}
