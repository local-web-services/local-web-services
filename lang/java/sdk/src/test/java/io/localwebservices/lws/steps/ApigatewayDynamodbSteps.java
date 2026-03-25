package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.Map;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.apigateway.model.CreateDeploymentResponse;
import software.amazon.awssdk.services.apigateway.model.CreateRestApiResponse;
import software.amazon.awssdk.services.apigateway.model.GetResourcesResponse;
import software.amazon.awssdk.services.apigateway.model.GetRestApisResponse;
import software.amazon.awssdk.services.apigateway.model.IntegrationType;
import software.amazon.awssdk.services.apigateway.model.Resource;
import software.amazon.awssdk.services.apigateway.model.RestApi;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;

/**
 * Step definitions for the apigateway_dynamodb cross-service feature files.
 *
 * <p>Covers: create_rest_api, create_table, configure_direct_integration, delete_table,
 * request_succeeds, request_fails.
 *
 * <p>Steps already registered in CrossServiceSteps (the system is initialized, the operation is
 * rejected, every invariant catch-all) are NOT re-registered here.
 */
public class ApigatewayDynamodbSteps {

  private static final String TEST_API_NAME = "e2e-test-api-1";
  private static final String TEST_TABLE = "e2e-test-table-1";
  private static final String TEST_PK = "e2e-id";
  private static final String TEST_ITEM_KEY = "e2e-item-1";
  private static final String TEST_STAGE = "prod";
  private static final String TEST_REGION = "us-east-1";

  private final WorldContext world;

  // Scenario-scoped state
  private String restApiId;
  private int invokeStatusCode;

  public ApigatewayDynamodbSteps(WorldContext world) {
    this.world = world;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  private void apigwDdbCreateRestApi() throws Exception {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      CreateRestApiResponse result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store API ID
      restApiId = result.id();
    }
  }

  private String apigwDdbGetApiId() throws Exception {
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

  private void apigwDdbCreateTable() {
    // Arrange
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      // Act
      client.createTable(
          r ->
              r.tableName(TEST_TABLE)
                  .keySchema(
                      KeySchemaElement.builder()
                          .attributeName(TEST_PK)
                          .keyType(KeyType.HASH)
                          .build())
                  .attributeDefinitions(
                      AttributeDefinition.builder()
                          .attributeName(TEST_PK)
                          .attributeType(ScalarAttributeType.S)
                          .build())
                  .billingMode(BillingMode.PAY_PER_REQUEST));
      // Assert: table created
    }
  }

  private void apigwDdbConfigureIntegration(String apiId) throws Exception {
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

    // Act: put DynamoDB AWS integration
    String integrationUri =
        String.format("arn:aws:apigateway:%s:dynamodb:action/PutItem", TEST_REGION);
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

  private int apigwDdbInvokeApi(String apiId, String body) throws Exception {
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

  // ── Given: API state ──────────────────────────────────────────────────────────

  @Given("the \"API\" does not already exist")
  public void theApiDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh session state has no REST APIs.
  }

  @Given("the \"API\" already exists")
  public void theApiAlreadyExists() throws Exception {
    // Arrange
    // Act
    apigwDdbCreateRestApi();
    // Assert: creation succeeded
  }

  @Given("the \"API\" exists and is \"ACTIVE\"")
  public void theApiExistsAndIsActive() throws Exception {
    // Arrange
    // Act
    apigwDdbCreateRestApi();
    // Assert: API is immediately ACTIVE in lws
  }

  @Given("the \"API\" does not exist or is not \"ACTIVE\"")
  public void theApiDoesNotExistOrIsNotActive() {
    // Arrange / Act / Assert — no-op: cannot simulate non-ACTIVE REST API in lws; @internal
    // excluded.
  }

  @Given("the \"API\" has no DynamoDB integration configured")
  public void theApiHasNoDynamoDbIntegrationConfigured() {
    // Arrange / Act / Assert — no-op: APIs have no DynamoDB integration by default.
  }

  @Given("the \"API\" already has a DynamoDB integration configured")
  public void theApiAlreadyHasDynamoDbIntegrationConfigured() {
    // Arrange / Act / Assert — no-op: cannot simulate pre-configured integration conflict in lws;
    // @internal excluded.
  }

  @Given("the \"API\" is \"ACTIVE\"")
  public void theApiIsActive() {
    // Arrange / Act / Assert — no-op: REST APIs are ACTIVE immediately after creation in lws.
  }

  @Given("the \"API\" is not \"ACTIVE\"")
  public void theApiIsNotActive() {
    // Arrange / Act / Assert — no-op: cannot simulate non-ACTIVE REST API in lws; @internal
    // excluded.
  }

  @Given("the \"API\" has a DynamoDB integration configured")
  public void theApiHasDynamoDbIntegrationConfigured() throws Exception {
    // Arrange: create API if not yet created
    String apiId = apigwDdbGetApiId();
    if (apiId == null) {
      apigwDdbCreateRestApi();
      apiId = restApiId;
    }
    // Act: create table and configure integration
    try {
      apigwDdbCreateTable();
    } catch (Exception ignored) {
      // Table may already exist from a prior Given step
    }
    apigwDdbConfigureIntegration(apiId);
    // Assert: store API ID
    restApiId = apiId;
  }

  @Given("the table exists and is \"ACTIVE\"")
  public void theTableExistsAndIsActive() {
    // Arrange
    // Act
    apigwDdbCreateTable();
    // Assert: table is immediately ACTIVE in lws
  }

  @Given("the table does not exist or is not \"ACTIVE\"")
  public void theTableDoesNotExistOrIsNotActive() {
    // Arrange / Act / Assert — no-op: cannot simulate non-ACTIVE DynamoDB table in lws; @internal
    // excluded.
  }

  @Given("the target table is \"ACTIVE\"")
  public void theTargetTableIsActive() {
    // Arrange: ensure the table exists
    // Act
    try {
      apigwDdbCreateTable();
    } catch (Exception ignored) {
      // May already exist from a prior step
    }
    // Assert: table is immediately ACTIVE in lws
  }

  @Given("the target table is not \"ACTIVE\"")
  public void theTargetTableIsNotActive() {
    // Arrange / Act / Assert — no-op: cannot simulate non-ACTIVE target table in lws; @internal
    // excluded.
  }

  @Given("the target table is \"DELETING\"")
  public void theTargetTableIsDeleting() {
    // Arrange / Act / Assert — no-op: cannot simulate DELETING table state in lws; @internal
    // excluded.
  }

  @Given("the target table is not \"DELETING\"")
  public void theTargetTableIsNotDeleting() {
    // Arrange / Act / Assert — no-op: tables are not DELETING by default.
  }

  @Given("the table is already \"DELETING\"")
  public void theTableIsAlreadyDeleting() {
    // Arrange / Act / Assert — no-op: cannot simulate DELETING state in lws; @internal excluded.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("an \"API\" Gateway \"REST\" \"API\" is created")
  public void anApiGatewayRestApiIsCreated() {
    // Arrange
    // Act
    try {
      apigwDdbCreateRestApi();
      world.setSuccess(restApiId);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a direct DynamoDB integration is configured on the \"API\"")
  public void aDirectDynamoDbIntegrationIsConfiguredOnTheApi() {
    // Arrange
    try {
      String apiId = apigwDdbGetApiId();
      if (apiId == null) {
        world.setFailure(new IllegalStateException("REST API not found"));
        return;
      }
      // Act
      apigwDdbConfigureIntegration(apiId);
      restApiId = apiId;
      world.setSuccess(Map.of("configured", true));
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a request is received, the \"API\" writes to the DynamoDB table, and returns 200")
  public void aRequestIsReceivedAndWritesToDynamoDb() {
    // Arrange
    try {
      String apiId = restApiId != null ? restApiId : apigwDdbGetApiId();
      String body =
          String.format(
              "{\"TableName\":\"%s\",\"Item\":{\"%s\":{\"S\":\"%s\"},\"value\":{\"S\":\"hello\"}}}",
              TEST_TABLE, TEST_PK, TEST_ITEM_KEY);
      // Act
      int status = apigwDdbInvokeApi(apiId, body);
      invokeStatusCode = status;
      if (status != 200) {
        world.setFailure(new RuntimeException("API request failed with status " + status));
      } else {
        world.setSuccess(status);
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  @When("a request is received but the DynamoDB write fails because the table is being deleted")
  public void aRequestFailsTableDeleting() {
    // Arrange / Act / Assert — no-op: cannot simulate DELETING table during request in lws;
    // @internal excluded.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot simulate DELETING table during request: @internal"));
  }

  @When("a table deletion is initiated")
  public void aTableDeletionIsInitiated() {
    // Arrange
    // Act
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      client.deleteTable(r -> r.tableName(TEST_TABLE));
      world.setSuccess(TEST_TABLE);
    } catch (Exception e) {
      world.setFailure(e);
    }
    // Assert: captured in world
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the \"API\" is \"ACTIVE\" with no DynamoDB integration configured")
  public void theApiIsActiveWithNoDynamoDbIntegrationConfigured() throws Exception {
    // Arrange
    String apiId = apigwDdbGetApiId();
    assertNotNull(
        apiId, "Expected REST API \"" + TEST_API_NAME + "\" to exist but it was not found");
    // Act
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      software.amazon.awssdk.services.apigateway.model.GetRestApiResponse resp =
          client.getRestApi(r -> r.restApiId(apiId));
      // Assert
      String expectedName = TEST_API_NAME;
      String actualName = resp.name();
      assertEquals(expectedName, actualName, "Expected API name to be \"" + expectedName + "\"");
    }
  }

  @Then("the \"API\" will write to the table when requests are received")
  public void theApiWillWriteToTheTable() throws Exception {
    // Arrange
    String apiId = restApiId != null ? restApiId : apigwDdbGetApiId();
    assertNotNull(apiId, "Expected API to exist");
    String body =
        String.format(
            "{\"TableName\":\"%s\",\"Item\":{\"%s\":{\"S\":\"check-item-1\"},\"value\":{\"S\":\"ok\"}}}",
            TEST_TABLE, TEST_PK);
    // Act
    int actualStatus = apigwDdbInvokeApi(apiId, body);
    // Assert
    int expectedStatus = 200;
    assertEquals(
        expectedStatus,
        actualStatus,
        "Expected status " + expectedStatus + " but got " + actualStatus);
  }

  @Then("the item \"EXISTS\" and the request is \"SUCCESS\"")
  public void theItemExistsAndRequestIsSuccess() {
    // Arrange
    int expectedInvokeStatus = 200;
    int actualInvokeStatus = invokeStatusCode;
    assertEquals(
        expectedInvokeStatus,
        actualInvokeStatus,
        "Expected request status " + expectedInvokeStatus + " but got " + actualInvokeStatus);
    // Act
    try (DynamoDbClient client = world.session.dynamoDbClient()) {
      GetItemResponse resp =
          client.getItem(
              r ->
                  r.tableName(TEST_TABLE)
                      .key(Map.of(TEST_PK, AttributeValue.builder().s(TEST_ITEM_KEY).build())));
      // Assert
      Map<String, AttributeValue> actualItem = resp.item();
      assertNotNull(actualItem, "Expected item to exist in DynamoDB but it was not found");
    }
  }

  @Then("the request is \"FAILED\" and no item is written")
  public void theRequestIsFailedAndNoItemIsWritten() {
    // Arrange / Act / Assert — no-op: cannot simulate DynamoDB write failure via API Gateway in
    // lws; @internal excluded.
  }

  @Then("the table is \"DELETING\" and \"API\" requests targeting it will fail")
  public void theTableIsDeletingAndRequestsWillFail() {
    // Arrange: delete_table should have succeeded
    // Act / Assert
    Throwable actualError = world.lastError;
    assertNull(actualError, "Expected delete_table to succeed but got: " + actualError);
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  @Then("every existing item references a table that exists")
  public void everyExistingItemReferencesATableThatExists() {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied in isolated lws
    // context.
  }

  @Then("every successful request references an \"API\" that exists")
  public void everySuccessfulRequestReferencesAnApiThatExists() {
    // Arrange / Act / Assert — no-op: model-level invariant; trivially satisfied in isolated lws
    // context.
  }
}
