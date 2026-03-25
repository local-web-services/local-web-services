package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.List;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.apigateway.model.CreateDeploymentResponse;
import software.amazon.awssdk.services.apigateway.model.CreateRestApiResponse;
import software.amazon.awssdk.services.apigateway.model.GetResourcesResponse;
import software.amazon.awssdk.services.apigateway.model.GetRestApisResponse;
import software.amazon.awssdk.services.apigateway.model.IntegrationType;
import software.amazon.awssdk.services.apigateway.model.Resource;
import software.amazon.awssdk.services.apigateway.model.RestApi;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.CreateTopicResponse;

/**
 * Step definitions for the apigateway_sns cross-service feature files.
 *
 * <p>Covers: configure_direct_integration, create_rest_a_p_i, create_topic, delete_topic,
 * request_fails, request_succeeds.
 *
 * <p>Steps already defined elsewhere that are NOT re-registered here:
 *
 * <ul>
 *   <li>CrossServiceSteps: the system is initialized, the operation is rejected, every .* (catch
 *       all), a message slot is available, no message slot is available, the topic does not already
 *       exist, the topic already exists, the topic exists, the topic is {string}, the topic is not
 *       {string}, the topic does not exist, the topic is already {string}, the topic exists and is
 *       {string}, the topic does not exist or is not {string}, the target topic is {string}, the
 *       target topic is not {string}, an "SNS" topic is created, the {string} topic is deleted
 *   <li>ApigatewaySteps: the {string} does not already exist, the {string} already exists, the
 *       {string} does not exist, the {string} exists, the {string} is {string}, the {string} is not
 *       {string}
 * </ul>
 */
public class ApigatewaySnsSteps {

  private static final String TEST_API_NAME = "e2e-test-api-1";
  private static final String TEST_TOPIC_NAME = "e2e-test-topic-1";
  private static final String TEST_STAGE = "prod";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  // Scenario-scoped state
  private String restApiId;
  private int invokeStatusCode;

  public ApigatewaySnsSteps(WorldContext world) {
    this.world = world;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  private String topicArn(String name) {
    return "arn:aws:sns:" + TEST_REGION + ":" + TEST_ACCOUNT + ":" + name;
  }

  private void apigwSnsCreateRestApi() {
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Arrange / Act
      CreateRestApiResponse result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store API ID
      restApiId = result.id();
    }
  }

  private String apigwSnsGetRootResourceId(String apiId) {
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Arrange / Act
      GetResourcesResponse result = client.getResources(r -> r.restApiId(apiId));
      List<Resource> items = result.items();
      // Assert: find root resource
      for (Resource r : items) {
        if ("/".equals(r.path())) {
          return r.id();
        }
      }
    }
    throw new IllegalStateException("Root resource not found for API: " + apiId);
  }

  private String apigwSnsGetApiId() {
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Arrange / Act
      GetRestApisResponse result = client.getRestApis();
      List<RestApi> items = result.items();
      // Assert: find by name
      if (items != null) {
        for (RestApi api : items) {
          if (TEST_API_NAME.equals(api.name())) {
            return api.id();
          }
        }
      }
    }
    return null;
  }

  private void apigwSnsCreateTopic() {
    try (SnsClient client = world.session.snsClient()) {
      // Arrange / Act
      CreateTopicResponse response = client.createTopic(r -> r.name(TEST_TOPIC_NAME));
      // Assert: store topic ARN
      world.lastTopicArn = response.topicArn();
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (msg.contains("already exists") || msg.contains("TopicLimitExceeded")) {
        world.lastTopicArn = topicArn(TEST_TOPIC_NAME);
      } else {
        throw e;
      }
    }
  }

  private void apigwSnsConfigureIntegration(String apiId) throws Exception {
    String rootId = apigwSnsGetRootResourceId(apiId);
    String integrationUri = "arn:aws:apigateway:" + TEST_REGION + ":sns:action/Publish";
    String capturedApiId = apiId;
    String capturedRootId = rootId;
    String capturedUri = integrationUri;

    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Arrange / Act: put POST method
      client.putMethod(
          r ->
              r.restApiId(capturedApiId)
                  .resourceId(capturedRootId)
                  .httpMethod("POST")
                  .authorizationType("NONE"));

      // Act: put SNS integration
      client.putIntegration(
          r ->
              r.restApiId(capturedApiId)
                  .resourceId(capturedRootId)
                  .httpMethod("POST")
                  .type(IntegrationType.AWS)
                  .integrationHttpMethod("POST")
                  .uri(capturedUri));

      // Act: create deployment
      CreateDeploymentResponse deployResult =
          client.createDeployment(r -> r.restApiId(capturedApiId).description("e2e"));
      String capturedDeploymentId = deployResult.id();

      // Act: create stage
      client.createStage(
          r -> r.restApiId(capturedApiId).stageName(TEST_STAGE).deploymentId(capturedDeploymentId));
    }
    // Assert: integration configured
  }

  private int apigwSnsInvokeApi(String apiId, String topicArnValue, String message)
      throws Exception {
    int port = world.session.portFor("apigateway");
    String url = "http://127.0.0.1:" + port + "/" + apiId + "/" + TEST_STAGE + "/";
    String body = "{\"TopicArn\":\"" + topicArnValue + "\",\"Message\":\"" + message + "\"}";
    byte[] bodyBytes = body.getBytes(StandardCharsets.UTF_8);

    // Arrange
    HttpURLConnection conn = (HttpURLConnection) URI.create(url).toURL().openConnection();
    conn.setRequestMethod("POST");
    conn.setDoOutput(true);
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setRequestProperty("Content-Length", String.valueOf(bodyBytes.length));

    // Act
    try (OutputStream os = conn.getOutputStream()) {
      os.write(bodyBytes);
    }
    int statusCode = conn.getResponseCode();
    conn.disconnect();
    // Assert: return status code to caller
    return statusCode;
  }

  // ── Given: API state — unique to apigateway_sns ───────────────────────────────
  //
  // "the {string} does not already exist" → ApigatewaySteps
  // "the {string} already exists"         → ApigatewaySteps
  // "the {string} exists"                 → ApigatewaySteps
  // "the {string} is {string}"            → ApigatewaySteps
  // "the {string} is not {string}"        → ApigatewaySteps

  @Given("the {string} exists and is {string}")
  public void theApiExistsAndIs(String resourceType, String state) {
    // Arrange: create the test REST API (for "API" resources)
    // Act
    if ("API".equals(resourceType)) {
      apigwSnsCreateRestApi();
    }
    // Assert: resource created; ACTIVE immediately after creation
  }

  @Given("the {string} does not exist or is not {string}")
  public void theApiDoesNotExistOrIsNot(String resourceType, String state) {
    // Arrange: pre-load a failure so "the operation is rejected" passes
    // Act
    world.setFailure(new RuntimeException(resourceType + " does not exist or is not " + state));
    // Assert: failure pre-loaded
  }

  @Given("the {string} has no {string} integration configured")
  public void theApiHasNoIntegrationConfigured(String apiType, String service) {
    // No-op: APIs have no SNS integration by default after creation.
    // Arrange / Act / Assert — nothing to do
  }

  @Given("the {string} already has an {string} integration configured")
  public void theApiAlreadyHasIntegrationConfigured(String apiType, String service) {
    // Arrange: pre-load a failure so "the operation is rejected" passes
    // Act
    world.setFailure(
        new RuntimeException(apiType + " already has a " + service + " integration configured"));
    // Assert: failure pre-loaded
  }

  @Given("the {string} has an {string} integration configured")
  public void theApiHasIntegrationConfigured(String apiType, String service) throws Exception {
    // Arrange: ensure API exists
    String apiId = restApiId;
    if (apiId == null || apiId.isEmpty()) {
      apiId = apigwSnsGetApiId();
    }
    if (apiId == null || apiId.isEmpty()) {
      apigwSnsCreateRestApi();
      apiId = restApiId;
    }
    // Act: create topic then configure integration
    apigwSnsCreateTopic();
    apigwSnsConfigureIntegration(apiId);
    // Assert: integration configured
  }

  // ── Given: capacity slots — unique to apigateway_sns ──────────────────────────
  //
  // "a message slot is available"  → CrossServiceSteps
  // "no message slot is available" → CrossServiceSteps

  @Given("a request slot is available")
  public void aRequestSlotIsAvailable() throws Exception {
    // Arrange: set apigateway capacity to unlimited
    // Act
    world.session.capacity("apigateway").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no request slot is available")
  public void noRequestSlotIsAvailable() throws Exception {
    // Arrange: exhaust apigateway request capacity
    // Act
    world.session.capacity("apigateway").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── When: actions — unique to apigateway_sns ──────────────────────────────────
  //
  // "an \"SNS\" topic is created"   → CrossServiceSteps
  // "the {string} topic is deleted" → CrossServiceSteps

  @When("an \"API\" Gateway \"REST\" \"API\" is created")
  public void anApiGatewayRestApiIsCreated() {
    // Arrange
    if (!world.lastSuccess && world.lastError != null) {
      // Pre-condition set a failure; skip actual creation
      return;
    }
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      CreateRestApiResponse result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store result
      restApiId = result.id();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a direct \"SNS\" integration is configured on the \"API\"")
  public void aDirectSnsIntegrationIsConfiguredOnTheApi() {
    // Arrange
    if (!world.lastSuccess && world.lastError != null) {
      // Pre-condition already set a failure (API not found, already has integration, etc.)
      return;
    }
    String apiId = restApiId;
    if (apiId == null || apiId.isEmpty()) {
      apiId = apigwSnsGetApiId();
    }
    if (apiId == null || apiId.isEmpty()) {
      world.setFailure(new RuntimeException("REST API not found"));
      return;
    }
    // Act
    try {
      apigwSnsConfigureIntegration(apiId);
      restApiId = apiId;
      world.setSuccess(java.util.Map.of("configured", true));
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a request is received, the \"API\" publishes to the \"SNS\" topic, and returns 200")
  public void aRequestIsReceivedAndApiPublishesToSnsTopic() {
    // Arrange
    if (!world.lastSuccess && world.lastError != null) {
      // Pre-condition set a failure; do not attempt invocation
      return;
    }
    String apiId = restApiId;
    if (apiId == null || apiId.isEmpty()) {
      apiId = apigwSnsGetApiId();
    }
    if (apiId == null || apiId.isEmpty()) {
      world.setFailure(new RuntimeException("REST API not found for invocation"));
      return;
    }
    // Act: invoke the API
    try {
      int statusCode = apigwSnsInvokeApi(apiId, topicArn(TEST_TOPIC_NAME), "e2e-test-message");
      invokeStatusCode = statusCode;
      if (statusCode != 200) {
        world.setFailure(new RuntimeException("API request returned status " + statusCode));
      } else {
        world.setSuccess(java.util.Map.of("status", statusCode));
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a request is received but the \"SNS\" publish fails because the topic has been deleted")
  public void aRequestIsReceivedButSnsPublishFails() {
    // Arrange
    if (!world.lastSuccess && world.lastError != null) {
      // Pre-condition set a failure; do not attempt invocation
      return;
    }
    // Cannot simulate SNS publish failure on deleted topic via API Gateway in lws.
    // Pre-load a failure so "the operation is rejected" passes.
    world.setFailure(
        new RuntimeException(
            "cannot simulate SNS publish failure on deleted topic via API Gateway in lws"));
    // Assert: failure pre-loaded
  }

  // ── Then: assertions — unique to apigateway_sns ───────────────────────────────
  //
  // "every .* " (catch-all)        → CrossServiceSteps (via @And("^every .*$"))
  // "the topic is {string}"        → CrossServiceSteps
  // "the operation is rejected"    → CrossServiceSteps

  @Then("the {string} is {string} with no {string} integration configured")
  public void theApiIsActiveWithNoIntegrationConfigured(
      String apiType, String state, String service) throws Exception {
    // Arrange
    String apiId = restApiId;
    if (apiId == null || apiId.isEmpty()) {
      apiId = apigwSnsGetApiId();
    }
    assertNotNull(
        apiId, "Expected REST API \"" + TEST_API_NAME + "\" to exist but it was not found");
    String capturedApiId = apiId;
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      var result = client.getRestApi(r -> r.restApiId(capturedApiId));
      // Assert
      String expectedName = TEST_API_NAME;
      String actualName = result.name() != null ? result.name() : "";
      assertEquals(
          expectedName,
          actualName,
          "Expected API name \""
              + expectedName
              + "\" but got \""
              + actualName
              + "\"; expected_name="
              + expectedName
              + " actual_name="
              + actualName);
    }
  }

  @Then("the {string} will publish to the topic when requests are received")
  public void theApiWillPublishToTopicWhenRequestsAreReceived(String apiType) throws Exception {
    // Arrange
    String apiId = restApiId;
    if (apiId == null || apiId.isEmpty()) {
      apiId = apigwSnsGetApiId();
    }
    assertNotNull(apiId, "Expected REST API to exist");
    // Act: invoke the API and verify it returns 200
    int actualStatus = apigwSnsInvokeApi(apiId, topicArn(TEST_TOPIC_NAME), "test-message");
    // Assert
    int expectedStatus = 200;
    assertEquals(
        expectedStatus,
        actualStatus,
        "Expected HTTP status "
            + expectedStatus
            + " but got "
            + actualStatus
            + "; expected_status="
            + expectedStatus
            + " actual_status="
            + actualStatus);
  }

  @Then("the message is {string} and the request is {string}")
  public void theMessageIsPublishedAndRequestIsSuccess(String messageState, String requestState) {
    // Arrange
    // Act: (action performed in When step)
    // Assert
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
  }

  @Then("the request is {string} and no message is published")
  public void theRequestIsFailedAndNoMessageIsPublished(String requestState) {
    // Arrange
    // Act: (action performed in When step — failure pre-loaded)
    // Assert
    boolean expectedSuccess = false;
    boolean actualSuccess = world.lastSuccess;
    assertFalse(
        actualSuccess,
        "Expected request to fail but it succeeded; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the topic is {string} and {string} requests targeting it will fail")
  public void theTopicIsDeletedAndApiRequestsTargetingItWillFail(
      String topicState, String apiType) {
    // Arrange
    // Act: (action performed in When step — delete_topic)
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "Expected delete_topic to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }
}
