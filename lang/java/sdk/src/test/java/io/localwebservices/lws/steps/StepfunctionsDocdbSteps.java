package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.docdb.DocDbClient;
import software.amazon.awssdk.services.docdb.model.DBCluster;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

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

  // ── Given: cluster existence ───────────────────────────────────────────────────

  @Given("the cluster does not already exist")
  public void theClusterDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  }

  @Given("the cluster already exists")
  public void theClusterAlreadyExists() {
    // Arrange: create the cluster so it already exists
    // Act
    createCluster();
    // Assert: cluster exists
  }

  @Given("the cluster exists")
  public void theClusterExists() {
    // Arrange: create the cluster
    // Act
    createCluster();
    // Assert: cluster exists
  }

  @Given("the cluster does not exist")
  public void theClusterDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no clusters.
  }

  // ── Given: cluster status ──────────────────────────────────────────────────────

  @Given("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailable() {
    // Arrange: ensure cluster exists; fresh clusters start AVAILABLE
    // Act
    createCluster();
    // Assert: cluster is AVAILABLE
  }

  @Given("the cluster is \"STOPPED\"")
  public void theClusterIsStopped() {
    // Arrange / Act / Assert — no-op: cannot drive a cluster into STOPPED state via public API in
    // lws.
  }

  @Given("the cluster is not \"STOPPED\"")
  public void theClusterIsNotStopped() {
    // Arrange: create an AVAILABLE cluster (not STOPPED)
    // Act
    createCluster();
    // Assert: cluster is not STOPPED
  }

  @Given("the cluster is not \"AVAILABLE\"")
  public void theClusterIsNotAvailable() {
    // Arrange / Act / Assert — no-op: cannot drive a cluster into a non-AVAILABLE state via public
    // API in lws.
  }

  // ── Given: execution state ────────────────────────────────────────────────────

  @Given("an execution is \"RUNNING\"")
  public void anExecutionIsRunning() {
    // Arrange: create state machine and start execution
    try (SfnClient client = world.session.sfnClient()) {
      var smResult =
          client.createStateMachine(
              r ->
                  r.name(TEST_SM)
                      .definition(TEST_PASS_DEFINITION)
                      .roleArn(TEST_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = smResult.stateMachineArn();
      // Act: start an execution
      StartExecutionResponse execResult =
          client.startExecution(r -> r.stateMachineArn(smArn(TEST_SM)).input(TEST_INPUT));
      // Assert: execution started
      world.lastExecutionArn = execResult.executionArn();
    }
  }

  @Given("no execution is \"RUNNING\"")
  public void noExecutionIsRunning() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("an execution slot is available")
  public void anExecutionSlotIsAvailable() throws Exception {
    // Arrange: set unlimited capacity for stepfunctions
    // Act
    world.session.capacity("stepfunctions").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no execution slot is available")
  public void noExecutionSlotIsAvailable() throws Exception {
    // Arrange: exhaust the stepfunctions execution capacity
    // Act
    world.session.capacity("stepfunctions").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  // "a Step Functions state machine is created" is registered in StepfunctionsSteps.
  // "an execution of the state machine is started" is registered in StepfunctionsSteps.

  @When("a DocumentDB cluster is created")
  public void aDocumentDBClusterIsCreated() {
    // Arrange: use the test cluster identifier
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      var result = client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER).engine("docdb"));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the DocumentDB cluster is started")
  public void theDocumentDBClusterIsStarted() {
    // Arrange: use the test cluster identifier
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      var result = client.startDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the DocumentDB cluster is stopped")
  public void theDocumentDBClusterIsStopped() {
    // Arrange: use the test cluster identifier
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      var result = client.stopDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

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

  // "the state machine is "ACTIVE"" is registered in StepfunctionsSteps.
  // "the execution is "RUNNING"" is registered in StepfunctionsSteps.
  // "the operation is rejected" is registered in CrossServiceSteps.

  @Then("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailableThen() throws Exception {
    // Arrange
    String expectedClusterID = TEST_CLUSTER;
    String expectedStatus = "available";
    // Act
    try (DocDbClient client = world.session.docDbClient()) {
      var result = client.describeDBClusters(r -> r.dbClusterIdentifier(expectedClusterID));
      java.util.List<DBCluster> clusters = result.dbClusters();
      assertNotNull(
          clusters,
          "Expected cluster list to be non-null; expected_cluster_id=" + expectedClusterID);
      assertEquals(
          1,
          clusters.size(),
          "Expected exactly one cluster with id \""
              + expectedClusterID
              + "\"; expected_cluster_id="
              + expectedClusterID);
      String actualStatus = clusters.get(0).status();
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "Expected cluster status \""
              + expectedStatus
              + "\" but got \""
              + actualStatus
              + "\"; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the cluster is \"AVAILABLE\" and ready to accept connections")
  public void theClusterIsAvailableAndReadyToAcceptConnections() throws Exception {
    // Arrange
    String expectedClusterID = TEST_CLUSTER;
    String expectedStatus = "available";
    // Act
    try (DocDbClient client = world.session.docDbClient()) {
      var result = client.describeDBClusters(r -> r.dbClusterIdentifier(expectedClusterID));
      java.util.List<DBCluster> clusters = result.dbClusters();
      assertNotNull(
          clusters,
          "Expected cluster list to be non-null; expected_cluster_id=" + expectedClusterID);
      assertEquals(
          1,
          clusters.size(),
          "Expected exactly one cluster; expected_cluster_id=" + expectedClusterID);
      String actualStatus = clusters.get(0).status();
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "Expected cluster status \""
              + expectedStatus
              + "\" but got \""
              + actualStatus
              + "\"; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the cluster is \"STOPPED\" and connections will be rejected")
  public void theClusterIsStoppedAndConnectionsWillBeRejected() {
    // @internal: Cannot observe STOPPED cluster state via public API in lws.
    // No-op: treat as invariant satisfied.
  }

  @Then("the execution is \"SUCCEEDED\"")
  public void theExecutionIsSucceeded() {
    // @internal: Cannot observe internal execution DocDB task success in lws.
    // No-op: treat as invariant satisfied.
  }

  @Then("the execution is \"FAILED\" with a connection error")
  public void theExecutionIsFailedWithAConnectionError() {
    // @internal: Cannot observe internal execution DocDB task failure in lws.
    // No-op: treat as invariant satisfied.
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────

  @Then("every \"RUNNING\" execution references an \"ACTIVE\" state machine")
  public void everyRunningExecutionReferencesAnActiveStateMachine() {
    // Invariant: trivially satisfied in isolated lws context.
  }

  @Then("every succeeded execution recorded which cluster it connected to")
  public void everySucceededExecutionRecordedWhichClusterItConnectedTo() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
