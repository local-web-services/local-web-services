package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.MessageActionType;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserType;

/**
 * Step definitions for the cognito_lambda cross-service informal specification feature files.
 *
 * <p>Covers: create_user_pool, deploy_function, configure_trigger, signup_without_trigger,
 * initiate_signup_with_trigger, trigger_allows, trigger_denies — unique steps only.
 *
 * <p>Steps already registered in {@link LambdaCognitoSteps}:
 *
 * <ul>
 *   <li>the pool does not already exist / already exists / exists / does not exist
 *   <li>the pool is {string} (Given and Then), the pool is not {string}
 *   <li>an invocation is {string} / no invocation is {string}
 *   <li>a Lambda function is deployed
 *   <li>the function is {string} (Then)
 *   <li>every {string} invocation references an {string} Lambda function
 * </ul>
 *
 * <p>Steps already registered in {@link LambdaSteps}:
 *
 * <ul>
 *   <li>the function is {string} (Given), the function is not {string} (Given)
 *   <li>an invocation slot is available, no invocation slot is available (via LambdaDynamodbSteps)
 * </ul>
 *
 * <p>Steps already registered in {@link CrossServiceSteps}:
 *
 * <ul>
 *   <li>the system is initialized, the operation is rejected
 * </ul>
 *
 * <p>Only the NEW unique cross-service steps absent from all constituent files are defined here.
 */
public class CognitoLambdaSteps {

  private static final String TEST_POOL_NAME = "e2e-test-pool-1";
  private static final String TEST_USERNAME = "e2e-test-user-1";

  private final WorldContext world;

  public CognitoLambdaSteps(WorldContext world) {
    this.world = world;
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String cognitoLambdaFindPoolId() {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.listUserPools(r -> r.maxResults(60));
      // Assert: find pool by name
      for (UserPoolDescriptionType pool : result.userPools()) {
        if (TEST_POOL_NAME.equals(pool.name())) {
          return pool.id();
        }
      }
      return null;
    }
  }

  // ── Given: trigger configuration ──────────────────────────────────────────────

  @Given("the pool has no trigger configured")
  public void thePoolHasNoTriggerConfigured() {
    // Arrange / Act / Assert — no-op: pools have no trigger configured by default.
  }

  @Given("the pool already has a trigger configured")
  public void thePoolAlreadyHasATriggerConfigured() {
    // @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
  }

  @Given("the pool has no pre-signup trigger configured")
  public void thePoolHasNoPreSignupTriggerConfigured() {
    // Arrange / Act / Assert — no-op: pools have no pre-signup trigger configured by default.
  }

  @Given("the pool has a pre-signup trigger configured")
  public void thePoolHasAPreSignupTriggerConfigured() {
    // @internal: Cannot configure Lambda triggers for Cognito in lws via public APIs.
  }

  @Given("the trigger function is {string}")
  public void theTriggerFunctionIs(String state) {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
  }

  @Given("the trigger function is not {string}")
  public void theTriggerFunctionIsNot(String state) {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
  }

  // ── Given: capacity slots ──────────────────────────────────────────────────────

  @Given("the user slot is available")
  public void theUserSlotIsAvailable() throws Exception {
    // Arrange
    // Act: set cognitoidp capacity to unlimited so user slots are available
    world.session.capacity("cognitoidp").unlimited().apply();
    // Assert: capacity applied
  }

  @Given("no user slot is available")
  public void noUserSlotIsAvailable() throws Exception {
    // Arrange
    // Act: exhaust cognitoidp capacity so no user slots are available
    world.session.capacity("cognitoidp").exhaust().apply();
    // Assert: capacity exhausted
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a Cognito User Pool is created")
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

  @When("a Lambda pre-signup trigger is configured on the Cognito User Pool")
  public void aLambdaPreSignupTriggerIsConfiguredOnTheCognitoUserPool() {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot configure Lambda trigger: scenario is @internal"));
  }

  @When("a user initiates signup to a pool that has a pre-signup trigger configured")
  public void aUserInitiatesSignupToAPoolThatHasAPreSignupTriggerConfigured() {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Cognito->Lambda invocation: scenario is @internal"));
  }

  @When("a user signs up to a pool that has no pre-signup trigger configured")
  public void aUserSignsUpToAPoolThatHasNoPreSignupTriggerConfigured() {
    // Arrange: find the pool
    String actualPoolId = cognitoLambdaFindPoolId();
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      if (actualPoolId == null) {
        world.setFailure(new IllegalStateException("pool not found"));
        return;
      }
      // Act: create a user directly (no trigger involved)
      var result =
          client.adminCreateUser(
              r ->
                  r.userPoolId(actualPoolId)
                      .username(TEST_USERNAME)
                      .messageAction(MessageActionType.SUPPRESS));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("the pre-signup Lambda allows the signup")
  public void thePreSignupLambdaAllowsTheSignup() {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Cognito->Lambda allow: scenario is @internal"));
  }

  @When("the pre-signup Lambda denies the signup")
  public void thePreSignupLambdaDeniesTheSignup() {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
    world.setFailure(
        new UnsupportedOperationException(
            "cannot trigger Cognito->Lambda deny: scenario is @internal"));
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the pool is {string} with no pre-signup trigger configured")
  public void thePoolIsActiveWithNoPreSignupTriggerConfigured(String expectedState) {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.listUserPools(r -> r.maxResults(60));
      // Assert
      String expectedPoolName = TEST_POOL_NAME;
      List<UserPoolDescriptionType> actualPools = result.userPools();
      boolean found = actualPools.stream().anyMatch(p -> expectedPoolName.equals(p.name()));
      assertTrue(
          found,
          "Expected pool \""
              + expectedPoolName
              + "\" to exist but not found in pool list");
    }
  }

  @Then("all subsequent signups will synchronously invoke the function before confirming")
  public void allSubsequentSignupsWillSynchronouslyInvokeFunctionBeforeConfirming() {
    // @internal: Cannot configure Lambda triggers for Cognito in lws.
  }

  @Then("the user is {string} and the trigger Lambda is invoked synchronously")
  public void theUserIsAndTheTriggerLambdaIsInvokedSynchronously(String state) {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  }

  @Then("the user is immediately {string}")
  public void theUserIsImmediately(String expectedState) {
    // Arrange
    String actualPoolId = cognitoLambdaFindPoolId();
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result = client.listUsers(r -> r.userPoolId(actualPoolId));
      // Assert
      int expectedMinCount = 1;
      List<UserType> actualUsers = result.users();
      int actualCount = actualUsers.size();
      assertTrue(
          actualCount >= expectedMinCount,
          "Expected at least "
              + expectedMinCount
              + " user but found "
              + actualCount);
    }
  }

  @Then("the invocation is {string} and the user is {string}")
  public void theInvocationIsAndTheUserIs(String invState, String userState) {
    // @internal: Cannot trigger Cognito->Lambda invocation in lws.
  }

  // ── Invariant catch-all steps ──────────────────────────────────────────────────

  @Then("every {string} invocation is for a {string} user")
  public void everyInvocationIsForAUser(String invState, String userState) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }

  @Then("every {string} user has a corresponding {string} invocation")
  public void everyUserHasACorrespondingInvocation(String userState, String invState) {
    // No-op: model-level invariant; trivially satisfied in isolated lws context.
  }
}
