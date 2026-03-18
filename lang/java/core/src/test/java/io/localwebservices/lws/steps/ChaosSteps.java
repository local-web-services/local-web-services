package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.cli.LwsCli;
import java.util.Map;

public class ChaosSteps {

  private final WorldContext world;

  public ChaosSteps(WorldContext world) {
    this.world = world;
  }

  @Given("chaos was enabled for {string}")
  public void chaosWasEnabledFor(String service) throws Exception {
    LwsCli.chaosEnable(world.managementPort(), service);
  }

  @Given("chaos was configured for {string} with full error rate")
  public void chaosWasConfiguredForWithFullErrorRate(String service) throws Exception {
    LwsCli.chaosSet(world.managementPort(), service, 1.0, 0, 0);
  }

  @Given("chaos was configured for {string} with 200ms latency")
  public void chaosWasConfiguredForWith200msLatency(String service) throws Exception {
    LwsCli.chaosSet(world.managementPort(), service, 0, 200, 200);
  }

  @Given("chaos was cleaned up for {string}")
  public void chaosWasCleanedUpFor(String service) throws Exception {
    LwsCli.chaosDisable(world.managementPort(), service);
  }

  @When("I enable chaos for {string}")
  public void iEnableChaosFor(String service) {
    try {
      LwsCli.chaosEnable(world.managementPort(), service);
      world.setSuccess(Map.of("status", "enabled"));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I disable chaos for {string}")
  public void iDisableChaosFor(String service) {
    try {
      LwsCli.chaosDisable(world.managementPort(), service);
      world.setSuccess(Map.of("status", "disabled"));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I set chaos for {string} with error rate {double}")
  public void iSetChaosForWithErrorRate(String service, double errorRate) {
    try {
      LwsCli.chaosSet(world.managementPort(), service, errorRate, 0, 0);
      world.setSuccess(Map.of("status", "configured", "errorRate", errorRate));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I set chaos for {string} with latency min {int} and max {int}")
  public void iSetChaosForWithLatencyMinAndMax(String service, int latencyMin, int latencyMax) {
    try {
      LwsCli.chaosSet(world.managementPort(), service, 0, latencyMin, latencyMax);
      world.setSuccess(
          Map.of("status", "configured", "latencyMin", latencyMin, "latencyMax", latencyMax));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I request chaos status")
  public void iRequestChaosStatus() {
    try {
      world.setSuccess(LwsCli.chaosStatus(world.managementPort()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("chaos for {string} will be enabled")
  public void chaosForWillBeEnabled(String service) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    @SuppressWarnings("unchecked")
    Map<String, Object> serviceStatus = (Map<String, Object>) status.get(service);
    assertTrue(
        Boolean.TRUE.equals(serviceStatus != null ? serviceStatus.get("enabled") : null),
        "Expected chaos to be enabled for " + service + ", got: " + serviceStatus);
  }

  @Then("chaos for {string} will be disabled")
  public void chaosForWillBeDisabled(String service) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    @SuppressWarnings("unchecked")
    Map<String, Object> serviceStatus = (Map<String, Object>) status.get(service);
    assertFalse(
        Boolean.TRUE.equals(serviceStatus != null ? serviceStatus.get("enabled") : null),
        "Expected chaos to be disabled for " + service + ", got: " + serviceStatus);
  }

  @Then("chaos for {string} will have error rate {double}")
  public void chaosForWillHaveErrorRate(String service, double expectedErrorRate) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    @SuppressWarnings("unchecked")
    Map<String, Object> serviceStatus = (Map<String, Object>) status.get(service);
    Number actual = serviceStatus != null ? (Number) serviceStatus.get("error_rate") : null;
    assertEquals(
        expectedErrorRate,
        actual != null ? actual.doubleValue() : 0.0,
        0.001,
        "Expected error_rate " + expectedErrorRate + " for " + service + ", got " + actual);
  }

  @Then("chaos for {string} will have latency min {int}")
  public void chaosForWillHaveLatencyMin(String service, int expectedMin) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    @SuppressWarnings("unchecked")
    Map<String, Object> serviceStatus = (Map<String, Object>) status.get(service);
    Number actual = serviceStatus != null ? (Number) serviceStatus.get("latency_min_ms") : null;
    assertEquals(
        expectedMin,
        actual != null ? actual.intValue() : 0,
        "Expected latency_min_ms " + expectedMin + " for " + service + ", got " + actual);
  }

  @Then("chaos for {string} will have latency max {int}")
  public void chaosForWillHaveLatencyMax(String service, int expectedMax) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    @SuppressWarnings("unchecked")
    Map<String, Object> serviceStatus = (Map<String, Object>) status.get(service);
    Number actual = serviceStatus != null ? (Number) serviceStatus.get("latency_max_ms") : null;
    assertEquals(
        expectedMax,
        actual != null ? actual.intValue() : 0,
        "Expected latency_max_ms " + expectedMax + " for " + service + ", got " + actual);
  }

  @Then("the chaos status will contain {string}")
  public void theChaosStatusWillContain(String serviceName) throws Exception {
    @SuppressWarnings("unchecked")
    Map<String, Object> status = LwsCli.chaosStatus(world.managementPort());
    assertTrue(
        status.containsKey(serviceName),
        "Expected chaos status to contain \"" + serviceName + "\", got keys: " + status.keySet());
  }
}
