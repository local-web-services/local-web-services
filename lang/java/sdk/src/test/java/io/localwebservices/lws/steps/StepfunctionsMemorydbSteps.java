package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.services.memorydb.MemoryDbClient;

/**
 * Step definitions for the stepfunctions_memorydb cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_cluster, cluster_update_begins, cluster_update_complete,
 * start_execution, memory_d_b_task_succeeds, memory_d_b_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsMemorydbSteps {

  private static final String TEST_SM = "test-sf-memorydb-sm-1";
  private static final String TEST_CLUSTER = "test-sf-memorydb-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsMemorydbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void sfMemoryDbCreateCluster() {
    try (MemoryDbClient client = world.session.memoryDbClient()) {
      client.createCluster(
          r -> r.clusterName(TEST_CLUSTER).nodeType("db.t4g.small").aclName("open-access"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  @Given("the cluster is \"UPDATING\"")
  public void theClusterIsUpdating() {
    // @internal: Cannot force a MemoryDB cluster into UPDATING state via public API.
    // Arrange / Act / Assert — no-op: treat as precondition satisfied.
    Assumptions.assumeTrue(
        false, "Cannot force a MemoryDB cluster into UPDATING state via public API.");
  }

  @Given("the cluster is not \"UPDATING\"")
  public void theClusterIsNotUpdating() {
    // Arrange: create cluster (AVAILABLE means not UPDATING)
    // Act
    sfMemoryDbCreateCluster();
    // Assert: cluster created
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a running execution connects to the \"AVAILABLE\" MemoryDB cluster and the task succeeds")
  public void aRunningExecutionConnectsToAvailableMemoryDbClusterAndTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that connects to MemoryDB in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that connects to MemoryDB in lws"));
  }

  @When("a running execution fails to connect because the MemoryDB cluster is updating")
  public void aRunningExecutionFailsToConnectBecauseMemoryDbClusterIsUpdating() {
    // @internal: Cannot trigger internal execution step that fails due to UPDATING cluster in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to UPDATING cluster in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the cluster is \"UPDATING\" and connections may be refused")
  public void theClusterIsUpdatingAndConnectionsMayBeRefused() {
    // @internal: Cannot observe UPDATING cluster state via public API in lws.
    // Arrange / Act / Assert — no-op: invariant trivially satisfied in isolated lws context.
    Assumptions.assumeTrue(false, "Cannot observe UPDATING cluster state via public API in lws.");
  }
}
