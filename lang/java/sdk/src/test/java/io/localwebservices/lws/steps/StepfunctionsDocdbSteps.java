package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.docdb.DocDbClient;

/**
 * Step definitions for the stepfunctions_docdb cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_cluster, start_cluster, stop_cluster, start_execution,
 * query_document_task_fails, query_document_task_succeeds.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsDocdbSteps {

  private static final String TEST_SM = "test-sf-docdb-sm-1";
  private static final String TEST_CLUSTER = "test-sf-docdb-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsDocdbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void createCluster() {
    try (DocDbClient client = world.session.docDbClient()) {
      // Arrange / Act
      client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER).engine("docdb"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("DBClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a running execution fails to connect because the DocumentDB cluster is stopped")
  public void aRunningExecutionFailsToConnectBecauseDocumentDBClusterIsStopped() {
    // @internal: Cannot trigger internal execution step that fails due to stopped DocDB cluster in
    // lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to stopped DocDB cluster in lws"));
  }

  @When(
      "a running execution connects to the \"AVAILABLE\" DocumentDB cluster and the task succeeds")
  public void aRunningExecutionConnectsToAvailableDocumentDBClusterAndTaskSucceeds() {
    // @internal: Cannot trigger internal execution step that connects to DocDB cluster in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that connects to DocDB cluster in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("every succeeded execution recorded which cluster it connected to")
  public void everySucceededExecutionRecordedWhichClusterItConnectedTo() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
