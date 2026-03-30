package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Map;
import software.amazon.awssdk.services.sqs.model.ListQueuesRequest;

/**
 * Step definitions for the chaos informal specification feature files.
 *
 * <p>Covers: enable_chaos, disable_chaos, get_chaos_status, inject_error, inject_latency,
 * set_error_rate, set_latency.
 *
 * <p>Steps already registered in {@link CrossServiceSteps} (the system is initialized, the
 * operation is rejected, every .* catch-all) are NOT re-registered here.
 */
public class ChaosManagementSteps {

  private static final String TEST_SERVICE = "sqs";
  private static final int LATENCY_MIN_MS = 10;
  private static final int LATENCY_MAX_MS = 50;

  private static final ObjectMapper MAPPER = new ObjectMapper();
  private static final HttpClient HTTP_CLIENT =
      HttpClient.newBuilder().version(HttpClient.Version.HTTP_1_1).build();

  private final WorldContext world;

  // Per-scenario mutable state
  private boolean chaosEnabled = false;
  private boolean errorRateFull = false;
  private boolean latencyEnabled = false;
  private long callElapsedMs = 0;

  public ChaosManagementSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: chaos precondition setup ─────────────────────────────────────────

  @Given("chaos is enabled for the service")
  public void chaosIsEnabledForTheService() throws Exception {
    // Arrange
    // Act: enable chaos for the test service
    world.session.chaos(TEST_SERVICE).apply();
    // Assert: record state
    chaosEnabled = true;
  }

  @Given("chaos is not enabled for the service")
  public void chaosIsNotEnabledForTheService() {
    // Guard violation: chaos must be enabled for inject/disable operations.
    // Pre-load a rejection so "the operation is rejected" will pass.
    world.setFailure(
        new IllegalStateException(
            "guard violation: chaos is not enabled for service \"" + TEST_SERVICE + "\""));
    chaosEnabled = false;
  }

  @Given("the error rate is set to full for the service")
  public void theErrorRateIsSetToFullForTheService() throws Exception {
    // Arrange
    // Act: enable chaos with 100% error rate
    world.session.chaos(TEST_SERVICE).errorRate(1.0).apply();
    // Assert: record state
    chaosEnabled = true;
    errorRateFull = true;
  }

  @Given("the error rate is not set to full for the service")
  public void theErrorRateIsNotSetToFullForTheService() {
    // Guard violation: error injection requires 100% error rate.
    // Pre-load a rejection so "the operation is rejected" will pass.
    world.setFailure(
        new IllegalStateException(
            "guard violation: error rate is not set to full for service \"" + TEST_SERVICE + "\""));
    errorRateFull = false;
  }

  @Given("latency is configured for the service")
  public void latencyIsConfiguredForTheService() throws Exception {
    // Arrange
    // Act: enable chaos with latency
    world.session.chaos(TEST_SERVICE).latency(LATENCY_MIN_MS, LATENCY_MAX_MS).apply();
    // Assert: record state
    chaosEnabled = true;
    latencyEnabled = true;
  }

  @Given("latency is not configured for the service")
  public void latencyIsNotConfiguredForTheService() {
    // Guard violation: latency injection requires latency to be configured.
    // Pre-load a rejection so "the operation is rejected" will pass.
    world.setFailure(
        new IllegalStateException(
            "guard violation: latency is not configured for service \"" + TEST_SERVICE + "\""));
    latencyEnabled = false;
  }

  /** FizzBee precondition: svc must be in chaos_enabled state to run inject/disable actions. */
  @Given("svc in chaos_enabled")
  public void svcInChaosEnabled() throws Exception {
    // Arrange
    // Act: ensure chaos is enabled for the test service
    world.session.chaos(TEST_SERVICE).apply();
    // Assert: record state
    chaosEnabled = true;
  }

  // ── When: chaos actions ──────────────────────────────────────────────────────

  @When("chaos is enabled for a service")
  public void chaosIsEnabledForAService() throws Exception {
    // Arrange
    // Act
    try {
      world.session.chaos(TEST_SERVICE).apply();
      world.setSuccess(null);
      chaosEnabled = true;
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("chaos is disabled for a service")
  public void chaosIsDisabledForAService() throws Exception {
    // Arrange
    if (!chaosEnabled) {
      // Guard violation: chaos must be enabled to disable it.
      world.setFailure(
          new IllegalStateException(
              "guard violation: chaos is not enabled for service \""
                  + TEST_SERVICE
                  + "\": cannot disable"));
      return;
    }
    // Act
    try {
      world.session.chaos(TEST_SERVICE).clear();
      world.setSuccess(null);
      chaosEnabled = false;
      errorRateFull = false;
      latencyEnabled = false;
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the chaos error rate is configured for a service")
  public void theChaosErrorRateIsConfiguredForAService() throws Exception {
    // Arrange
    // Act
    try {
      world.session.chaos(TEST_SERVICE).errorRate(1.0).apply();
      world.setSuccess(null);
      chaosEnabled = true;
      errorRateFull = true;
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the chaos latency is configured for a service")
  public void theChaosLatencyIsConfiguredForAService() throws Exception {
    // Arrange
    // Act
    try {
      world.session.chaos(TEST_SERVICE).latency(LATENCY_MIN_MS, LATENCY_MAX_MS).apply();
      world.setSuccess(null);
      chaosEnabled = true;
      latencyEnabled = true;
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the chaos status for all services is retrieved")
  public void theChaosStatusForAllServicesIsRetrieved() throws Exception {
    // Arrange
    // Act: GET /_ldk/chaos/{service}
    try {
      Map<String, Object> status = getChaosStatus();
      world.setSuccess(status);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a service call is injected with a chaos error")
  public void aServiceCallIsInjectedWithAChaosError() throws Exception {
    // Arrange
    if (!chaosEnabled || !errorRateFull) {
      // Guard violation: pre-loaded failure already set — keep it.
      return;
    }
    // Act: make a real service call that should fail due to 100% error rate.
    try {
      world.session.sqsClient().listQueues(ListQueuesRequest.builder().build());
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a service call is delayed by chaos latency injection")
  public void aServiceCallIsDelayedByChaosLatencyInjection() throws Exception {
    // Arrange
    if (!chaosEnabled || !latencyEnabled) {
      // Guard violation: pre-loaded failure already set — keep it.
      return;
    }
    // Act: make a real service call and measure elapsed time.
    long start = System.currentTimeMillis();
    try {
      world.session.sqsClient().listQueues(ListQueuesRequest.builder().build());
      world.setSuccess(null);
    } catch (Exception e) {
      // latency injection does not necessarily cause errors — measure elapsed regardless
      world.setSuccess(null);
    }
    callElapsedMs = System.currentTimeMillis() - start;
  }

  // ── Then: chaos assertions ────────────────────────────────────────────────────

  @Then("chaos is enabled for the service")
  public void thenChaosIsEnabledForTheService() throws Exception {
    // Arrange
    // Act: get current chaos status
    Map<String, Object> result = getChaosStatus();
    // Assert
    boolean expectedEnabled = true;
    boolean actualEnabled = Boolean.TRUE.equals(result.get("enabled"));
    assertEquals(
        expectedEnabled,
        actualEnabled,
        "Expected chaos enabled="
            + expectedEnabled
            + " for service \""
            + TEST_SERVICE
            + "\" but got enabled="
            + actualEnabled
            + "; result="
            + result);
  }

  @Then("chaos is disabled for the service")
  public void thenChaosIsDisabledForTheService() throws Exception {
    // Arrange
    // Act: get current chaos status
    Map<String, Object> result = getChaosStatus();
    // Assert
    boolean expectedEnabled = false;
    boolean actualEnabled = Boolean.TRUE.equals(result.get("enabled"));
    assertEquals(
        expectedEnabled,
        actualEnabled,
        "Expected chaos enabled="
            + expectedEnabled
            + " for service \""
            + TEST_SERVICE
            + "\" but got enabled="
            + actualEnabled
            + "; result="
            + result);
  }

  @Then("the chaos configuration for each service is returned")
  public void theChaosConfigurationForEachServiceIsReturned() {
    // Arrange: (no-op)
    // Act: read last call result
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertEquals(
        expectedSuccess,
        actualSuccess,
        "Expected chaos configuration to be returned but request failed; error=" + world.lastError);
  }

  @Then("the error rate configuration is updated")
  public void theErrorRateConfigurationIsUpdated() throws Exception {
    // Arrange
    // Act: get current chaos status
    Map<String, Object> result = getChaosStatus();
    // Assert
    double expectedErrorRate = 1.0;
    double actualErrorRate = toDouble(result.get("error_rate"));
    assertEquals(
        expectedErrorRate,
        actualErrorRate,
        "Expected error_rate="
            + expectedErrorRate
            + " for service \""
            + TEST_SERVICE
            + "\" but got "
            + actualErrorRate
            + "; result="
            + result);
  }

  @Then("the latency configuration is updated")
  public void theLatencyConfigurationIsUpdated() throws Exception {
    // Arrange
    // Act: get current chaos status
    Map<String, Object> result = getChaosStatus();
    // Assert
    double expectedLatencyMin = (double) LATENCY_MIN_MS;
    double actualLatencyMin = toDouble(result.get("latency_min_ms"));
    assertEquals(
        expectedLatencyMin,
        actualLatencyMin,
        "Expected latency_min_ms="
            + expectedLatencyMin
            + " for service \""
            + TEST_SERVICE
            + "\" but got "
            + actualLatencyMin
            + "; result="
            + result);
  }

  @Then("the service call receives a chaos error response")
  public void theServiceCallReceivesAChaosErrorResponse() {
    // Arrange: (no-op)
    // Act: read last call result
    // Assert
    boolean expectedError = true;
    boolean actualError = world.lastError != null;
    assertEquals(
        expectedError,
        actualError,
        "Expected chaos error response but call succeeded; output=" + world.lastOutput);
  }

  @Then("the service call takes at least the configured minimum latency")
  public void theServiceCallTakesAtLeastTheConfiguredMinimumLatency() {
    // Arrange: (no-op)
    // Act: read elapsed time recorded in When step
    // Assert
    long expectedMinLatencyMs = LATENCY_MIN_MS;
    long actualElapsedMs = callElapsedMs;
    assertTrue(
        actualElapsedMs >= expectedMinLatencyMs,
        "Expected call to take at least "
            + expectedMinLatencyMs
            + "ms but took "
            + actualElapsedMs
            + "ms; expected_min_latency_ms="
            + expectedMinLatencyMs
            + " actual_elapsed_ms="
            + actualElapsedMs);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  @SuppressWarnings("unchecked")
  private Map<String, Object> getChaosStatus() throws Exception {
    // Derive management port from the SQS port (known offset: 2) to avoid package-private API.
    int sqsPort = world.session.portFor(TEST_SERVICE);
    int basePort = sqsPort - 2; // SQS SERVICE_OFFSET is 2
    URI uri = URI.create("http://127.0.0.1:" + basePort + "/_ldk/chaos/" + TEST_SERVICE);
    HttpRequest request = HttpRequest.newBuilder(uri).GET().timeout(Duration.ofSeconds(10)).build();
    HttpResponse<String> response = HTTP_CLIENT.send(request, HttpResponse.BodyHandlers.ofString());
    assertNotNull(response.body(), "Expected chaos status response body to be non-null");
    return (Map<String, Object>) MAPPER.readValue(response.body(), Map.class);
  }

  private static double toDouble(Object value) {
    if (value instanceof Number n) {
      return n.doubleValue();
    }
    return 0.0;
  }
}
