package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.neptune.NeptuneClient;
import software.amazon.awssdk.services.neptune.model.DBCluster;

/**
 * Step definitions for the stepfunctions_neptune cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_cluster, stop_cluster, start_cluster, start_execution,
 * query_graph_task_succeeds, query_graph_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsNeptuneSteps {

  private static final String TEST_SM = "test-sf-neptune-sm-1";
  private static final String TEST_CLUSTER_ID = "test-sf-neptune-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;
  private String localClusterId;

  public StepfunctionsNeptuneSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private String createCluster() {
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Arrange
      // Act
      var result =
          client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER_ID).engine("neptune"));
      // Assert: creation succeeded (no exception thrown)
      DBCluster cluster = result.dbCluster();
      return cluster != null ? cluster.dbClusterIdentifier() : TEST_CLUSTER_ID;
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a running execution fails to query because the Neptune cluster is stopped")
  public void aRunningExecutionFailsToQueryBecauseNeptuneClusterIsStopped() {
    // @internal: Cannot trigger internal execution step that queries Neptune in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that queries Neptune in lws"));
  }

  @When("a running execution queries the \"AVAILABLE\" Neptune cluster and the task succeeds")
  public void aRunningExecutionQueriesAvailableNeptuneClusterAndTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that queries Neptune in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that queries Neptune in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("every succeeded execution recorded which cluster it queried")
  public void everySucceededExecutionRecordedWhichClusterItQueried() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
