package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.EventBus;
import software.amazon.awssdk.services.eventbridge.model.ListEventBusesResponse;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the lambda_events cross-service informal specification feature files.
 *
 * <p>Covers: deploy_function, create_event_bus, delete_event_bus, invoke_function,
 * invocation_fails_bus_deleted, publish_event_task.
 *
 * <p>Steps already registered in LambdaSteps ("the function does not already exist", "the function
 * already exists", "the function exists", "the function is {string}", etc.) and EventsSteps ("the
 * event bus is \"ACTIVE\"", "the event bus is \"DELETED\"", etc.) are NOT re-registered here. "the
 * operation is rejected" and "the system is initialized" are already registered in
 * CrossServiceSteps.
 */
public class LambdaEventsSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_BUS = "e2e-test-bus-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaEventsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaEventsCreateFunction() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      client.createFunction(
          r ->
              r.functionName(TEST_FUNC)
                  .runtime(Runtime.PYTHON3_12)
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

  private void lambdaEventsCreateBus() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      client.createEventBus(r -> r.name(TEST_BUS));
      // Assert: creation succeeded (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  @Given("the bus does not exist or is \"DELETED\"")
  public void theBusDoesNotExistOrIsDeleted() {
    // No-op: fresh state after reset has no event buses (simulates deleted bus).
  }

  @When("the Lambda function fails to publish because the event bus has been deleted")
  public void theLambdaFunctionFailsToPublishBecauseTheEventBusHasBeenDeleted() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario is @internal"));
  }

  @When("the Lambda function publishes an event to the {string} event bus and succeeds")
  public void theLambdaFunctionPublishesAnEventToTheEventBusAndSucceeds(String busState) {
    // @internal: Cannot trigger Lambda event publish in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda event publish: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the bus is \"DELETED\" and Lambda PutEvents calls targeting it will fail")
  public void theBusIsDeletedAndLambdaPutEventsCallsTargetingItWillFail() {
    // Arrange
    String expectedBus = TEST_BUS;
    // Act
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      ListEventBusesResponse result =
          client.listEventBuses(
              software.amazon.awssdk.services.eventbridge.model.ListEventBusesRequest.builder()
                  .build());
      List<EventBus> buses = result.eventBuses();
      boolean actualFound = buses.stream().anyMatch(b -> expectedBus.equals(b.name()));
      // Assert
      assertFalse(
          actualFound,
          "Expected event bus '"
              + expectedBus
              + "' to be DELETED but found it; expected_bus="
              + expectedBus);
    }
  }

  @Then("the invocation is \"FAILED\" with a ResourceNotFoundException")
  public void theInvocationIsFailedWithAResourceNotFoundException() {
    // @internal: Cannot observe Lambda invocation failure in lws.
  }

  @Then("the event is \"PUBLISHED\" and the invocation is \"SUCCESS\"")
  public void theEventIsPublishedAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation result in lws.
  }

  // "every {string} event references a bus that exists" → CrossServiceSteps (catch-all @And("^every .*$"))
}
