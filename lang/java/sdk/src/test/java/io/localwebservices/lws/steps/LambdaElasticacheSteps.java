package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_elasticache cross-service informal specification feature files.
 *
 * <p>Covers: create_cluster, deploy_function, invoke_function, cache_write, cache_evict,
 * invocation_fails_cache_miss, invocation_succeeds_cache_hit.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} ("the system is initialized", "the
 * operation is rejected") are intentionally absent here to avoid duplicate step definition errors.
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

  // ── Given: cache entry state ───────────────────────────────────────────────────

  @Given("a \"CACHED\" entry exists")
  public void aCachedEntryExists() {
    // @internal: cache entry state requires background processing.
    Assumptions.assumeTrue(false, "cache entry state requires background processing.");
  }

  @Given("no \"CACHED\" entry exists")
  public void noCachedEntryExists() {
    // Arrange / Act / Assert — no-op: fresh state has no cached entries.
  }

  @Given("a \"CACHED\" entry exists in the cluster")
  public void aCachedEntryExistsInTheCluster() {
    // @internal: cache entry state requires background Lambda invocation.
    Assumptions.assumeTrue(false, "cache entry state requires background Lambda invocation.");
  }

  @Given("no \"CACHED\" entries exist in the cluster")
  public void noCachedEntriesExistInTheCluster() {
    // Arrange / Act / Assert — no-op: fresh state has no cached entries.
  }

  // ── Given: capacity ────────────────────────────────────────────────────────────

  @Given("a key slot is available")
  public void aKeySlotIsAvailable() {
    // Arrange / Act / Assert — no-op: key slots are always available in lws.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: key slots are always available in lws.");
  }

  @Given("no key slot is available")
  public void noKeySlotIsAvailable() {
    // @internal: Cannot exhaust key slot limit in lws via public APIs.
    Assumptions.assumeTrue(false, "Cannot exhaust key slot limit in lws via public APIs.");
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
        new UnsupportedOperationException("cannot trigger cache eviction: scenario is @internal"));
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

  @Then("the cache entry is \"CACHED\" in the cluster")
  public void theCacheEntryIsCachedInTheCluster() {
    // @internal: Cannot observe cache entry state in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot observe cache entry state in lws.");
  }

  @Then("the cache entry is \"EVICTED\"")
  public void theCacheEntryIsEvicted() {
    // @internal: Cannot observe cache eviction in lws.
    // Only reached by @internal scenarios excluded by the tag filter.
    Assumptions.assumeTrue(false, "Cannot observe cache eviction in lws.");
  }

  // "every \"CACHED\" entry belongs to an \"AVAILABLE\" cluster" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
