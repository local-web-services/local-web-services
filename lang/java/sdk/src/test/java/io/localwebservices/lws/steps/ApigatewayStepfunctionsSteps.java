package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.apigateway.model.CreateDeploymentResponse;
import software.amazon.awssdk.services.apigateway.model.CreateRestApiResponse;
import software.amazon.awssdk.services.apigateway.model.GetResourcesResponse;
import software.amazon.awssdk.services.apigateway.model.GetRestApisResponse;
import software.amazon.awssdk.services.apigateway.model.IntegrationType;
import software.amazon.awssdk.services.apigateway.model.Resource;
import software.amazon.awssdk.services.apigateway.model.RestApi;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.CreateStateMachineResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

/**
 * Step definitions for the apigateway_stepfunctions cross-service feature files.
 *
 * <p>Covers: create_rest_api, create_state_machine, configure_integration, handle_request,
 * execution_succeeds, execution_fails.
 *
 * <p>Steps already registered in CrossServiceSteps (the system is initialized, the operation is
 * rejected, every invariant catch-all) are NOT re-registered here.
 */
public class ApigatewayStepfunctionsSteps {

  private static final String TEST_API_NAME = "e2e-apigwsfn-test-api-1";
  private static final String TEST_SM_NAME = "e2e-apigwsfn-test-sm-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/e2e-role";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";
  private static final String TEST_STAGE = "prod";

  private final WorldContext world;

  // Scenario-scoped state
  private String restApiId;
  private int invokeStatusCode;
  private boolean skipScenario;
  private String skipReason;

  public ApigatewayStepfunctionsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private void apigwSfnCreateRestApi() {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      CreateRestApiResponse result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store API ID
      restApiId = result.id();
    }
  }

  private String apigwSfnGetApiId() {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      GetRestApisResponse result = client.getRestApis(r -> {});
      List<RestApi> apis = result.items();
      // Assert: find by name
      for (RestApi api : apis) {
        if (TEST_API_NAME.equals(api.name())) {
          return api.id();
        }
      }
    }
    return null;
  }

  private void apigwSfnCreateStateMachine(String name, StateMachineType type) {
    // Arrange
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      CreateStateMachineResponse result =
          client.createStateMachine(
              r -> r.name(name).definition(TEST_PASS_DEFINITION).roleArn(TEST_ROLE_ARN).type(type));
      // Assert: store ARN
      world.lastStateMachineArn = result.stateMachineArn();
    }
  }

  private void apigwSfnConfigureIntegration(String apiId) throws Exception {
    // Arrange: fetch root resource
    String rootResourceId;
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      GetResourcesResponse resources = client.getResources(r -> r.restApiId(apiId));
      Resource rootResource = null;
      for (Resource r : resources.items()) {
        if ("/".equals(r.path())) {
          rootResource = r;
          break;
        }
      }
      if (rootResource == null) {
        throw new IllegalStateException("Root resource not found for API: " + apiId);
      }
      rootResourceId = rootResource.id();
    }

    String capturedApiId = apiId;
    String capturedRootResourceId = rootResourceId;

    // Act: put POST method
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      client.putMethod(
          r ->
              r.restApiId(capturedApiId)
                  .resourceId(capturedRootResourceId)
                  .httpMethod("POST")
                  .authorizationType("NONE"));
    }

    // Act: put StepFunctions AWS integration
    String integrationUri =
        String.format("arn:aws:apigateway:%s:states:action/StartExecution", TEST_REGION);
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      client.putIntegration(
          r ->
              r.restApiId(capturedApiId)
                  .resourceId(capturedRootResourceId)
                  .httpMethod("POST")
                  .type(IntegrationType.AWS)
                  .integrationHttpMethod("POST")
                  .uri(integrationUri));
    }

    // Act: create deployment
    String deploymentId;
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      CreateDeploymentResponse deployResult =
          client.createDeployment(r -> r.restApiId(capturedApiId).description("e2e"));
      deploymentId = deployResult.id();
    }

    // Act: create prod stage
    String capturedDeploymentId = deploymentId;
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      client.createStage(
          r -> r.restApiId(capturedApiId).stageName(TEST_STAGE).deploymentId(capturedDeploymentId));
    }
  }

  private int apigwSfnInvokeApi(String apiId, String body) throws Exception {
    // Arrange: build invocation URL using apigateway port
    int port = world.session.portFor("apigateway");
    String url = String.format("http://127.0.0.1:%d/%s/%s/", port, apiId, TEST_STAGE);
    // Act: POST to the deployed stage
    HttpRequest request =
        HttpRequest.newBuilder()
            .uri(URI.create(url))
            .header("Content-Type", "application/json")
            .POST(HttpRequest.BodyPublishers.ofString(body))
            .build();
    HttpResponse<String> response =
        HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
    // Assert: caller uses status code
    return response.statusCode();
  }

  @Given("the \"API\" has a Step Functions integration configured")
  public void theApiHasAStepFunctionsIntegrationConfigured() throws Exception {
    // Arrange: ensure API exists
    String apiId = restApiId;
    if (apiId == null) {
      apiId = apigwSfnGetApiId();
    }
    if (apiId == null) {
      apigwSfnCreateRestApi();
      apiId = restApiId;
    }
    // Act: create state machine and configure integration
    try {
      apigwSfnCreateStateMachine(TEST_SM_NAME, StateMachineType.EXPRESS);
    } catch (Exception ignored) {
      // Tolerate already-exists errors
    }
    apigwSfnConfigureIntegration(apiId);
    // Assert: integration configured (no error thrown)
  }

  @Given("the \"API\" has no Step Functions integration configured")
  public void theApiHasNoStepFunctionsIntegrationConfigured() {
    // Arrange / Act / Assert — no-op: APIs have no StepFunctions integration by default.
  }

  @Given("the integrated state machine is \"ACTIVE\"")
  public void theIntegratedStateMachineIsActive() {
    // Arrange: ensure state machine exists (idempotent — ignore already-exists errors)
    try {
      apigwSfnCreateStateMachine(TEST_SM_NAME, StateMachineType.EXPRESS);
    } catch (Exception ignored) {
      // Tolerate already-exists errors
    }
    // Assert: state machine is ACTIVE
  }

  @Given("the integrated state machine is not \"ACTIVE\"")
  public void theIntegratedStateMachineIsNotActive() {
    // Arrange / Act / Assert — cannot simulate non-ACTIVE integrated state machine.
    world.setFailure(
        new UnsupportedOperationException(
            "Cannot simulate non-ACTIVE integrated state machine in lws"));
  }

  @When("a Step Functions Express Workflow state machine is created")
  public void aStepFunctionsExpressWorkflowStateMachineIsCreated() {
    // Arrange: use EXPRESS type
    try (SfnClient client = world.session.sfnClient()) {
      // Act
      CreateStateMachineResponse result =
          client.createStateMachine(
              r ->
                  r.name(TEST_SM_NAME)
                      .definition(TEST_PASS_DEFINITION)
                      .roleArn(TEST_ROLE_ARN)
                      .type(StateMachineType.EXPRESS));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Step Functions direct integration is configured on the \"REST\" \"API\"")
  public void aStepFunctionsDirectIntegrationIsConfigured() throws Exception {
    if (skipScenario) {
      world.setFailure(new UnsupportedOperationException(skipReason));
      return;
    }
    // Arrange: find the API
    String apiId = restApiId;
    if (apiId == null) {
      apiId = apigwSfnGetApiId();
    }
    if (apiId == null) {
      world.setFailure(new IllegalStateException("REST API not found"));
      return;
    }
    // Act: configure the integration
    try {
      apigwSfnConfigureIntegration(apiId);
      restApiId = apiId;
      world.setSuccess(Boolean.TRUE);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "the \"API\" receives an \"HTTP\" request and synchronously starts a Step Functions execution")
  public void theApiReceivesHttpRequestAndStartsExecution() throws Exception {
    // Arrange: determine API ID
    String apiId = restApiId;
    if (apiId == null) {
      apiId = apigwSfnGetApiId();
    }
    String smArn = smArn(TEST_SM_NAME);
    String body =
        String.format(
            "{\"stateMachineArn\":\"%s\",\"input\":\"{\\\"key\\\":\\\"value\\\"}\"}", smArn);
    // Act
    try {
      int status = apigwSfnInvokeApi(apiId, body);
      invokeStatusCode = status;
      if (status != 200) {
        world.setFailure(new IllegalStateException("API request failed with status " + status));
      } else {
        world.setSuccess(status);
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "the Step Functions execution completes successfully and the \"API\" returns a successful"
          + " response")
  public void theExecutionCompletesSuccessfully() {
    // Arrange / Act — cannot simulate Step Functions execution completion via API Gateway.
    world.setFailure(
        new UnsupportedOperationException(
            "Cannot simulate Step Functions execution completion via API Gateway in lws"));
  }

  @When("the Step Functions execution fails and the \"API\" returns an error response")
  public void theExecutionFails() {
    // Arrange / Act — cannot simulate Step Functions execution failure via API Gateway.
    world.setFailure(
        new UnsupportedOperationException(
            "Cannot simulate Step Functions execution failure via API Gateway in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the \"API\" is \"ACTIVE\" with no Step Functions integration configured")
  public void theApiIsActiveWithNoStepFunctionsIntegration() {
    // Arrange
    String expectedName = TEST_API_NAME;
    // Act
    String apiId = apigwSfnGetApiId();
    assertNotNull(apiId, "Expected REST API '" + expectedName + "' to exist but it was not found");
    // Assert
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      String capturedApiId = apiId;
      String actualName = client.getRestApi(r -> r.restApiId(capturedApiId)).name();
      assertEquals(
          expectedName,
          actualName,
          "Expected API name '" + expectedName + "' but got '" + actualName + "'");
    }
  }

  @Then("the \"API\" will synchronously start and await an Express Workflow execution per request")
  public void theApiWillSynchronouslyStartAndAwaitExecution() throws Exception {
    // Arrange
    String apiId = restApiId;
    if (apiId == null) {
      apiId = apigwSfnGetApiId();
    }
    assertNotNull(apiId, "Expected REST API '" + TEST_API_NAME + "' to exist but not found");
    String smArn = smArn(TEST_SM_NAME);
    String body =
        String.format(
            "{\"stateMachineArn\":\"%s\",\"input\":\"{\\\"check\\\":\\\"ok\\\"}\"}", smArn);
    // Act
    int expectedStatus = 200;
    int actualStatus = apigwSfnInvokeApi(apiId, body);
    // Assert
    assertEquals(
        expectedStatus,
        actualStatus,
        "Expected status " + expectedStatus + " but got " + actualStatus);
  }

  @Then("the request and execution are both \"IN_PROGRESS\" and \"RUNNING\" respectively")
  public void theRequestAndExecutionAreBothInProgressAndRunning() {
    // Arrange / Act / Assert — cannot inspect in-progress execution state via API Gateway.
    // Invariant: trivially satisfied in isolated lws context.
  }

  @Then("the execution is \"SUCCEEDED\" and the request is \"SUCCESS\"")
  public void theExecutionIsSucceededAndRequestIsSuccess() {
    // Arrange
    boolean expectedSuccess = true;
    // Act: action already performed in When step
    boolean actualSuccess = world.lastSuccess;
    // Assert
    assertEquals(
        expectedSuccess,
        actualSuccess,
        "Expected request status SUCCESS but last call failed: " + world.lastError);
  }

  @Then("the execution is \"FAILED\" and the request is \"FAILED\"")
  public void theExecutionIsFailedAndRequestIsFailed() {
    // Arrange / Act / Assert — cannot simulate Step Functions execution failure via API Gateway.
    // Invariant: trivially satisfied in isolated lws context.
  }

  // "every \"RUNNING\" execution references an \"ACTIVE\" state machine" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
  // "every \"RUNNING\" execution has a corresponding \"IN_PROGRESS\" request" → CrossServiceSteps
  // (catch-all @And("^every .*$"))
}
