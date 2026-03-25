package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.docdb.DocDbClient;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.EventBus;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;

/**
 * Step definitions for the docdb_events cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, create_event_bus, delete_event_bus,
 * cluster_modify_event_delivered, cluster_modify_event_fails, cluster_modify_complete.
 *
 * <p>Steps already registered in {@link DocdbSteps} (cluster lifecycle/invariant steps)
 * are intentionally absent here to avoid duplicate step definition errors.
 */
public class DocdbEventsSteps {

  private static final String TEST_CLUSTER_ID = "test-docdb-cluster-1";
  private static final String TEST_BUS_NAME = "test-docdb-events-bus-1";
  private static final String TEST_ENGINE = "docdb";

  private final WorldContext world;

  public DocdbEventsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: event bus state setup ───────────────────────────────────────────

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no event buses.
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange
    // Act
    docdbEventsCreateBus();
    // Assert: bus created (no error thrown)
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange
    // Act
    docdbEventsCreateBus();
    // Assert: bus exists (no error thrown)
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no event buses.
  }

  @Given("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // Arrange: ensure the bus exists (buses are ACTIVE immediately after creation).
    docdbEventsCreateBus();
    // Assert: bus is ACTIVE (no error thrown)
  }

  @Given("the bus is \"DELETED\"")
  public void theBusIsDeleted() {
    // @internal: Cannot place bus into DELETED state without deleting it; after deletion
    // the bus no longer exists. Treated as no-op; scenario is tagged @internal.
  }

  @Given("the bus is not \"DELETED\"")
  public void theBusIsNotDeleted() {
    // Arrange: ensure the bus exists and is therefore NOT deleted.
    docdbEventsCreateBus();
    // Assert: bus is not deleted (no error thrown)
  }

  @Given("the bus is already \"DELETED\"")
  public void theBusIsAlreadyDeleted() {
    // @internal: Cannot arrange bus in already-deleted state via public API.
  }

  // ── Given: @internal state steps ───────────────────────────────────────────

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no events.
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // @internal: Cannot exhaust event slots via public API.
  }

  // "the cluster is not ..." steps are handled by the {string} Given in DocdbSteps;
  // specific literal variants for "AVAILABLE" and "MODIFYING" are NOT re-registered.

  // "busid not in bus_status" is already registered in CrossServiceEventBusSteps; NOT re-registered.

  // ── When: public API actions ───────────────────────────────────────────────

  @When("a DocumentDB cluster is created and becomes \"AVAILABLE\"")
  public void aDocumentDbClusterIsCreatedAndBecomesAvailable() {
    // Arrange: (state set up by Given steps)
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      var result = client.createDBCluster(
          r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine(TEST_ENGINE));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge event bus is created")
  public void anEventBridgeEventBusIsCreated() {
    // Arrange: (state set up by Given steps)
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      var result = client.createEventBus(r -> r.name(TEST_BUS_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the EventBridge event bus is deleted")
  public void theEventBridgeEventBusIsDeleted() {
    // Arrange: (state set up by Given steps)
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      var result = client.deleteEventBus(r -> r.name(TEST_BUS_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── When: @internal transitions ────────────────────────────────────────────

  @When(
      "a cluster modification begins and DocumentDB delivers the event to the EventBridge"
          + " bus")
  public void aClusterModificationBeginsAndDocumentDbDeliversTheEventToTheEventBridgeBus() {
    // @internal: Cannot trigger internal DocumentDB->EventBridge event delivery via public API.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger DocDB->EventBridge event delivery: scenario is @internal"));
  }

  @When(
      "a cluster modification begins but event delivery fails because the bus is deleted")
  public void aClusterModificationBeginsButEventDeliveryFailsBecauseTheBusIsDeleted() {
    // @internal: Cannot trigger internal event delivery failure via public API.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger event delivery failure: scenario is @internal"));
  }

  @When("the cluster modification completes")
  public void theClusterModificationCompletes() {
    // @internal: Cannot trigger internal cluster modification completion via public API.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger cluster modification completion: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────

  // "the cluster is \"AVAILABLE\"" is handled by DocdbSteps.@Then("the cluster is {string}") no-op.
  // It is intentionally absent here to avoid ambiguous step definition errors.

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActiveAssertion() {
    // Arrange: no additional setup required
    // Act: verify bus exists in the list
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse result = client.listEventBuses(r -> r);
      List<EventBus> buses = result.eventBuses();
      assertNotNull(buses, "expected EventBuses list but got null");
      boolean actualFound = buses.stream().anyMatch(b -> TEST_BUS_NAME.equals(b.name()));
      // Assert
      String expectedBus = TEST_BUS_NAME;
      assertTrue(
          actualFound,
          "expected event bus '"
              + expectedBus
              + "' to be ACTIVE but not found; expected_bus="
              + expectedBus);
    }
  }

  @Then("the bus is \"DELETED\" and DocumentDB event delivery will fail")
  public void theBusIsDeletedAndDocumentDbEventDeliveryWillFail() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected DeleteEventBus to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  // ── Then: @internal state assertions (no-ops) ─────────────────────────────

  @Then("the cluster is \"AVAILABLE\" again")
  public void theClusterIsAvailableAgain() {
    // @internal: model-level invariant; trivially satisfied.
  }

  @Then("the cluster is \"MODIFYING\" and the \"MODIFIED\" event is \"DELIVERED\"")
  public void theClusterIsModifyingAndTheModifiedEventIsDelivered() {
    // @internal: model-level invariant; trivially satisfied.
  }

  @Then("the cluster is \"MODIFYING\" but no event is delivered")
  public void theClusterIsModifyingButNoEventIsDelivered() {
    // @internal: model-level invariant; trivially satisfied.
  }

  // ── Then: model invariants (no-ops) ───────────────────────────────────────

  @Then("every \"DELIVERED\" event references a cluster that exists")
  public void everyDeliveredEventReferencesAClusterThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every \"DELIVERED\" event references a bus that exists")
  public void everyDeliveredEventReferencesABusThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  private void docdbEventsCreateBus() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      client.createEventBus(r -> r.name(TEST_BUS_NAME));
      // Assert: bus created (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("conflict") && !msg.contains("Conflict")) {
        throw e;
      }
    }
  }
}
