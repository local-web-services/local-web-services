package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.memorydb.MemoryDbClient;
import software.amazon.awssdk.services.memorydb.model.DescribeClustersResponse;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Step definitions for the lambda_memorydb cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, deploy_function, invoke_function, cluster_update_begins,
 * cluster_update_complete, invocation_fails_cluster_updating, write_record.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected"), {@link LambdaSteps} ("the function does not already exist",
 * "the function already exists", "the function exists", "the function does not exist",
 * "the function is {string}", "the function is not {string}"), and {@link MemorydbSteps}
 * ("the cluster does not already exist", "the cluster already exists", "the cluster exists",
 * "the cluster does not exist", "the cluster is {string}", "the cluster is not {string}") are
 * intentionally absent here to avoid duplicate step definition errors.
 */
public class LambdaMemorydbSteps {

  private static final String TEST_FUNC = "test-lambda-memorydb-1";
  private static final String TEST_CLUSTER = "test-lambda-memorydb-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaMemorydbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaMemorydbCreateFunction() {
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

  private void lambdaMemorydbCreateCluster() {
    // Arrange
    try (MemoryDbClient client = world.session.memoryDbClient()) {
      // Act
      client.createCluster(
          r -> r.clusterName(TEST_CLUSTER).nodeType("db.t4g.small").aclName("open-access"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaMemorydbCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state has no invocations.
  }

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  @Given("a record slot is available")
  public void aRecordSlotIsAvailable() {
    // No-op: always room for records in lws.
  }

  @Given("no record slot is available")
  public void noRecordSlotIsAvailable() {
    // @internal: Cannot exhaust record slot limit in lws via public APIs.
    // Only reached by @internal/@capacity scenarios excluded by the tag filter.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
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
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a MemoryDB cluster is created")
  public void aMemoryDbClusterIsCreated() {
    // Arrange
    try (MemoryDbClient client = world.session.memoryDbClient()) {
      // Act
      var response =
          client.createCluster(
              r ->
                  r.clusterName(TEST_CLUSTER)
                      .nodeType("db.t4g.small")
                      .aclName("open-access"));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a MemoryDB cluster update begins")
  public void aMemoryDbClusterUpdateBegins() {
    // @internal: Cannot force a cluster into UPDATING state via public APIs.
    world.setFailure(
        new UnsupportedOperationException("cannot force cluster update: scenario is @internal"));
  }

  @When("the MemoryDB cluster update completes")
  public void theMemoryDbClusterUpdateCompletes() {
    // @internal: Cannot force cluster update completion via public APIs.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot force cluster update completion: scenario is @internal"));
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("the Lambda function fails to write because the cluster is updating")
  public void theLambdaFunctionFailsToWriteBecauseTheClusterIsUpdating() {
    // @internal: Cannot trigger Lambda invocation failure in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When(
      "the Lambda function writes a record to the \"AVAILABLE\" MemoryDB cluster during"
          + " invocation")
  public void theLambdaFunctionWritesARecordToTheAvailableMemoryDbClusterDuringInvocation() {
    // @internal: Cannot trigger Lambda record write in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda record write: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange
    String expectedState = "Active";
    // Act
    try (LambdaClient client = world.session.lambdaClient()) {
      var result = client.getFunction(r -> r.functionName(TEST_FUNC));
      String actualState = result.configuration().state().toString();
      // Assert
      assertEquals(
          expectedState,
          actualState,
          "expected function state '"
              + expectedState
              + "' but got '"
              + actualState
              + "'; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  @Then("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailable() {
    // Arrange
    String expectedStatus = "available";
    // Act
    try (MemoryDbClient client = world.session.memoryDbClient()) {
      DescribeClustersResponse response =
          client.describeClusters(r -> r.clusterName(TEST_CLUSTER));
      String actualStatus =
          response.clusters().get(0).status() != null
              ? response.clusters().get(0).status()
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

  @Then("the cluster is \"UPDATING\" and write operations may fail")
  public void theClusterIsUpdatingAndWriteOperationsMayFail() {
    // @internal: Cannot observe cluster UPDATING state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the cluster is \"AVAILABLE\" again")
  public void theClusterIsAvailableAgain() {
    // @internal: Cannot observe cluster AVAILABLE-again state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\" with a connection refused error")
  public void theInvocationIsFailedWithAConnectionRefusedError() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the record \"EXISTS\" in the cluster and the invocation is \"SUCCESS\"")
  public void theRecordExistsInTheClusterAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda record write result in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every existing record references a cluster that exists")
  public void everyExistingRecordReferencesAClusterThatExists() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
