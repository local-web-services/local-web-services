package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.memorydb.MemoryDbClient;

/**
 * Step definitions for the lambda_memorydb cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, deploy_function, invoke_function, cluster_update_begins,
 * cluster_update_complete, invocation_fails_cluster_updating, write_record.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected"), {@link LambdaSteps} ("the function does not already exist", "the
 * function already exists", "the function exists", "the function does not exist", "the function is
 * {string}", "the function is not {string}"), and {@link MemorydbSteps} ("the cluster does not
 * already exist", "the cluster already exists", "the cluster exists", "the cluster does not exist",
 * "the cluster is {string}", "the cluster is not {string}") are intentionally absent here to avoid
 * duplicate step definition errors.
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

  @Then("the cluster is \"UPDATING\" and write operations may fail")
  public void theClusterIsUpdatingAndWriteOperationsMayFail() {
    // @internal: Cannot observe cluster UPDATING state in lws.
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

  // "every existing record references a cluster that exists" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
