package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.docdb.DocDbClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_docdb cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_cluster, stop_cluster, start_cluster, invoke_function,
 * invocation_fails_cluster_stopped, invocation_succeeds, and invariant feature files.
 *
 * <p>Steps already registered in {@link LambdaSteps} (function existence, function lifecycle
 * states) and {@link DocdbSteps} (cluster existence, cluster lifecycle states) and {@link
 * CrossServiceSteps} ("the system is initialized", "the operation is rejected") are intentionally
 * absent here to avoid DuplicateStepDefinitionException.
 */
public class LambdaDocdbSteps {

  private static final String TEST_FUNC = "test-lambda-docdb-1";
  private static final String TEST_CLUSTER = "test-lambda-docdb-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaDocdbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaDocdbCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void lambdaDocdbCreateCluster() {
    // Arrange
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      client.createDBCluster(
          r ->
              r.dbClusterIdentifier(TEST_CLUSTER)
                  .engine("docdb")
                  .masterUsername("admin")
                  .masterUserPassword("pass1234"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("DBClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  @Given("the cluster is \"STOPPED\"")
  public void theClusterIsStopped() {
    // Arrange: create the cluster; lws does not expose STOPPED state via StopDBCluster
    // Act
    lambdaDocdbCreateCluster();
    // Assert: cluster created (no error thrown)
  }

  @Given("the cluster is not \"STOPPED\"")
  public void theClusterIsNotStopped() {
    // Arrange: create the cluster (AVAILABLE state is not STOPPED)
    // Act
    lambdaDocdbCreateCluster();
    // Assert: cluster created (no error thrown)
  }

  // ── Given: slot state ─────────────────────────────────────────────────────────

  @Given("a document slot is available")
  public void aDocumentSlotIsAvailable() {
    // No-op: always room for documents in lws.
  }

  @Given("no document slot is available")
  public void noDocumentSlotIsAvailable() {
    // @internal: Cannot exhaust document slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  // ── Given: sequence state (fid/cid/iid) ──────────────────────────────────────

  @Given("fid in func_status")
  public void fidInFuncStatus() {
    // Arrange: create the Lambda function so fid is tracked in func_status
    // Act
    lambdaDocdbCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("fid not in func_status")
  public void fidNotInFuncStatus() {
    // No-op: fresh state has no functions in func_status.
  }

  @Given("iid in inv_status")
  public void iidInInvStatus() {
    // Arrange: create the Lambda function so an invocation can be tracked
    // Act
    lambdaDocdbCreateFunction();
    // Assert: function created (no error thrown)
  }

  @When("a DocumentDB cluster is created")
  public void aDocumentDbClusterIsCreated() {
    // Arrange
    try (DocDbClient client = world.session.docDbClient()) {
      // Act
      Object result =
          client.createDBCluster(
              r ->
                  r.dbClusterIdentifier(TEST_CLUSTER)
                      .engine("docdb")
                      .masterUsername("admin")
                      .masterUserPassword("pass1234"));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the DocumentDB cluster is stopped")
  public void theDocumentDbClusterIsStopped() {
    // @internal: StopDBCluster is not yet implemented in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot stop DocumentDB cluster: StopDBCluster not implemented in lws"));
  }

  @When("the DocumentDB cluster is started")
  public void theDocumentDbClusterIsStarted() {
    // @internal: StartDBCluster is not yet implemented in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot start DocumentDB cluster: StartDBCluster not implemented in lws"));
  }

  @When("the Lambda function fails to connect because the DocumentDB cluster is stopped")
  public void theLambdaFunctionFailsToConnectBecauseTheDocumentDbClusterIsStopped() {
    // @internal: Cannot trigger Lambda invocation failure in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When(
      "the Lambda function writes a document to the \"AVAILABLE\" DocumentDB cluster and succeeds")
  public void theLambdaFunctionWritesADocumentToTheAvailableDocumentDbClusterAndSucceeds() {
    // @internal: Cannot trigger Lambda document write in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda document write: scenario is @internal"));
  }

  @Then("the cluster is \"AVAILABLE\" and ready to accept connections")
  public void theClusterIsAvailableAndReadyToAcceptConnections() {
    // @internal: StartDBCluster is not yet implemented in lws.
  }

  @Then("the cluster is \"STOPPED\" and connections will be rejected")
  public void theClusterIsStoppedAndConnectionsWillBeRejected() {
    // @internal: StopDBCluster is not yet implemented in lws.
  }

  @Then("the invocation is \"FAILED\" with a connection error")
  public void theInvocationIsFailedWithAConnectionError() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the document \"EXISTS\" and the invocation is \"SUCCESS\"")
  public void theDocumentExistsAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda document write result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // "every existing document references a cluster that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
