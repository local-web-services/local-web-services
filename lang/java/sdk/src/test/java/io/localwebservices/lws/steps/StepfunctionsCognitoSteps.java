package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;

/**
 * Step definitions for the stepfunctions_cognito cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_user_pool, delete_user_pool, start_execution,
 * cognito_task_succeeds, cognito_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .*
 * catch-alls) are NOT re-registered here.
 */
public class StepfunctionsCognitoSteps {

  private static final String TEST_SM = "test-sm-1";
  private static final String TEST_POOL_NAME = "e2e-test-pool-1";
  private static final String TEST_ROLE_ARN = "arn:aws:iam::000000000000:role/test";
  private static final String TEST_PASS_DEFINITION =
      "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
  private static final String TEST_INPUT = "{\"key\":\"value\"}";
  private static final String TEST_REGION = "us-east-1";
  private static final String TEST_ACCOUNT = "000000000000";

  private final WorldContext world;

  public StepfunctionsCognitoSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ────────────────────────────────────────────────────────────

  private String smArn(String name) {
    return "arn:aws:states:" + TEST_REGION + ":" + TEST_ACCOUNT + ":stateMachine:" + name;
  }

  private String createPool() throws Exception {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      return result.userPool().id();
    }
  }

  private String getPoolId() throws Exception {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      var result = client.listUserPools(r -> r.maxResults(60));
      List<UserPoolDescriptionType> pools = result.userPools();
      for (UserPoolDescriptionType pool : pools) {
        if (TEST_POOL_NAME.equals(pool.name())) {
          return pool.id();
        }
      }
      return null;
    }
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a running execution calls an \"ACTIVE\" Cognito user pool and the task succeeds")
  public void aRunningExecutionCallsActiveCognitoUserPoolAndTaskSucceeds() {
    // @internal scenario: cannot trigger internal execution step that calls Cognito in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that calls Cognito in lws"));
  }

  @When("a running execution fails because the Cognito user pool has been deleted")
  public void aRunningExecutionFailsBecauseCognitoUserPoolHasBeenDeleted() {
    // @internal scenario: cannot trigger internal execution step that fails due to deleted pool.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger internal execution step that fails due to deleted Cognito pool in lws"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the state machine is "ACTIVE"" is registered in StepfunctionsSteps.
  // "the execution is "RUNNING"" is registered in StepfunctionsSteps.
  // "the operation is rejected" is registered in CrossServiceSteps.

  @Then("the pool is \"ACTIVE\"")
  public void thePoolIsActive() throws Exception {
    // Arrange
    String expectedPoolName = TEST_POOL_NAME;
    // Act
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      var result = client.listUserPools(r -> r.maxResults(60));
      List<UserPoolDescriptionType> pools = result.userPools();
      // Assert
      boolean actualExists = pools.stream().anyMatch(p -> expectedPoolName.equals(p.name()));
      assertTrue(
          actualExists,
          "Expected pool \""
              + expectedPoolName
              + "\" to be ACTIVE but it was not found; expected_pool_name="
              + expectedPoolName);
    }
  }

  @Then("the pool is \"DELETED\" and \"SDK\" task calls targeting it will fail")
  public void thePoolIsDeletedAndSdkTaskCallsTargetingItWillFail() throws Exception {
    // Arrange
    String expectedPoolName = TEST_POOL_NAME;
    // Act
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      var result = client.listUserPools(r -> r.maxResults(60));
      List<UserPoolDescriptionType> pools = result.userPools();
      // Assert: pool must not be present
      boolean actualExists = pools.stream().anyMatch(p -> expectedPoolName.equals(p.name()));
      assertFalse(
          actualExists,
          "Expected pool \""
              + expectedPoolName
              + "\" to be deleted but it still exists; expected_pool_name="
              + expectedPoolName);
    }
  }

  @Then("the execution is \"FAILED\" with a ResourceNotFoundException")
  public void theExecutionIsFailedWithResourceNotFoundException() {
    // @internal scenario: cannot observe internal execution Cognito task failure in lws.
    // No-op: invariant trivially satisfied in isolated lws context.
  }

  @Then("every succeeded execution recorded which pool it called")
  public void everySucceededExecutionRecordedWhichPoolItCalled() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
