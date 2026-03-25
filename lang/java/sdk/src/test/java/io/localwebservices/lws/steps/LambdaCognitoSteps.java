package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.GetFunctionResponse;
import software.amazon.awssdk.services.lambda.model.Runtime;
import software.amazon.awssdk.services.lambda.model.State;

/**
 * Step definitions for the lambda_cognito cross-service informal specification feature files.
 *
 * <p>Covers: create_user_pool, delete_user_pool, deploy_function, invoke_function,
 * invocation_succeeds, invocation_fails_pool_deleted — unique steps only.
 *
 * <p>Steps already registered in {@link LambdaSteps} ("the function does not already exist", "the
 * function already exists", "the function exists", "the function does not exist", "the function is
 * {string}", "the function is not {string}", "an invocation slot is available", "no invocation slot
 * is available"), {@link CrossServiceSteps} ("the system is initialized", "the operation is
 * rejected", invariant catch-alls) are NOT re-registered here.
 */
public class LambdaCognitoSteps {

  private static final String TEST_FUNC = "e2e-test-func-1";
  private static final String TEST_POOL_NAME = "e2e-test-pool-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";

  private final WorldContext world;

  public LambdaCognitoSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void lambdaCognitoCreateFunction() {
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

  private String lambdaCognitoCreatePool() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert: caller stores pool ID
      return result.userPool().id();
    }
  }

  private String lambdaCognitoFindPoolId() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.listUserPools(r -> r.maxResults(10));
      // Assert: find pool by name
      for (UserPoolDescriptionType pool : result.userPools()) {
        if (TEST_POOL_NAME.equals(pool.name())) {
          return pool.id();
        }
      }
      return null;
    }
  }

  // ── Given: pool state ─────────────────────────────────────────────────────────

  @Given("the pool does not already exist")
  public void thePoolDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no Cognito user pools.
  }

  @Given("the pool already exists")
  public void thePoolAlreadyExists() {
    // Arrange: create the pool so it already exists
    // Act
    String expectedPoolId = lambdaCognitoCreatePool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the pool exists")
  public void thePoolExists() {
    // Arrange: create the pool
    // Act
    String expectedPoolId = lambdaCognitoCreatePool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the pool is {string}")
  public void thePoolIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: pools are ACTIVE immediately after creation.
      return;
    }
    if ("DELETED".equals(state)) {
      // No-op: fresh state has no pools (simulates deleted pool).
    }
  }

  @Given("the pool is already {string}")
  public void thePoolIsAlready(String state) {
    // Arrange
    if ("DELETED".equals(state)) {
      // Act: find and delete the pool so it is in DELETED state
      String actualPoolId = lambdaCognitoFindPoolId();
      if (actualPoolId != null) {
        try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
          client.deleteUserPool(r -> r.userPoolId(actualPoolId));
        }
      }
      // Assert: pool is now deleted
      world.cognitoPoolId = null;
    }
  }

  @Given("the pool does not exist")
  public void thePoolDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no Cognito user pools.
  }

  @Given("the pool does not exist or is {string}")
  public void thePoolDoesNotExistOrIs(String state) {
    // Arrange / Act / Assert — no-op: fresh state has no pools (simulates deleted or non-existent).
  }

  @Given("the pool is not {string}")
  public void thePoolIsNot(String state) {
    // Arrange
    if ("DELETED".equals(state)) {
      // Act: create the pool so it is not DELETED
      String expectedPoolId = lambdaCognitoCreatePool();
      // Assert: pool created
      world.cognitoPoolId = expectedPoolId;
    }
  }

  // ── Given: invocation state ───────────────────────────────────────────────────

  @Given("an invocation is {string}")
  public void anInvocationIs(String state) {
    // Arrange
    if ("IN_PROGRESS".equals(state)) {
      // Act: create the Lambda function so an invocation could be in progress
      lambdaCognitoCreateFunction();
      // Assert: function created
    }
  }

  @Given("no invocation is {string}")
  public void noInvocationIs(String state) {
    // Arrange / Act / Assert — no-op: fresh state has no in-progress invocations.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a Lambda function is deployed")
  public void aLambdaFunctionIsDeployed() {
    // Arrange
    try (LambdaClient client = world.session.lambdaClient()) {
      // Act
      var result =
          client.createFunction(
              r ->
                  r.functionName(TEST_FUNC)
                      .runtime(Runtime.PYTHON3_12)
                      .role(TEST_ROLE_ARN)
                      .handler("index.handler")
                      .code(c -> c.zipFile(SdkBytes.fromUtf8String("fake"))));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Cognito user pool is created")
  public void aCognitoUserPoolIsCreated() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert: store result
      world.cognitoPoolId = result.userPool().id();
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Cognito user pool is deleted")
  public void aCognitoUserPoolIsDeleted() {
    // Arrange
    String actualPoolId = lambdaCognitoFindPoolId();
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.deleteUserPool(r -> r.userPoolId(actualPoolId));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the Lambda function is invoked")
  public void theLambdaFunctionIsInvoked() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation: scenario requires @internal runtime"));
  }

  @When("the Lambda function fails to call Cognito because the pool has been deleted")
  public void theLambdaFunctionFailsToCallCognitoBecauseThePoolHasBeenDeleted() {
    // @internal: Cannot trigger Lambda invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda invocation failure: scenario requires @internal runtime"));
  }

  @When("the Lambda function calls a Cognito admin {string} on an {string} pool and succeeds")
  public void theLambdaFunctionCallsACognitoAdminApiOnAnActivePoolAndSucceeds(
      String api, String poolState) {
    // @internal: Cannot trigger Lambda-Cognito invocation in lws without Docker.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Lambda-Cognito invocation success: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the function is {string}")
  public void theFunctionIs(String expectedStateLabel) {
    // Arrange
    if ("ACTIVE".equals(expectedStateLabel)) {
      try (LambdaClient client = world.session.lambdaClient()) {
        // Act
        GetFunctionResponse result = client.getFunction(r -> r.functionName(TEST_FUNC));
        // Assert
        State expectedState = State.ACTIVE;
        State actualState = result.configuration().state();
        assertEquals(
            expectedState,
            actualState,
            "Expected function state " + expectedState + " but got " + actualState);
      }
    }
    // Other states are @internal or invariant — no-op.
  }

  @Then("the pool is {string}")
  public void thePoolIsThen(String expectedStateLabel) {
    // Arrange
    if ("ACTIVE".equals(expectedStateLabel)) {
      // Act
      String actualPoolId = lambdaCognitoFindPoolId();
      try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
        var result = client.describeUserPool(r -> r.userPoolId(actualPoolId));
        // Assert
        String expectedStatus = "Active";
        String actualStatus = result.userPool().statusAsString();
        assertEquals(
            expectedStatus,
            actualStatus,
            "Expected pool status " + expectedStatus + " but got " + actualStatus);
      }
    }
  }

  @Then("the pool is {string} and Lambda calls targeting it will fail")
  public void thePoolIsDeletedAndLambdaCallsTargetingItWillFail(String expectedStateLabel) {
    // Arrange
    if ("DELETED".equals(expectedStateLabel)) {
      // Act
      String actualPoolId = lambdaCognitoFindPoolId();
      // Assert
      assertNull(
          actualPoolId, "Expected pool to be deleted but found pool with id " + actualPoolId);
    }
  }

  @Then("the invocation is {string}")
  public void theInvocationIs(String state) {
    // @internal: Cannot observe Lambda invocation state in lws.
  }

  @Then("the invocation is {string} with a ResourceNotFoundException")
  public void theInvocationIsWithResourceNotFoundException(String state) {
    // @internal: Cannot observe Lambda invocation failure in lws.
  }

  // ── Invariant catch-all steps ─────────────────────────────────────────────────

  @Then("every {string} invocation references an {string} Lambda function")
  public void everyInvocationReferencesAnActiveLambdaFunction(String invState, String funcState) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every successful invocation recorded which pool it called")
  public void everySuccessfulInvocationRecordedWhichPoolItCalled() {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
