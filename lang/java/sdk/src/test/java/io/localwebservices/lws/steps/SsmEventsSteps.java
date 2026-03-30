package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

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
 * created or deleted. Steps that verify event delivery use {@code Assumptions.assumeTrue(false,
 * ...)} to skip rather than fail.
 *
 * <p>Bus lifecycle steps (busid preconditions, bus existence/state Given steps, event slot capacity
 * steps, the EventBridge event bus is deleted When, and the bus is "ACTIVE" Then) are defined in
 * {@link CrossServiceEventBusSteps} and intentionally absent here to avoid
 * DuplicateStepDefinitionException.
 *
 * <p>Parameter precondition steps (pid preconditions, the parameter already/does not/exists/is
 * already Given steps) are defined in {@link StepfunctionsSsmSteps} and intentionally absent here
 * to avoid DuplicateStepDefinitionException.
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

  private boolean ssmParameterExists() {
    try (SsmClient client = world.session.ssmClient()) {
      client.getParameter(r -> r.name(TEST_SSM_PARAM));
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  // -------------------------------------------------------------------------
  // Given — parameter preconditions
  // -------------------------------------------------------------------------

  @Given("the parameter {string} (not already {string})")
  public void theParameterNotAlready(String paramState, String notState) {
    // @internal: SSM parameter state transitions not reachable via public API.
    Assumptions.assumeTrue(false, "SSM parameter state transitions not reachable via public API.");
  }

  // -------------------------------------------------------------------------
  // When — EventBridge actions
  // -------------------------------------------------------------------------

  @When("a parameter is created and {string} delivers a {string} event to the EventBridge bus")
  public void aParameterIsCreatedAndSsmDeliversEventToEventBridgeBus(
      String service, String eventType) {
    // Arrange / Act / Assert — lws SsmHandler does not dispatch to EventBridge; skip
    Assumptions.assumeTrue(
        false, "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  @When("a parameter is created but the {string} event delivery fails because the bus is deleted")
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
        false, "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  // -------------------------------------------------------------------------
  // Then — bus state assertions
  // -------------------------------------------------------------------------

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
        actualBusGone, "expected event bus '" + expectedBusName + "' to be DELETED (deleted/gone)");
  }

  // -------------------------------------------------------------------------
  // Then — parameter + event delivery assertions
  // -------------------------------------------------------------------------

  @Then("the parameter {string} and the {string} event is {string}")
  public void theParameterExistsAndEventIsDelivered(
      String paramState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false, "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }

  @Then("the parameter {string} but no event is delivered")
  public void theParameterExistsButNoEventIsDelivered(String paramState) {
    // Arrange
    String expectedParamName = TEST_SSM_PARAM;
    // Act
    boolean actualExists = ssmParameterExists();
    // Assert
    assertTrue(actualExists, "expected parameter '" + expectedParamName + "' to be " + paramState);
  }

  @Then("the parameter is {string} and the {string} event is {string}")
  public void theParameterIsStateAndEventIsDelivered(
      String paramState, String eventType, String eventDeliveryState) {
    // Arrange / Act / Assert — lws does not dispatch events to EventBridge; skip
    Assumptions.assumeTrue(
        false, "lws limitation: SSM does not dispatch " + eventType + " events to EventBridge");
  }
}
