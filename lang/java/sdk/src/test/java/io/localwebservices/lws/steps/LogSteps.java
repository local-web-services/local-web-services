package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Then;
import io.localwebservices.lws.LogCapture;
import java.util.List;

public class LogSteps {

  private final WorldContext world;

  public LogSteps(WorldContext world) {
    this.world = world;
  }

  @Then("the log capture will contain a {string} {string} entry")
  public void theLogCaptureWillContainAnEntry(String service, String operation) {
    assertNotNull(world.logCapture, "log capture was not started");
    world.logCapture.assertCalled(service, operation);
  }

  @Then("no errors will appear in the log capture")
  public void noErrorsWillAppearInTheLogCapture() {
    assertNotNull(world.logCapture, "log capture was not started");
    world.logCapture.assertNoErrors();
  }

  @Then("filtering by service {string} returns only {word} entries")
  public void filteringByServiceReturnsOnlyEntries(String service, String serviceLabel) {
    assertNotNull(world.logCapture, "log capture was not started");
    List<LogCapture.LogEntry> entries = world.logCapture.forService(service);
    assertFalse(entries.isEmpty(), "expected at least one entry for service '" + service + "'");
    for (LogCapture.LogEntry e : entries) {
      assertEquals(
          service,
          e.service,
          "expected all entries to have service '" + service + "' but found: " + e.service);
    }
  }

  @Then("filtering by operation {string} returns at least one entry")
  public void filteringByOperationReturnsAtLeastOneEntry(String operation) {
    assertNotNull(world.logCapture, "log capture was not started");
    List<LogCapture.LogEntry> entries = world.logCapture.forOperation(operation);
    assertFalse(entries.isEmpty(), "expected at least one entry for operation '" + operation + "'");
  }

  @Then("the log capture will contain exactly {int} {string} {string} entries")
  public void theLogCaptureWillContainExactlyEntries(
      int expectedCount, String service, String operation) {
    assertNotNull(world.logCapture, "log capture was not started");
    world.logCapture.assertCallCount(service, operation, expectedCount);
  }

  @Then("recent logs are non-empty")
  public void recentLogsAreNonEmpty() throws Exception {
    // Poll briefly to let background log capture accumulate entries
    Thread.sleep(300);
    List<LogCapture.LogEntry> logs = world.session.recentLogs();
    assertFalse(logs.isEmpty(), "expected recent logs to be non-empty");
  }
}
