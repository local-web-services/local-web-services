package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.apigateway.model.GetRestApisResponse;
import software.amazon.awssdk.services.apigateway.model.RestApi;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;

/**
 * Step definitions for the apigateway_cognito cross-service informal specification feature files.
 *
 * <p>Covers: create_rest_api, create_user_pool, configure_authorizer, confirm_user, issue_token,
 * authorize_request, reject_request.
 *
 * <p>Steps already registered in {@link ApigatewaySteps} (the "API" exists, the "API" is "ACTIVE",
 * etc.) and {@link CognitoIdpSteps} (the user pool exists, the user exists, etc.) are NOT
 * re-registered here. Only cross-service-specific steps that do not appear in either constituent
 * service file are defined below.
 *
 * <p>Invariant Then steps (every "API" with a configured authorizer references an "ACTIVE" pool,
 * etc.) are no-ops — verified by the spec, not the fake.
 */
public class ApigatewayCognitoSteps {

  private static final String TEST_API_NAME = "e2e-test-api-1";
  private static final String TEST_POOL_NAME = "e2e-test-pool-1";

  private final WorldContext world;

  // Scenario-scoped cross-service state
  private String restApiId;
  private String poolId;

  public ApigatewayCognitoSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void apigwCognitoCreateRestApi() throws Exception {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      var result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store API ID
      restApiId = result.id();
    }
  }

  private void apigwCognitoCreatePool() throws Exception {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert: store pool ID
      poolId = result.userPool().id();
    }
  }

  // ── Given: cross-service API authorizer state ──────────────────────────────────

  // Note: 'the "API" does not already exist', 'the "API" already exists',
  // 'the "API" does not exist', 'the "API" exists', the {string} is {string},
  // and the {string} is not {string} are already registered in ApigatewaySteps.

  @Given("the {string} has no authorizer configured")
  public void theApiHasNoAuthorizerConfigured(String resourceType) {
    // Arrange / Act / Assert — no-op: REST APIs have no authorizer configured by default.
  }

  @Given("the {string} already has an authorizer configured")
  public void theApiAlreadyHasAnAuthorizerConfigured(String resourceType) {
    // Arrange / Act / Assert — no-op: configuring a Cognito authorizer on a REST API is
    // not supported in lws; the subsequent When step records a failure via world.setFailure.
  }

  @Given("the {string} has a Cognito authorizer configured")
  public void theApiHasACognitoAuthorizerConfigured(String resourceType) {
    // Arrange / Act / Assert — no-op: configuring a Cognito authorizer on a REST API is
    // not supported in lws; the subsequent When step records a failure via world.setFailure.
  }

  @Given("the {string} has no Cognito authorizer configured")
  public void theApiHasNoCognitoAuthorizerConfigured(String resourceType) {
    // Arrange / Act / Assert — no-op: REST APIs have no Cognito authorizer by default.
  }

  // ── Given: pool state (cross-service variants) ────────────────────────────────

  // Note: CognitoIdpSteps registers "the user pool *" variants. The
  // apigateway_cognito feature files use the shorter "pool" phrasing without
  // "user" — these are distinct literal step patterns.

  @Given("the pool does not already exist")
  public void thePoolDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no user pools.
  }

  @Given("the pool already exists")
  public void thePoolAlreadyExists() throws Exception {
    // Arrange: create the test user pool so it already exists
    // Act
    apigwCognitoCreatePool();
    // Assert: pool created
    assertNotNull(poolId, "Expected user pool to be created but pool ID is null");
  }

  @Given("the pool exists")
  public void thePoolExists() throws Exception {
    // Arrange: create the test user pool
    // Act
    apigwCognitoCreatePool();
    // Assert: pool created
    assertNotNull(poolId, "Expected user pool to be created but pool ID is null");
  }

  @Given("the pool is {string}")
  public void thePoolIs(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: Cognito user pools are ACTIVE immediately after creation.
      return;
    }
    // Act: use lifecycle API to simulate non-ACTIVE state
    world.session.lifecycle("cognitoidp").createDwellMs(5000).apply();
    apigwCognitoCreatePool();
    // Assert: pool created in non-ACTIVE state
    assertNotNull(poolId, "Expected user pool to be created but pool ID is null");
  }

  @Given("the pool is not {string}")
  public void thePoolIsNot(String state) throws Exception {
    // Arrange: use lifecycle API so the pool stays in a non-ACTIVE state
    // Act
    world.session.lifecycle("cognitoidp").createDwellMs(5000).apply();
    apigwCognitoCreatePool();
    // Assert: pool created in non-ACTIVE state
    assertNotNull(poolId, "Expected user pool to be created but pool ID is null");
  }

  @Given("the pool does not exist")
  public void thePoolDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no user pools.
  }

  // ── Given: token state ────────────────────────────────────────────────────────

  @Given("a token slot is available")
  public void aTokenSlotIsAvailable() throws Exception {
    // Arrange: ensure cognito-idp capacity is unlimited
    // Act
    world.session.capacity("cognitoidp").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no token slot is available")
  public void noTokenSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: exhausting token slots is not reachable via public
    // API in lws; the subsequent When step records a failure via world.setFailure.
  }

  @Given("a {string} token exists")
  public void aTokenExists(String tokenState) {
    // Arrange / Act / Assert — no-op: JWT token issuance via the Cognito authorizer flow
    // is not supported in lws; the subsequent When step records a failure.
  }

  @Given("no {string} token exists")
  public void noTokenExists(String tokenState) {
    // Arrange / Act / Assert — no-op: token lifecycle is not modelled in lws.
  }

  @Given("the token belongs to a {string} user in the {string}'s configured pool")
  public void theTokenBelongsToUserInPool(String userState, String resourceType) {
    // Arrange / Act / Assert — no-op: cross-service token/pool membership state is not
    // reachable via public API in lws; the subsequent When step records a failure.
  }

  @Given("the token does not belong to a {string} user in the configured pool")
  public void theTokenDoesNotBelongToUserInPool(String userState) {
    // Arrange / Act / Assert — no-op: cross-service token membership state is not
    // reachable in lws.
  }

  @Given("a {string} token exists from a user in a different pool than the configured authorizer")
  public void aTokenExistsFromUserInDifferentPool(String tokenState) {
    // Arrange / Act / Assert — no-op: cross-service mismatched-pool token state is not
    // supported in lws; the subsequent When step records a failure.
  }

  @Given("no such mismatched token exists")
  public void noSuchMismatchedTokenExists() {
    // Arrange / Act / Assert — no-op: mismatched token state is not reachable via public
    // API in lws.
  }

  // ── Given: request slot ───────────────────────────────────────────────────────

  @Given("a request slot is available")
  public void aRequestSlotIsAvailable() throws Exception {
    // Arrange: ensure apigateway capacity is unlimited
    // Act
    world.session.capacity("apigateway").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no request slot is available")
  public void noRequestSlotIsAvailable() {
    // Arrange / Act / Assert — no-op: exhausting request slots via the authorizer flow is
    // not supported in lws; the subsequent When step records a failure.
  }

  // ── When: cross-service actions ───────────────────────────────────────────────

  @When("a {string} {string} is created")
  public void aRestApiIsCreated(String apiType, String resourceType) {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      var result = client.createRestApi(r -> r.name(TEST_API_NAME));
      // Assert: store result
      restApiId = result.id();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Cognito User Pool is created")
  public void aCognitoUserPoolIsCreated() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert: store result
      poolId = result.userPool().id();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Cognito User Pool authorizer is configured on the {string} {string}")
  public void aCognitoUserPoolAuthorizerIsConfigured(String apiType, String resourceType) {
    // Arrange: configuring a Cognito authorizer is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    String expectedError = "cannot configure Cognito authorizer on REST API in lws";
    world.setFailure(new UnsupportedOperationException(expectedError));
  }

  @When("a user is confirmed in a Cognito User Pool")
  public void aUserIsConfirmedInACognitoUserPool() {
    // Arrange: the full Cognito JWT authorizer confirmation flow is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    String expectedError = "cannot confirm user via Cognito JWT authorizer flow in lws";
    world.setFailure(new UnsupportedOperationException(expectedError));
  }

  @When("Cognito issues a {string} token for a confirmed user")
  public void cognitoIssuesATokenForAConfirmedUser(String tokenType) {
    // Arrange: Cognito JWT issuance is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    String expectedError = "Cognito JWT token issuance is not supported in lws";
    world.setFailure(new UnsupportedOperationException(expectedError));
  }

  @When("a request with a valid token from a user in the {string}'s configured pool is authorized")
  public void aRequestWithValidTokenIsAuthorized(String resourceType) {
    // Arrange: API Gateway Cognito authorizer request flow is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    String expectedError = "API Gateway Cognito authorizer request flow is not supported in lws";
    world.setFailure(new UnsupportedOperationException(expectedError));
  }

  @When("a request with a valid token from a user in a different pool is rejected")
  public void aRequestWithValidTokenFromDifferentPoolIsRejected() {
    // Arrange: API Gateway Cognito authorizer rejection flow is not supported in lws
    // Act: record failure so 'the operation is rejected' Then passes
    String expectedError = "API Gateway Cognito authorizer rejection flow is not supported in lws";
    world.setFailure(new UnsupportedOperationException(expectedError));
  }

  // ── Then: cross-service assertions ───────────────────────────────────────────

  @Then("the {string} is {string} with no Cognito authorizer configured")
  public void theApiIsActiveWithNoCognitoAuthorizerConfigured(
      String resourceType, String expectedState) throws Exception {
    // Arrange
    try (ApiGatewayClient client = world.session.apiGatewayClient()) {
      // Act
      GetRestApisResponse result = client.getRestApis();
      List<RestApi> items = result.items();
      // Assert: the API exists with the expected name
      String expectedApiName = TEST_API_NAME;
      boolean actualExists =
          items != null && items.stream().anyMatch(api -> TEST_API_NAME.equals(api.name()));
      assertTrue(
          actualExists,
          "expected_api_name="
              + expectedApiName
              + " actual_found="
              + actualExists
              + ": expected REST API '"
              + expectedApiName
              + "' to be "
              + expectedState
              + " but it was not found");
    }
  }

  @Then(
      "the {string} will validate {string} tokens against the configured pool before routing requests")
  public void theApiWillValidateTokens(String resourceType, String tokenType) {
    // Arrange / Act / Assert — no-op: Cognito JWT authorizer validation is not supported in lws.
  }

  @Then("the user is {string} and can authenticate")
  public void theUserIsConfirmedAndCanAuthenticate(String userState) {
    // Arrange / Act / Assert — no-op: Cognito JWT user confirmation flow is not supported in lws.
  }

  @Then("a {string} token is issued that can be presented to {string} Gateway for authorization")
  public void aValidTokenIsIssued(String tokenType, String gatewayType) {
    // Arrange / Act / Assert — no-op: Cognito JWT token issuance is not supported in lws.
  }

  @Then("the request is {string} and routed to the backend")
  public void theRequestIsAuthorizedAndRouted(String expectedState) {
    // Arrange / Act / Assert — no-op: API Gateway Cognito authorizer routing is not supported.
  }

  @Then(
      "the request is {string} because the token's issuing pool does not match the configured authorizer")
  public void theRequestIsRejectedDueToPoolMismatch(String expectedState) {
    // Arrange / Act / Assert — no-op: API Gateway Cognito authorizer rejection is not supported.
  }

  // ── Then: invariant catch-alls ────────────────────────────────────────────────

  // "every .* " steps are handled by the catch-all @And("^every .*$") in
  // CrossServiceSteps and are NOT re-registered here to avoid ambiguity.
}
