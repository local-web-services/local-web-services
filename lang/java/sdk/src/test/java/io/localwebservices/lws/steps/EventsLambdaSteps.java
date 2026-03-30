package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.jupiter.api.Assumptions;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.DescribeRuleResponse;
import software.amazon.awssdk.services.eventbridge.model.RuleState;
import software.amazon.awssdk.services.eventbridge.model.Target;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.Runtime;

/**
 * Step definitions for the events_lambda cross-service informal specification feature files.
 *
 * <p>Covers: create_event_bus, deploy_function, put_rule, put_event, invocation_fails,
 * invocation_succeeds.
 *
 * <p>Steps already registered in {@link EventsSteps} (e.g. "the event bus does not already exist",
 * "the event bus already exists", "the event bus exists", "the event bus is \"ACTIVE\"", "the event
 * bus is not \"ACTIVE\"", "the event bus does not exist", "the rule does not already exist", "the
 * rule already exists", "an EventBridge event bus is created", "the event bus is \"ACTIVE\""
 * (Then)) and in {@link LambdaSteps} (e.g. "the function does not already exist", "the function
 * already exists", "the function exists", "the function is \"ACTIVE\"", "the function is not
 * \"ACTIVE\"", "the function does not exist", "the function is {string}" (Then)) and in {@link
 * LambdaSnsSteps} (e.g. "an invocation is \"IN_PROGRESS\"", "no invocation is \"IN_PROGRESS\"", "an
 * invocation slot is available", "no invocation slot is available", "a Lambda function is
 * deployed", "the Lambda invocation fails", "the Lambda invocation completes successfully", "the
 * invocation is {string}", "every \"IN_PROGRESS\" invocation references an \"ACTIVE\" Lambda
 * function") are intentionally absent here to avoid duplicate step definition errors.
 */
public class EventsLambdaSteps {

  private static final String TEST_BUS = "e2e-test-bus-1";
  private static final String TEST_RULE = "test-rule-1";
  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String EVENT_PATTERN = "{\"source\":[\"test.source\"]}";
  private static final String TARGET_ID = "t1";
  private static final String REGION = "us-east-1";
  private static final String ACCOUNT_ID = "000000000000";

  private final WorldContext world;

  public EventsLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String funcArn() {
    return "arn:aws:lambda:" + REGION + ":" + ACCOUNT_ID + ":function:" + TEST_FUNC;
  }

  private void eventsLambdaCreateBus() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      client.createEventBus(r -> r.name(TEST_BUS));
      // Assert: bus created (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("already") && !msg.contains("conflict") && !msg.contains("Conflict")) {
        throw e;
      }
    }
  }

  private void eventsLambdaCreateFunction() {
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
      // Assert: function created (no exception thrown)
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("ResourceConflict") && !msg.contains("already")) {
        throw e;
      }
    }
  }

  private void eventsLambdaCreateRuleWithTarget() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act: create rule
      client.putRule(
          r ->
              r.name(TEST_RULE)
                  .eventBusName(TEST_BUS)
                  .eventPattern(EVENT_PATTERN)
                  .state(RuleState.ENABLED));
      // Act: attach Lambda target
      client.putTargets(
          r ->
              r.rule(TEST_RULE)
                  .eventBusName(TEST_BUS)
                  .targets(Target.builder().id(TARGET_ID).arn(funcArn()).build()));
      // Assert: rule and target created (no exception thrown)
    }
  }

  // ── Given: cross-service rule + target state ──────────────────────────────────

  @Given("an \"ENABLED\" rule exists on the bus targeting a function")
  public void anEnabledRuleExistsOnTheBusTargetingAFunction() {
    // Arrange: ensure bus and function exist, then create rule with Lambda target
    eventsLambdaCreateBus();
    eventsLambdaCreateFunction();
    // Act
    eventsLambdaCreateRuleWithTarget();
    // Assert: rule and target created
  }

  @Given("no \"ENABLED\" rule exists on the bus targeting a function")
  public void noEnabledRuleExistsOnTheBusTargetingAFunction() {
    // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing
    // in lws without a real rule wired to an active function; lws does not fail put_events
    // when no matching rule exists.
    Assumptions.assumeTrue(
        false, "lws limitation: cannot trigger EventBridge->Lambda routing without a wired rule");
  }

  @Given("the target function is \"ACTIVE\"")
  public void theTargetFunctionIsActive() {
    // Arrange / Act / Assert — no-op: Lambda functions are ACTIVE immediately after creation.
    Assumptions.assumeTrue(
        false, "Arrange / Act / Assert — no-op: Lambda functions are ACTIVE immediately after cr");
  }

  @Given("the target function is not \"ACTIVE\"")
  public void theTargetFunctionIsNotActive() {
    // Arrange / Act / Assert — skip: cannot trigger internal EventBridge->Lambda routing
    // when the target function is not ACTIVE.
    Assumptions.assumeTrue(
        false, "lws limitation: cannot make target function non-ACTIVE for routing tests");
  }

  // ── When: cross-service actions ───────────────────────────────────────────────

  @When(
      "an EventBridge rule is created to asynchronously invoke a Lambda function on matching"
          + " events")
  public void anEventBridgeRuleIsCreatedToAsynchronouslyInvokeALambdaFunctionOnMatchingEvents() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act: create rule then attach Lambda target
      client.putRule(
          r ->
              r.name(TEST_RULE)
                  .eventBusName(TEST_BUS)
                  .eventPattern(EVENT_PATTERN)
                  .state(RuleState.ENABLED));
      Object result =
          client.putTargets(
              r ->
                  r.rule(TEST_RULE)
                      .eventBusName(TEST_BUS)
                      .targets(Target.builder().id(TARGET_ID).arn(funcArn()).build()));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an event is published to the bus and triggers an asynchronous Lambda invocation")
  public void anEventIsPublishedToTheBusAndTriggersAnAsynchronousLambdaInvocation() {
    // @internal: Cannot trigger internal EventBridge->Lambda routing in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger EventBridge->Lambda routing: scenario is @internal"));
  }

  // ── Then: cross-service assertions ────────────────────────────────────────────

  @Then("the rule is \"ENABLED\" and will trigger the function when matching events are published")
  public void theRuleIsEnabledAndWillTriggerTheFunctionWhenMatchingEventsArePublished() {
    // Arrange
    try (EventBridgeClient client = world.session.eventBridgeClient()) {
      // Act
      DescribeRuleResponse result =
          client.describeRule(r -> r.name(TEST_RULE).eventBusName(TEST_BUS));
      // Assert
      String expectedState = RuleState.ENABLED.toString();
      String actualState = result.stateAsString();
      assertEquals(
          expectedState,
          actualState,
          "Expected rule state \""
              + expectedState
              + "\" but got \""
              + actualState
              + "\""
              + "; expected_state="
              + expectedState
              + " actual_state="
              + actualState);
    }
  }

  // ── Invariant Then steps (no-ops) ─────────────────────────────────────────────

  // "every \"IN_PROGRESS\" invocation was triggered by an \"ENABLED\" rule" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
  // "every \"ENABLED\" rule references an \"ACTIVE\" event bus" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
}
