package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.Message;
import software.amazon.awssdk.services.sqs.model.ReceiveMessageResponse;

/**
 * Step definitions for the apigateway_sqs cross-service informal specification feature files.
 *
 * <p>Covers: create_rest_api, create_queue, configure_integration, handle_request, consume_message.
 *
 * <p>Steps already registered in CrossServiceSteps (the system is initialized, the operation is
 * rejected, the queue does not already exist, the queue already exists, the queue exists, the queue
 * is not {string}, the queue does not exist, the target queue is {string}, the target queue is not
 * {string}, a message slot is available, no message slot is available, an {string} message exists
 * in the queue, no {string} message exists in the queue, every .* catch-all) are NOT re-registered
 * here.
 */
public class ApigatewaySqsSteps {

  private static final String TEST_API_NAME = "e2e-test-api-1";
  private static final String TEST_QUEUE = "e2e-test-q1";
  private static final String TEST_STAGE = "prod";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  // Scenario-scoped state
  private String restApiId;
  private int invokeStatusCode;

  public ApigatewaySqsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  private void apigwSqsCreateRestApi() throws Exception {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      CreateRestApiResponse result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store API ID
      restApiId = result.id();
    }
  }

  private String apigwSqsGetApiId() throws Exception {
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

  private void apigwSqsCreateQueue() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      // Act
      client.createQueue(r -> r.queueName(TEST_QUEUE));
      // Assert: queue created
    }
  }

  private void apigwSqsConfigureIntegration(String apiId) throws Exception {
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

    // Act: put POST method on root resource
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      client.putMethod(
          r ->
              r.restApiId(capturedApiId)
                  .resourceId(capturedRootResourceId)
                  .httpMethod("POST")
                  .authorizationType("NONE"));
    }

    // Act: wire SQS direct integration
    String integrationUri =
        String.format(
            "arn:aws:apigateway:%s:sqs:path/%s/%s", TEST_REGION, TEST_ACCOUNT, TEST_QUEUE);
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

  private int apigwSqsInvokeApi(String apiId, String body) throws Exception {
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

  @Given("the \"API\" has an \"SQS\" integration configured")
  public void theApiHasSqsIntegrationConfigured() throws Exception {
    // Arrange: ensure API and queue exist
    String apiId = apigwSqsGetApiId();
    if (apiId == null) {
      apigwSqsCreateRestApi();
      apiId = restApiId;
    }
    apigwSqsCreateQueue();
    // Act: configure SQS direct integration
    apigwSqsConfigureIntegration(apiId);
    // Assert: integration configured
  }

  @Given("the \"API\" has no \"SQS\" integration configured")
  public void theApiHasNoSqsIntegrationConfigured() {
    // Arrange / Act / Assert — no-op: APIs have no SQS integration configured by default.
  }

  @Given("the target queue is \"ACTIVE\"")
  public void theTargetQueueIsActive() {
    // Arrange / Act: ensure queue exists (idempotent)
    try {
      apigwSqsCreateQueue();
    } catch (Exception ignored) {
      // queue may already exist from a prior Given step
    }
    // Assert: queue exists and is ACTIVE
  }

  @When("an \"SQS\" direct integration is configured on the \"REST\" \"API\"")
  public void anSqsDirectIntegrationIsConfigured() {
    // Arrange
    try {
      String apiId = apigwSqsGetApiId();
      if (apiId == null) {
        throw new IllegalStateException("REST API \"" + TEST_API_NAME + "\" not found");
      }
      // Act
      apigwSqsConfigureIntegration(apiId);
      world.setSuccess(java.util.Map.of("configured", true));
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("the \"API\" receives a request and enqueues it as an \"SQS\" message")
  public void theApiReceivesRequestAndEnqueues() {
    // Arrange
    try {
      String apiId = restApiId;
      if (apiId == null) {
        apiId = apigwSqsGetApiId();
      }
      if (apiId == null) {
        throw new IllegalStateException("REST API \"" + TEST_API_NAME + "\" not found");
      }
      // Act: POST to the deployed stage
      String jsonBody = "{\"event\":\"order-created\",\"orderId\":\"e2e-1\"}";
      invokeStatusCode = apigwSqsInvokeApi(apiId, jsonBody);
      if (invokeStatusCode != 200) {
        throw new IllegalStateException("API request failed with status " + invokeStatusCode);
      }
      world.setSuccess(java.util.Map.of("status", invokeStatusCode));
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a backend consumer processes the message from the queue")
  public void aBackendConsumerProcessesMessage() {
    // Arrange
    try (SqsClient client = world.session.sqsClient()) {
      String qUrl = world.session.queueUrl(TEST_QUEUE);
      // Act: receive
      ReceiveMessageResponse recvResult =
          client.receiveMessage(r -> r.queueUrl(qUrl).maxNumberOfMessages(1).waitTimeSeconds(0));
      List<Message> messages = recvResult.messages();
      if (messages.isEmpty()) {
        throw new IllegalStateException(
            "No AVAILABLE message found in queue \"" + TEST_QUEUE + "\"");
      }
      String receiptHandle = messages.get(0).receiptHandle();
      // Act: delete (consumer acknowledges)
      client.deleteMessage(r -> r.queueUrl(qUrl).receiptHandle(receiptHandle));
      world.setSuccess(java.util.Map.of("deleted", true));
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the \"API\" is \"ACTIVE\" with no \"SQS\" integration configured")
  public void theApiIsActiveWithNoSqsIntegration() throws Exception {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      GetRestApisResponse result = client.getRestApis(r -> {});
      List<RestApi> items = result.items();
      // Assert
      String expectedName = TEST_API_NAME;
      boolean actualFound = items.stream().anyMatch(a -> expectedName.equals(a.name()));
      assertTrue(
          actualFound,
          "Expected REST API \""
              + expectedName
              + "\" to be ACTIVE but not found; expected_found=true actual_found="
              + actualFound);
    }
  }

  @Then("the \"API\" will enqueue incoming requests as \"SQS\" messages without invoking Lambda")
  public void theApiWillEnqueueRequestsWithoutLambda() throws Exception {
    // Arrange: resolve API ID
    String apiId = restApiId;
    if (apiId == null) {
      apiId = apigwSqsGetApiId();
    }
    assertNotNull(apiId, "Expected REST API \"" + TEST_API_NAME + "\" to exist but not found");
    // Act: POST a test request
    String jsonBody = "{\"event\":\"check\",\"orderId\":\"check-1\"}";
    int actualStatus = apigwSqsInvokeApi(apiId, jsonBody);
    // Assert
    int expectedStatus = 200;
    assertEquals(
        expectedStatus,
        actualStatus,
        "Expected status "
            + expectedStatus
            + " but got "
            + actualStatus
            + "; expected_status="
            + expectedStatus
            + " actual_status="
            + actualStatus);
  }

  @Then("the request is \"ACCEPTED\" and the message is \"AVAILABLE\" in the queue")
  public void theRequestIsAcceptedAndMessageIsAvailable() throws Exception {
    // Arrange
    int expectedStatus = 200;
    int actualStatus = invokeStatusCode;
    assertEquals(
        expectedStatus,
        actualStatus,
        "Expected request status "
            + expectedStatus
            + " but got "
            + actualStatus
            + "; expected_status="
            + expectedStatus
            + " actual_status="
            + actualStatus);
    // Act: check queue for enqueued message
    try (SqsClient client = world.session.sqsClient()) {
      String qUrl = world.session.queueUrl(TEST_QUEUE);
      ReceiveMessageResponse recvResult =
          client.receiveMessage(r -> r.queueUrl(qUrl).maxNumberOfMessages(1).waitTimeSeconds(0));
      List<Message> messages = recvResult.messages();
      // Assert
      int expectedCount = 1;
      int actualCount = messages.size();
      assertTrue(
          actualCount >= expectedCount,
          "Expected at least "
              + expectedCount
              + " message in queue but found "
              + actualCount
              + "; expected_count="
              + expectedCount
              + " actual_count="
              + actualCount);
    }
  }
}
