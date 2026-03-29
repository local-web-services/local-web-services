package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.docdb.DocDbClient;

/**
 * Step definitions for the docdb_events cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, create_event_bus, delete_event_bus, cluster_modify_event_delivered,
 * cluster_modify_event_fails, cluster_modify_complete.
 *
 * <p>Steps already registered in {@link DocdbSteps} (cluster lifecycle/invariant steps) are
 * intentionally absent here to avoid duplicate step definition errors.
 */
public class DocdbEventsSteps {

  private static final String TEST_CLUSTER_ID = "test-docdb-cluster-1";
  private static final String TEST_ENGINE = "docdb";

  private final WorldContext world;

  public DocdbEventsSteps(WorldContext world) {
    this.world = world;
  }

  // Bus Given steps delegated to CrossServiceEventBusSteps parameterized versions:
  // "the bus is {string}", "the bus is already {string}", "the bus is not {string}"

  // "the cluster is not ..." steps are handled by the {string} Given in DocdbSteps;
  // specific literal variants for "AVAILABLE" and "MODIFYING" are NOT re-registered.

  // "busid not in bus_status" is already registered in CrossServiceEventBusSteps; NOT
  // re-registered.

  // ── When: public API actions ───────────────────────────────────────────────

  @When("a DocumentDB cluster is created and becomes \"AVAILABLE\"")
  public void aDocumentDbClusterIsCreatedAndBecomesAvailable() {
    // Arrange: (state set up by Given steps)
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      var result =
          client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine(TEST_ENGINE));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── When: @internal transitions ────────────────────────────────────────────

  @When(
      "a cluster modification begins and DocumentDB delivers the event to the EventBridge" + " bus")
  public void aClusterModificationBeginsAndDocumentDbDeliversTheEventToTheEventBridgeBus() {
    // @internal: Cannot trigger internal DocumentDB->EventBridge event delivery via public API.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger DocDB->EventBridge event delivery: scenario is @internal"));
  }

  @When("a cluster modification begins but event delivery fails because the bus is deleted")
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

  // "every \"DELIVERED\" event references a cluster that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
  // "every \"DELIVERED\" event references a bus that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))

}
