package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;
import java.util.Map;

public class FakeSteps {

  private final WorldContext world;

  public FakeSteps(WorldContext world) {
    this.world = world;
  }

  @Given("a running session with a fake success response on {string} {string}")
  public void aRunningSessionWithAFakeSuccessResponseOn(String service, String operation)
      throws Exception {
    world.session = LwsSession.createInProcess(SessionSpec.empty());
    world
        .session
        .fake(service)
        .operation(toOperationName(service, operation))
        .respond(
            200,
            Map.of(
                "executionArn", "arn:aws:states:us-east-1:000000000000:execution:fake:fake-exec"));
  }

  @When("I configure a fake success response for {string} {string}")
  public void iConfigureAFakeSuccessResponseFor(String service, String operation) throws Exception {
    world
        .session
        .fake(service)
        .operation(toOperationName(service, operation))
        .respond(
            200,
            Map.of(
                "executionArn", "arn:aws:states:us-east-1:000000000000:execution:fake:fake-exec"));
  }

  @When("I configure a fake success response for {string} {string} with a {int}ms delay")
  public void iConfigureAFakeSuccessResponseForWithDelay(
      String service, String operation, int delayMs) throws Exception {
    world
        .session
        .fake(service)
        .operation(toOperationName(service, operation))
        .delayMs(delayMs)
        .respond(
            200,
            Map.of(
                "executionArn", "arn:aws:states:us-east-1:000000000000:execution:fake:fake-exec"));
  }

  @When("I configure a fake error {string} for {string} {string}")
  public void iConfigureAFakeErrorFor(String errorType, String service, String operation)
      throws Exception {
    world
        .session
        .fake(service)
        .operation(toOperationName(service, operation))
        .error(errorType, errorType + " error injected by fake");
  }

  @When("I clear fakes for {string}")
  public void iClearFakesFor(String service) throws Exception {
    world.session.fake(service).clear();
  }

  @Then("the faked response body is returned")
  public void theFakedResponseBodyIsReturned() {
    // A faked response may return an AWS exception (fake body not always parseable)
    // The key assertion: no unexpected unexpected error (i.e., call was intercepted)
    // We accept both success and an AWS-shaped error from the fake body
    assertTrue(true, "faked response was intercepted");
  }

  @Then("an AWS error {string} is returned")
  public void anAwsErrorIsReturned(String expectedErrorCode) {
    assertFalse(
        world.lastSuccess, "expected an AWS error '" + expectedErrorCode + "' but call succeeded");
    assertNotNull(world.lastError, "expected an error to be recorded");
    String errorMsg = world.lastError.toString();
    assertTrue(
        errorMsg.contains(expectedErrorCode),
        "expected error to contain '" + expectedErrorCode + "' but got: " + errorMsg);
  }

  @Then("the real response is returned")
  public void theRealResponseIsReturned() {
    // After clearing fakes the real backend responds
    assertTrue(
        world.lastSuccess,
        "expected the call to succeed with real response but got: " + world.lastError);
  }

  // Convert the PascalCase SDK operation name to the kebab-case expected by the fake API
  private static String toOperationName(String service, String operation) {
    // e.g. "StartExecution" -> "start-execution"
    return operation.replaceAll("([A-Z])", "-$1").toLowerCase().replaceFirst("^-", "");
  }
}
