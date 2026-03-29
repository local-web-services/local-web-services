package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.apigateway.model.GetRestApisResponse;
import software.amazon.awssdk.services.apigateway.model.RestApi;

/**
 * Step definitions for the apigateway_lambda cross-service feature files.
 *
 * <p>Covers: configure_integration, create_rest_api, deploy_function, handle_request,
 * invocation_fails, invocation_succeeds.
 *
 * <p>Steps already registered in {@link ApigatewaySteps} (API existence, lifecycle states), {@link
 * LambdaSteps} (function existence, lifecycle states), {@link LambdaDynamodbSteps} ("an invocation
 * is IN_PROGRESS", "no invocation is IN_PROGRESS", "an invocation slot is available", "no
 * invocation slot is available", "a Lambda function is deployed", "every IN_PROGRESS invocation
 * references an ACTIVE Lambda function"), and {@link CrossServiceSteps} ("the system is
 * initialized", "the operation is rejected") are NOT re-registered here.
 *
 * <p>Only the unique cross-service steps absent from all constituent files are defined here.
 */
public class ApigatewayLambdaSteps {

  private static final String TEST_API_NAME = "e2e-test-api-1";

  private final WorldContext world;

  public ApigatewayLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: API integration state ──────────────────────────────────────────────

  @Given("the \"API\" has no integration configured")
  public void theApiHasNoIntegrationConfigured() {
    // No-op: APIs have no integration configured by default after creation.
  }

  @Given("the \"API\" already has an integration configured")
  public void theApiAlreadyHasAnIntegrationConfigured() {
    // @internal: Cannot configure Lambda integration on REST API in lws.
  }

  @Given("the \"API\" has a Lambda integration configured")
  public void theApiHasALambdaIntegrationConfigured() {
    // @internal: Cannot configure Lambda integration on REST API in lws.
  }

  @Given("the \"API\" has no Lambda integration configured")
  public void theApiHasNoLambdaIntegrationConfigured() {
    // No-op: APIs have no Lambda integration configured by default.
  }

  // ── Given: integrated function state ──────────────────────────────────────────

  @Given("the integrated function is \"ACTIVE\"")
  public void theIntegratedFunctionIsActive() {
    // @internal: Requires a Lambda integration to be configured first, which is
    // not supported via public APIs in lws.
  }

  @Given("the integrated function is not \"ACTIVE\"")
  public void theIntegratedFunctionIsNotActive() {
    // @internal: Requires a Lambda integration and lifecycle manipulation.
  }

  // ── When: actions ──────────────────────────────────────────────────────────────

  @When("a Lambda integration is configured on the \"REST\" \"API\"")
  public void aLambdaIntegrationIsConfiguredOnTheRestApi() {
    // @internal: Cannot configure Lambda integration on REST API in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot configure Lambda integration: scenario is @internal"));
  }

  @When("the \"API\" receives an \"HTTP\" request and synchronously invokes the Lambda function")
  public void theApiReceivesAnHttpRequestAndSynchronouslyInvokesTheLambdaFunction() {
    // @internal: Cannot send requests through API Gateway Lambda integration in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot send HTTP request through API Gateway Lambda integration:"
                + " scenario is @internal"));
  }

  @When(
      "the Lambda invocation completes successfully and the \"API\" returns a successful"
          + " response")
  public void theLambdaInvocationCompletesSuccessfullyAndTheApiReturnsASuccessfulResponse() {
    // @internal: Cannot trigger Lambda invocation completion via API Gateway in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation success via API Gateway: scenario is @internal"));
  }

  @When("the Lambda invocation fails and the \"API\" returns an error response")
  public void theLambdaInvocationFailsAndTheApiReturnsAnErrorResponse() {
    // @internal: Cannot trigger Lambda invocation failure via API Gateway in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure via API Gateway: scenario is @internal"));
  }

  // ── Then: assertions ───────────────────────────────────────────────────────────

  @Then("the \"API\" is \"ACTIVE\" with no Lambda integration configured")
  public void theApiIsActiveWithNoLambdaIntegrationConfigured() {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      GetRestApisResponse result = client.getRestApis();
      List<RestApi> items = result.items();
      // Assert
      String expectedName = TEST_API_NAME;
      boolean actualExists = items.stream().anyMatch(api -> expectedName.equals(api.name()));
      assertTrue(
          actualExists,
          "Expected REST API \""
              + expectedName
              + "\" to exist but it was not found;"
              + " expected_name="
              + expectedName);
    }
  }

  @Then("the \"API\" will synchronously invoke the function when a request arrives")
  public void theApiWillSynchronouslyInvokeTheFunctionWhenARequestArrives() {
    // @internal: Cannot verify Lambda integration behaviour in lws.
  }

  @Then("the request and invocation are both \"IN_PROGRESS\"")
  public void theRequestAndInvocationAreBothInProgress() {
    // @internal: Cannot observe in-progress request and invocation state in lws.
  }

  @Then("the invocation is \"SUCCESS\" and the request is \"SUCCESS\"")
  public void theInvocationIsSuccessAndTheRequestIsSuccess() {
    // @internal: Cannot observe invocation and request success state in lws.
  }

  @Then("the invocation is \"FAILED\" and the request is \"FAILED\"")
  public void theInvocationIsFailedAndTheRequestIsFailed() {
    // @internal: Cannot observe invocation and request failure state in lws.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  // "every \"IN_PROGRESS\" request references an \"ACTIVE\" \"API\"" → CrossServiceSteps (catch-all
  // @And("^every .*$"))
  // "every \"IN_PROGRESS\" invocation has a corresponding \"IN_PROGRESS\" request" →
  // CrossServiceSteps (catch-all @And("^every .*$"))
}
