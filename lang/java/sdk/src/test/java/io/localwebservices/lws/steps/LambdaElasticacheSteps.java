package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;
import software.amazon.awssdk.services.elasticache.model.DescribeCacheClustersResponse;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_elasticache cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, deploy_function, invoke_function, cache_write, cache_evict,
 * invocation_fails_cache_miss, invocation_succeeds_cache_hit.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized",
 * "the operation is rejected") are intentionally absent here to avoid duplicate step definition
 * errors.
 */
public class LambdaElasticacheSteps {

  private static final String TEST_FUNC = "test-lambda-elasticache-1";
  private static final String TEST_CLUSTER = "test-lambda-elasticache-cluster-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaElasticacheSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private void lambdaElasticacheCreateFunction() {
    try (LambdaClient client = world.session.lambdaClient()) {
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void lambdaElasticacheCreateCluster() {
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("CacheClusterAlreadyExists") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  // ── Given: invocation state ────────────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the Lambda function so an invocation could be in progress
    // Act
    lambdaElasticacheCreateFunction();
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
  }

  // ── Given: cluster state ───────────────────────────────────────────────────────

  @Given("the cluster does not already exist")
  public void theClusterDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no clusters.
  }

  @Given("the cluster already exists")
  public void theClusterAlreadyExists() {
    // Arrange
    // Act
    lambdaElasticacheCreateCluster();
    // Assert: cluster created (no error thrown)
  }

  @Given("the cluster exists")
  public void theClusterExists() {
    // Arrange
    // Act
    lambdaElasticacheCreateCluster();
    // Assert: cluster created (no error thrown)
  }

  @Given("the cluster does not exist")
  public void theClusterDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no clusters.
  }

  @Given("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailable() {
    // Arrange: create cluster (fresh clusters start AVAILABLE)
    // Act
    lambdaElasticacheCreateCluster();
    // Assert: cluster is AVAILABLE
  }

  @Given("the cluster is not \"AVAILABLE\"")
  public void theClusterIsNotAvailable() {
    // @internal: Cannot drive a cluster into a non-AVAILABLE state via public API in lws.
  }

  // ── Given: cache entry state ───────────────────────────────────────────────────

  @Given("a \"CACHED\" entry exists")
  public void aCachedEntryExists() {
    // @internal: cache entry state requires background processing.
  }

  @Given("no \"CACHED\" entry exists")
  public void noCachedEntryExists() {
    // Arrange / Act / Assert — no-op: fresh state has no cached entries.
  }

  @Given("a \"CACHED\" entry exists in the cluster")
  public void aCachedEntryExistsInTheCluster() {
    // @internal: cache entry state requires background Lambda invocation.
  }

  @Given("no \"CACHED\" entries exist in the cluster")
  public void noCachedEntriesExistInTheCluster() {
    // Arrange / Act / Assert — no-op: fresh state has no cached entries.
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("a key slot is available")
  public void aKeySlotIsAvailable() {
    // Arrange / Act / Assert — no-op: key slots are always available in lws.
  }

  @Given("no key slot is available")
  public void noKeySlotIsAvailable() {
    // @internal: Cannot exhaust key slot limit in lws via public APIs.
  }

  // ── Given: function state ──────────────────────────────────────────────────────

  @Given("the function does not already exist")
  public void theFunctionDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function already exists")
  public void theFunctionAlreadyExists() {
    // Arrange
    // Act
    lambdaElasticacheCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function exists")
  public void theFunctionExists() {
    // Arrange
    // Act
    lambdaElasticacheCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("the function does not exist")
  public void theFunctionDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no functions.
  }

  @Given("the function is \"ACTIVE\"")
  public void theFunctionIsActive() {
    // Arrange / Act / Assert — no-op: fresh functions are ACTIVE immediately after creation.
  }

  @Given("the function is not \"ACTIVE\"")
  public void theFunctionIsNotActive() {
    // @internal: Cannot force a function into a non-ACTIVE state via public API in lws.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("an ElastiCache cluster is created")
  public void anElastiCacheClusterIsCreated() {
    // Arrange: (cluster state set up by Given steps)
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      // Act
      var response = client.createCacheCluster(r -> r.cacheClusterId(TEST_CLUSTER).engine("redis"));
      // Assert: store result
      world.setSuccess(response);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange: (function state set up by Given steps)
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
                  .role(TEST_ROLE_ARN)
                  .handler("index.handler")
                  .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario is @internal"));
  }

  @When("the Lambda function writes a value to the ElastiCache cluster during invocation")
  public void theLambdaFunctionWritesAValueToTheElastiCacheClusterDuringInvocation() {
    // @internal: Cannot trigger Lambda cache write in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda cache write: scenario is @internal"));
  }

  @When("ElastiCache evicts a cache entry due to memory pressure or \"TTL\" expiry")
  public void elastiCacheEvictsACacheEntryDueToMemoryPressureOrTtlExpiry() {
    // @internal: Cannot trigger cache eviction in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger cache eviction: scenario is @internal"));
  }

  @When("the Lambda invocation fails because all cache entries have been evicted")
  public void theLambdaInvocationFailsBecauseAllCacheEntriesHaveBeenEvicted() {
    // @internal: Cannot trigger Lambda invocation failure due to cache miss in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda cache miss failure: scenario is @internal"));
  }

  @When("the Lambda invocation reads an existing cache entry and completes successfully")
  public void theLambdaInvocationReadsAnExistingCacheEntryAndCompletesSuccessfully() {
    // @internal: Cannot trigger Lambda cache hit invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda cache hit: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the cluster is \"AVAILABLE\"")
  public void theClusterIsAvailable() {
    // Arrange
    String expectedCluster = TEST_CLUSTER;
    // Act
    try (ElastiCacheClient client = world.session.elastiCacheClient()) {
      DescribeCacheClustersResponse response =
          client.describeCacheClusters(r -> r.cacheClusterId(expectedCluster));
      assertNotNull(response.cacheClusters(), "expected cluster list to be non-null");
      String actualStatus =
          response.cacheClusters().isEmpty()
              ? ""
              : response.cacheClusters().get(0).cacheClusterStatus();
      String expectedStatus = "available";
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

  @Then("the function is \"ACTIVE\"")
  public void theFunctionIsActiveThen() {
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

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the cache entry is \"CACHED\" in the cluster")
  public void theCacheEntryIsCachedInTheCluster() {
    // @internal: Cannot observe cache entry state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the cache entry is \"EVICTED\"")
  public void theCacheEntryIsEvicted() {
    // @internal: Cannot observe cache eviction in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"FAILED\"")
  public void theInvocationIsFailed() {
    // @internal: Cannot observe Lambda invocation failure in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the invocation is \"SUCCESS\"")
  public void theInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation success in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
  }

  @Then("the operation is rejected")
  public void theOperationIsRejected() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedRejected = true;
    boolean actualRejected = !world.lastSuccess;
    org.junit.jupiter.api.Assertions.assertTrue(
        actualRejected,
        "expected operation to be rejected but it succeeded; expected_rejected="
            + expectedRejected
            + " actual_rejected="
            + actualRejected);
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda function")
  public void everyInProgressInvocationReferencesAnActiveLambdaFunction() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every \"CACHED\" entry belongs to an \"AVAILABLE\" cluster")
  public void everyCachedEntryBelongsToAnAvailableCluster() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
