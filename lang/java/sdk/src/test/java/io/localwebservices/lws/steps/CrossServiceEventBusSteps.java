package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;

/**
 * Shared step definitions for EventBridge event bus preconditions and assertions.
 *
 * <p>These steps are common across multiple cross-service test suites: s3api_events,
 * secretsmanager_events, ssm_events, stepfunctions_events, events_dynamodb, events_stepfunctions.
 *
 * <p>Each suite's own Steps class handles service-specific steps only. All bus-lifecycle
 * Given/When/Then steps are consolidated here to avoid DuplicateStepDefinitionException.
 */
public class CrossServiceEventBusSteps {

  private static final String TEST_EVENT_BUS = "test-bus-1";

  private final WorldContext world;

  public CrossServiceEventBusSteps(WorldContext world) {
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

  private void ebDeleteBus() {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.deleteEventBus(r -> r.name(TEST_EVENT_BUS));
    } catch (Exception e) {
      // Ignore — already deleted or does not exist
    }
  }

  // -------------------------------------------------------------------------
  // FizzBee model initialisation preconditions (sequences.feature — no-op)
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
  // Given — bus existence state
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

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh session has no event buses
  }

  // -------------------------------------------------------------------------
  // Given — bus lifecycle state
  // -------------------------------------------------------------------------

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

  @Given("the bus is already {string}")
  public void theBusIsAlready(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus lifecycle state not reachable via public API; skip
    Assumptions.assumeTrue(
        false, "lws limitation: bus " + state + " lifecycle state not reachable via SDK API");
  }

  @Given("the bus is not {string}")
  public void theBusIsNot(String state) {
    // Arrange / Act / Assert — "not DELETED" means the bus is ACTIVE; ensure it exists
    if ("DELETED".equals(state)) {
      ebCreateBus();
    }
  }

  @Given("the bus exists and is {string}")
  public void theBusExistsAndIs(String state) {
    // Arrange
    ebCreateBus();
    // Assert — bus now exists and is ACTIVE; verified by subsequent steps
  }

  @Given("the bus does not exist or is not {string}")
  public void theBusDoesNotExistOrIsNot(String state) {
    // Arrange / Act / Assert — non-ACTIVE bus state not reachable via public SDK API; skip
    Assumptions.assumeTrue(false, "lws limitation: bus non-ACTIVE state not reachable via SDK API");
  }

  @Given("the bus does not exist or is {string}")
  public void theBusDoesNotExistOrIs(String state) {
    // Arrange / Act / Assert — DELETED bus state not reachable via public SDK API; skip
    Assumptions.assumeTrue(false, "lws limitation: bus DELETED state not reachable via SDK API");
  }

  // -------------------------------------------------------------------------
  // Given — event slot capacity
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
  // When — EventBridge bus lifecycle
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
}
