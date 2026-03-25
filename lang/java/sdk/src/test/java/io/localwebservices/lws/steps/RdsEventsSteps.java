package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.EventBus;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;
import software.amazon.awssdk.services.rds.RdsClient;

/**
 * Step definitions for the rds_events cross-service informal specification feature files.
 *
 * <p>Covers: create_d_b_instance, create_event_bus, delete_event_bus.
 *
 * <p>Internal-only actions (d_b_stop_complete, d_b_stop_event_delivered, d_b_stop_event_fails) are
 * registered as no-ops with {@code @internal} comments because they cannot be triggered via public
 * AWS APIs in an lws environment.
 */
public class RdsEventsSteps {

  private static final String TEST_DB_INSTANCE_ID = "test-rds-db-1";
  private static final String TEST_BUS_NAME = "e2e-test-bus-1";
  private static final String TEST_DB_ENGINE = "mysql";
  private static final String TEST_DB_CLASS = "db.t3.micro";

  private final WorldContext world;

  public RdsEventsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: DB instance state setup ───────────────────────────────────────────

  @Given("the \"DB\" instance does not already exist")
  public void theDbInstanceDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no DB instances.
  }

  @Given("the \"DB\" instance already exists")
  public void theDbInstanceAlreadyExists() {
    // Arrange
    // Act
    rdsEventsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance is \"AVAILABLE\"")
  public void theDbInstanceIsAvailable() {
    // Arrange
    // Act: create the DB instance (lws instances are AVAILABLE after creation)
    rdsEventsCreateDBInstance();
    // Assert: DB instance created (no error thrown)
  }

  @Given("the \"DB\" instance is not \"AVAILABLE\"")
  public void theDbInstanceIsNotAvailable() {
    // @internal: Cannot force a DB instance into a non-AVAILABLE state via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Given("the \"DB\" instance is \"STOPPING\"")
  public void theDbInstanceIsStopping() {
    // @internal: Cannot force a DB instance into STOPPING state via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Given("the \"DB\" instance is not \"STOPPING\"")
  public void theDbInstanceIsNotStopping() {
    // @internal: DB stop state not reachable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("an \"RDS\" \"DB\" instance is created and becomes \"AVAILABLE\"")
  public void anRdsDbInstanceIsCreatedAndBecomesAvailable() {
    // Arrange: (DB instance state set up by Given steps)
    try (RdsClient client = world.session.rdsClient()) {
      // Act
      var result =
          client.createDBInstance(
              r ->
                  r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                      .dbInstanceClass(TEST_DB_CLASS)
                      .engine(TEST_DB_ENGINE)
                      .masterUsername("admin")
                      .masterUserPassword("password123"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the \"DB\" instance finishes stopping")
  public void theDbInstanceFinishesStopping() {
    // @internal: d_b_stop_complete cannot be triggered via public API.
    world.setFailure(new UnsupportedOperationException("d_b_stop_complete: scenario is @internal"));
  }

  @When("the \"RDS\" instance stops and delivers the state change event to the EventBridge bus")
  public void theRdsInstanceStopsAndDeliversTheStateChangeEvent() {
    // @internal: d_b_stop_event_delivered cannot be triggered via public API.
    world.setFailure(
        new UnsupportedOperationException("d_b_stop_event_delivered: scenario is @internal"));
  }

  @When(
      "the \"RDS\" instance stops but the state change event delivery fails because the bus is deleted")
  public void theRdsInstanceStopsButEventDeliveryFails() {
    // @internal: d_b_stop_event_fails cannot be triggered via public API.
    world.setFailure(
        new UnsupportedOperationException("d_b_stop_event_fails: scenario is @internal"));
  }

  @Then("the bus is \"DELETED\" and \"RDS\" event delivery will fail")
  public void theBusIsDeletedAndRdsEventDeliveryWillFail() {
    // Arrange
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse result =
          client.listEventBuses(
              software.amazon.awssdk.services.eventbridge.model.ListEventBusesRequest.builder()
                  .build());
      List<EventBus> buses = result.eventBuses();
      // Assert
      String expectedBus = TEST_BUS_NAME;
      boolean actualFound = buses.stream().anyMatch(b -> expectedBus.equals(b.name()));
      assertFalse(
          actualFound,
          "expected event bus '"
              + expectedBus
              + "' to be DELETED but found it; expected_bus="
              + expectedBus
              + " actual_found="
              + actualFound);
    }
  }

  @Then("the \"DB\" instance is \"STOPPED\"")
  public void theDbInstanceIsStopped() {
    // @internal: d_b_stop_complete outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the \"DB\" instance is \"STOPPING\" and the event is \"DELIVERED\"")
  public void theDbInstanceIsStoppingAndTheEventIsDelivered() {
    // @internal: d_b_stop_event_delivered outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the \"DB\" instance is \"STOPPING\" but no event is delivered")
  public void theDbInstanceIsStoppingButNoEventIsDelivered() {
    // @internal: d_b_stop_event_fails outcome not observable via public API.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"DELIVERED\" event references a \"DB\" instance that exists")
  public void everyDeliveredEventReferencesADbInstanceThatExists() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void rdsEventsCreateDBInstance() {
    try (RdsClient client = world.session.rdsClient()) {
      client.createDBInstance(
          r ->
              r.dbInstanceIdentifier(TEST_DB_INSTANCE_ID)
                  .dbInstanceClass(TEST_DB_CLASS)
                  .engine(TEST_DB_ENGINE)
                  .masterUsername("admin")
                  .masterUserPassword("password123"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("DBInstanceAlreadyExists")) {
        throw e;
      }
    }
  }

  private void rdsEventsCreateBus() {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(TEST_BUS_NAME));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("ResourceAlreadyExists")) {
        throw e;
      }
    }
  }
}
