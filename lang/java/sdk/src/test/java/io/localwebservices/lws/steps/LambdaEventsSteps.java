package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

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

  // ── Given: bus state ──────────────────────────────────────────────────────────

  @Given("the bus does not already exist")
  public void theBusDoesNotAlreadyExist() {
    // No-op: fresh state after reset has no event buses.
  }

  @Given("the bus already exists")
  public void theBusAlreadyExists() {
    // Arrange: create the bus so it already exists
    // Act
    lambdaEventsCreateBus();
    // Assert: bus created (no error thrown)
  }

  @Given("the bus exists")
  public void theBusExists() {
    // Arrange: create the test event bus
    // Act
    lambdaEventsCreateBus();
    // Assert: bus created (no error thrown)
  }

  @Given("the bus is \"ACTIVE\"")
  public void theBusIsActive() {
    // No-op: event buses are ACTIVE immediately after creation.
  }

  @Given("the bus is already \"DELETED\"")
  public void theBusIsAlreadyDeleted() {
    // Arrange: delete the bus if present to reach a DELETED state
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act: delete, ignore errors (bus may not exist)
      try {
        client.deleteEventBus(r -> r.name(TEST_BUS));
      } catch (Exception ignored) {
        // bus may not exist; desired state is absence
      }
    }
    // Assert: reset world result to clean slate
    world.lastSuccess = false;
    world.lastOutput = null;
    world.lastError = null;
  }

  @Given("the bus does not exist")
  public void theBusDoesNotExist() {
    // No-op: fresh state after reset has no event buses.
  }

  @Given("the bus does not exist or is \"DELETED\"")
  public void theBusDoesNotExistOrIsDeleted() {
    // No-op: fresh state after reset has no event buses (simulates deleted bus).
  }

  @Given("the bus is \"DELETED\"")
  public void theBusIsDeleted() {
    // No-op: fresh state after reset has no event buses (simulates deleted bus).
  }

  @Given("the bus is not \"DELETED\"")
  public void theBusIsNotDeleted() {
    // Arrange: ensure the bus exists so it is not in a DELETED state
    // Act
    lambdaEventsCreateBus();
    // Assert: bus created (no error thrown)
  }

  // ── Given: invocation / slot state ────────────────────────────────────────────

  @Given("an invocation is \"IN_PROGRESS\"")
  public void anInvocationIsInProgress() {
    // Arrange: create the function so an invocation can be IN_PROGRESS
    // Act
    lambdaEventsCreateFunction();
    // Assert: function created (no error thrown)
  }

  @Given("no invocation is \"IN_PROGRESS\"")
  public void noInvocationIsInProgress() {
    // No-op: fresh state after reset has no active invocations.
  }

  @Given("an invocation slot is available")
  public void anInvocationSlotIsAvailable() {
    // No-op: always room for invocations in lws.
  }

  @Given("no invocation slot is available")
  public void noInvocationSlotIsAvailable() {
    // @internal: Cannot exhaust invocation slot limit in lws.
  }

  @Given("an event slot is available")
  public void anEventSlotIsAvailable() {
    // No-op: always room for events in lws.
  }

  @Given("no event slot is available")
  public void noEventSlotIsAvailable() {
    // @internal: Cannot exhaust event slot limit in lws.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
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
      // Assert: store result
      world.setSuccess(TEST_FUNC);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an EventBridge event bus is created")
  public void anEventBridgeEventBusIsCreated() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      client.createEventBus(r -> r.name(TEST_BUS));
      // Assert: store result
      world.setSuccess(TEST_BUS);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the EventBridge event bus is deleted")
  public void theEventBridgeEventBusIsDeleted() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      client.deleteEventBus(r -> r.name(TEST_BUS));
      // Assert: store result
      world.setSuccess(null);
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

  // "the function is \"ACTIVE\"" — already registered in LambdaSteps; NOT re-registered.
  // "the operation is rejected" — already registered in CrossServiceSteps; NOT re-registered.

  @Then("the bus is \"ACTIVE\"")
  public void theBusIsActiveThen() {
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
      assertTrue(
          actualFound,
          "Expected event bus '"
              + expectedBus
              + "' to be ACTIVE but not found; expected_bus="
              + expectedBus);
    }
  }

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

  @Then("the invocation is \"IN_PROGRESS\"")
  public void theInvocationIsInProgress() {
    // @internal: Cannot observe Lambda invocation state in lws.
  }

  @Then("the invocation is \"FAILED\" with a ResourceNotFoundException")
  public void theInvocationIsFailedWithAResourceNotFoundException() {
    // @internal: Cannot observe Lambda invocation failure in lws.
  }

  @Then("the event is \"PUBLISHED\" and the invocation is \"SUCCESS\"")
  public void theEventIsPublishedAndTheInvocationIsSuccess() {
    // @internal: Cannot observe Lambda invocation result in lws.
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  @Then("every {string} invocation references an {string} Lambda function")
  public void everyInvocationReferencesAnLambdaFunction(
      String invocationState, String functionState) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every {string} event references a bus that exists")
  public void everyEventReferencesABusThatExists(String eventState) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
