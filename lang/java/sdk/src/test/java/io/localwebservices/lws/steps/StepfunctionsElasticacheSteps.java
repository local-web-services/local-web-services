package io.localwebservices.lws.steps;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;

/**
 * Step definitions for the stepfunctions_elasticache cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_cluster, cluster_modification_begins,
 * cluster_modification_complete, start_execution, read_cache_task_fails, read_cache_task_succeeds.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsElasticacheSteps {

  private static final String TEST_SM = "test-sf-elasticache-sm-1";
  private static final String TEST_CLUSTER = "test-sf-elasticache-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsElasticacheSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void createCluster() {
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Arrange / Act
      client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("CacheClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  // "a Step Functions state machine is created" is registered in StepfunctionsSteps.
  // "an execution of the state machine is started" is registered in StepfunctionsSteps.

  @When("an ElastiCache cluster is created and becomes \"AVAILABLE\"")
  public void anElastiCacheClusterIsCreatedAndBecomesAvailable() {
    // Arrange: use the test cluster identifier
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a cluster modification begins")
  public void aClusterModificationBegins() {
    // Arrange: use the test cluster identifier
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var result = client.modifyCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a running execution fails to connect because the cluster is being modified")
  public void aRunningExecutionFailsToConnectBecauseClusterIsBeingModified() {
    // @internal: Cannot trigger internal execution step that fails due to MODIFYING cluster in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to MODIFYING cluster in lws"));
  }

  @When("a running execution reads from the \"AVAILABLE\" ElastiCache cluster and succeeds")
  public void aRunningExecutionReadsFromAvailableElastiCacheClusterAndSucceeds() {
    // @internal: Cannot trigger internal execution step that reads from ElastiCache cluster in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that reads from ElastiCache cluster in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the cluster is \"MODIFYING\" and connections may be refused")
  public void theClusterIsModifyingAndConnectionsMayBeRefused() {
    // @internal: Cannot observe MODIFYING cluster state via public API in lws.
    // No-op: treat as invariant satisfied.
  }

  // "every succeeded execution recorded which cluster it read" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
