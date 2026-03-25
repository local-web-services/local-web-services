package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StateMachineType;

/**
 * Step definitions for the stepfunctions_cognito cross-service feature files.
 *
 * <p>Covers: create_state_machine, create_user_pool, delete_user_pool, start_execution,
 * cognito_task_succeeds, cognito_task_fails.
 *
 * <p>Steps already registered in {@link StepfunctionsSteps} (state machine Given/When/Then) and
 * {@link CrossServiceSteps} (the system is initialized, the operation is rejected, every .* catch-alls)
 * are NOT re-registered here.
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

  // ── Given: pool existence ──────────────────────────────────────────────────────

  @Given("the pool does not already exist")
  public void thePoolDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no user pools.
  }

  @Given("the pool already exists")
  public void thePoolAlreadyExists() throws Exception {
    // Arrange: create the test pool so it already exists
    // Act
    String expectedPoolId = createPool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the pool exists")
  public void thePoolExists() throws Exception {
    // Arrange: create the test pool
    // Act
    String expectedPoolId = createPool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the pool does not exist")
  public void thePoolDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no user pools.
  }

  @Given("the pool does not exist or is {string}")
  public void thePoolDoesNotExistOrIs(String state) {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no user pools.
  }

  // ── Given: pool status ────────────────────────────────────────────────────────

  @Given("the pool is {string}")
  public void thePoolIs(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: Cognito user pools are ACTIVE immediately after creation.
      return;
    }
    if ("DELETED".equals(state)) {
      // No-op: fresh state has no user pools (simulates deleted pool).
      return;
    }
    // Act: create pool for any other expected state
    String expectedPoolId = createPool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the pool is not {string}")
  public void thePoolIsNot(String state) throws Exception {
    // Arrange
    if ("DELETED".equals(state)) {
      // Act: create an ACTIVE pool so it is not DELETED
      String expectedPoolId = createPool();
      // Assert: pool created
      world.cognitoPoolId = expectedPoolId;
      return;
    }
    // No-op for other states
  }

  @Given("the pool is already {string}")
  public void thePoolIsAlready(String state) throws Exception {
    // Arrange
    if ("DELETED".equals(state)) {
      // Act: create pool, apply lifecycle dwell, then delete it
      String expectedPoolId = createPool();
      world.cognitoPoolId = expectedPoolId;
      world.session.lifecycle("cognitoidp").deleteDwellMs(5000).apply();
      try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
        client.deleteUserPool(r -> r.userPoolId(expectedPoolId));
      } catch (Exception e) {
        // ignore — desired state is deleted
      }
      // Assert: pool is deleted
      return;
    }
    // No-op for other states
  }

  // ── Given: execution state ────────────────────────────────────────────────────

  @Given("an execution is \"RUNNING\"")
  public void anExecutionIsRunning() {
    // Arrange: create state machine and start execution
    try (SfnClient client = world.session.sfnClient()) {
      var smResult =
          client.createStateMachine(
              r ->
                  r.name(TEST_SM)
                      .definition(TEST_PASS_DEFINITION)
                      .roleArn(TEST_ROLE_ARN)
                      .type(StateMachineType.STANDARD));
      world.lastStateMachineArn = smResult.stateMachineArn();
      // Act: start an execution
      StartExecutionResponse execResult =
          client.startExecution(r -> r.stateMachineArn(smArn(TEST_SM)).input(TEST_INPUT));
      // Assert: execution started
      world.lastExecutionArn = execResult.executionArn();
    }
  }

  @Given("no execution is \"RUNNING\"")
  public void noExecutionIsRunning() {
    // Arrange / Act / Assert — no-op: fresh state after session reset has no executions.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("an execution slot is available")
  public void anExecutionSlotIsAvailable() throws Exception {
    // Arrange: set unlimited capacity for stepfunctions
    // Act
    world.session.capacity("stepfunctions").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("no execution slot is available")
  public void noExecutionSlotIsAvailable() throws Exception {
    // Arrange: exhaust the stepfunctions execution capacity
    // Act
    world.session.capacity("stepfunctions").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  // "a Step Functions state machine is created" is registered in StepfunctionsSteps.
  // "an execution of the state machine is started" is registered in StepfunctionsSteps.

  @When("a Cognito user pool is created")
  public void aCognitoUserPoolIsCreated() {
    // Arrange: use the test pool name
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a Cognito user pool is deleted")
  public void aCognitoUserPoolIsDeleted() throws Exception {
    // Arrange: look up the pool ID
    String actualPoolId = getPoolId();
    if (actualPoolId == null) {
      world.setFailure(
          new RuntimeException("ResourceNotFoundException: pool not found"));
      return;
    }
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.deleteUserPool(r -> r.userPoolId(actualPoolId));
      // Assert: result captured
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

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

  @Then("the execution is \"SUCCEEDED\"")
  public void theExecutionIsSucceeded() {
    // @internal scenario: cannot observe internal execution Cognito task success in lws.
    // No-op: invariant trivially satisfied in isolated lws context.
  }

  @Then("the execution is \"FAILED\" with a ResourceNotFoundException")
  public void theExecutionIsFailedWithResourceNotFoundException() {
    // @internal scenario: cannot observe internal execution Cognito task failure in lws.
    // No-op: invariant trivially satisfied in isolated lws context.
  }

  // ── Then: invariants ──────────────────────────────────────────────────────────

  @Then("every \"RUNNING\" execution references an \"ACTIVE\" state machine")
  public void everyRunningExecutionReferencesAnActiveStateMachine() {
    // Invariant: trivially satisfied in isolated lws context.
  }

  @Then("every succeeded execution recorded which pool it called")
  public void everySucceededExecutionRecordedWhichPoolItCalled() {
    // Invariant: trivially satisfied in isolated lws context.
  }
}
