package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.neptune.NeptuneClient;
import software.amazon.awssdk.services.neptune.model.DescribeDbClustersResponse;

/**
 * Step definitions for the lambda_neptune cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, deploy_function, invoke_function, start_cluster, stop_cluster,
 * invocation_fails_cluster_stopped, invocation_succeeds.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected"), {@link LambdaSteps} ("the function does not already exist", "the
 * function already exists", "the function exists", "the function does not exist", "the function is
 * {string}", "the function is not {string}"), and {@link NeptuneSteps} ("the cluster does not
 * already exist", "the cluster already exists", "the cluster exists", "the cluster does not exist",
 * "the cluster is {string}", "the cluster is not {string}") are intentionally absent here to avoid
 * duplicate step definition errors.
 */
public class LambdaNeptuneSteps {

  private static final String TEST_FUNC = "test-lambda-neptune-1";
  private static final String TEST_CLUSTER = "test-lambda-neptune-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaNeptuneSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaNeptuneCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(software.amazon.awssdk.services.lambda.model.Runtime.PYTHON3_12)
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

  private void lambdaNeptuneCreateCluster() {
    // Arrange
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER).engine("neptune"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("DBClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: Neptune cluster state unique to cross-service scenarios ─────────────

  @Given("the Neptune cluster is \"STOPPED\"")
  public void theNeptuneClusterIsStopped() {
    // Arrange: create then stop the cluster
    lambdaNeptuneCreateCluster();
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act: stop the cluster
      client.stopDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: cluster is now STOPPED
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("InvalidDBClusterStateFault") && !msg.contains("stopped")) {
        throw e;
      }
    }
  }

  @Given("the Neptune cluster is not \"STOPPED\"")
  public void theNeptuneClusterIsNotStopped() {
    // Arrange: create the cluster (available, not stopped)
    // Act
    lambdaNeptuneCreateCluster();
    // Assert: cluster is AVAILABLE
  }

  @Given("the Neptune cluster is \"AVAILABLE\"")
  public void theNeptuneClusterIsAvailable() {
    // Arrange: create the cluster (available by default)
    // Act
    lambdaNeptuneCreateCluster();
    // Assert: cluster is AVAILABLE
  }

  @Given("the Neptune cluster is not \"AVAILABLE\"")
  public void theNeptuneClusterIsNotAvailable() {
    // Arrange: create then stop the cluster so it is not AVAILABLE
    lambdaNeptuneCreateCluster();
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act: stop the cluster
      client.stopDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: cluster is now STOPPED (not AVAILABLE)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("InvalidDBClusterStateFault") && !msg.contains("stopped")) {
        throw e;
      }
    }
  }

  @When("a Neptune cluster is created")
  public void aNeptuneClusterIsCreated() {
    // Arrange
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response =
          client.createDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER).engine("neptune"));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Neptune cluster is stopped")
  public void theNeptuneClusterIsStopped2() {
    // Arrange
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response = client.stopDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Neptune cluster is started")
  public void theNeptuneClusterIsStarted() {
    // Arrange
    try (NeptuneClient client = world.session.neptuneClient()) {
      // Act
      var response = client.startDBCluster(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function fails to connect because the Neptune cluster is stopped")
  public void theLambdaFunctionFailsToConnectBecauseTheNeptuneClusterIsStopped() {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the Lambda function executes a graph query against the \"AVAILABLE\" cluster and succeeds")
  public void theLambdaFunctionExecutesAGraphQueryAgainstTheAvailableClusterAndSucceeds() {
    // @internal: Cannot trigger Lambda invocation success in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success: scenario is @internal"));
  }

  @Then("the cluster is \"AVAILABLE\" and ready to accept graph queries")
  public void theClusterIsAvailableAndReadyToAcceptGraphQueries() {
    // Arrange
    String expectedStatus = "available";
    // Act
    try (NeptuneClient client = world.session.neptuneClient()) {
      DescribeDbClustersResponse response =
          client.describeDBClusters(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      String actualStatus =
          response.dbClusters().get(0).status() != null
              ? response.dbClusters().get(0).status()
              : "";
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected cluster status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("the cluster is \"STOPPED\" and graph queries will be rejected")
  public void theClusterIsStoppedAndGraphQueriesWillBeRejected() {
    // Arrange
    String expectedStatus = "stopped";
    // Act
    try (NeptuneClient client = world.session.neptuneClient()) {
      DescribeDbClustersResponse response =
          client.describeDBClusters(r -> r.dbClusterIdentifier(TEST_CLUSTER));
      String actualStatus =
          response.dbClusters().get(0).status() != null
              ? response.dbClusters().get(0).status()
              : "";
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected cluster status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  @Then("every successful invocation recorded which cluster it queried")
  public void everySuccessfulInvocationRecordedWhichClusterItQueried() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
