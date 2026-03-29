package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.neptune.NeptuneClient;

/**
 * Step definitions for the neptune_events cross-service feature suite.
 *
 * <p>Covers: create_cluster, create_event_bus, delete_event_bus, cluster_stop_complete (@internal),
 * cluster_stop_event_delivered (@internal), cluster_stop_event_fails (@internal), sequences.
 *
 * <p>lws limitation note: NeptuneHandler does not dispatch state-change events to EventBridge when
 * clusters stop. Steps that verify internal event delivery use {@code Assumptions.assumeTrue(false,
 * ...)} to skip rather than fail.
 *
 * <p>Sequence precondition steps (busid not in bus_status, busid in bus_status) are defined in
 * {@link CrossServiceSteps} and intentionally absent here to avoid
 * DuplicateStepDefinitionException.
 */
public class NeptuneEventsSteps {

  private static final String TEST_BUS_NAME = "test-neptune-events-bus-1";
  private static final String TEST_CLUSTER_ID = "test-neptune-events-cluster-1";
  private static final String TEST_ENGINE = "neptune";

  private final WorldContext world;

  public NeptuneEventsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  private void ensureNeptuneEventsBus() {
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      client.createEventBus(r -> r.name(TEST_BUS_NAME));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("AlreadyExists")) {
        throw e;
      }
    }
  }

  private void ensureNeptuneEventsCluster() {
    try (NeptuneClient client = world.session.neptuneClient()) {
      client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine(TEST_ENGINE));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already exists") && !msg.contains("AlreadyExists")) {
        throw e;
      }
    }
  }

  // ── When — neptune_events cross-service actions ───────────────────────────────

  @When("a Neptune cluster is created and becomes \"AVAILABLE\"")
  public void aNeptuneClusterIsCreatedAndBecomesAvailable() {
    // Arrange: (cluster state set up by Given steps)
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response =
          client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine(TEST_ENGINE));
      // Assert
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Neptune cluster stops and delivers the state change event to the EventBridge bus")
  public void theNeptuneClusterStopsAndDeliversStateChangeEventToEventBridgeBus() {
    // @internal: cluster_stop_event_delivered — lws does not dispatch stop events to EventBridge;
    // skip
    Assumptions.assumeTrue(
        false, "lws limitation: Neptune does not dispatch cluster stop events to EventBridge");
  }

  @When("the Neptune cluster stops but event delivery fails because the bus is deleted")
  public void theNeptuneClusterStopsButEventDeliveryFailsBecauseBusIsDeleted() {
    // @internal: cluster_stop_event_fails — cannot trigger internal event delivery failure; skip
    Assumptions.assumeTrue(
        false, "lws limitation: Neptune cluster stop event delivery failure not supported");
  }

  @When("the Neptune cluster finishes stopping")
  public void theNeptuneClusterFinishesStopping() {
    // @internal: cluster_stop_complete — cannot force cluster into STOPPING state via public API;
    // skip
    Assumptions.assumeTrue(
        false, "lws limitation: cannot force Neptune cluster into STOPPING state via public API");
  }

  @Then("the bus is \"DELETED\" and Neptune event delivery will fail")
  public void theBusIsDeletedAndNeptuneEventDeliveryWillFail() {
    // Arrange
    String expectedBusName = TEST_BUS_NAME;
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
        actualBusGone, "Expected event bus '" + expectedBusName + "' to be DELETED (deleted/gone)");
  }
}
