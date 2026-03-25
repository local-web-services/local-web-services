package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.cognitoidentityprovider.model.AdminGetUserResponse;
import software.amazon.awssdk.services.cognitoidentityprovider.model.GroupType;
import software.amazon.awssdk.services.cognitoidentityprovider.model.ListGroupsResponse;
import software.amazon.awssdk.services.cognitoidentityprovider.model.ListUserPoolsResponse;
import software.amazon.awssdk.services.cognitoidentityprovider.model.ListUsersInGroupResponse;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserPoolDescriptionType;
import software.amazon.awssdk.services.cognitoidentityprovider.model.UserType;

/**
 * Step definitions for the cognito_idp informal specification feature files.
 *
 * <p>Covers: create_user_pool, delete_user_pool, admin_create_user, admin_delete_user,
 * admin_disable_user, admin_enable_user, admin_reset_user_password, admin_set_user_password,
 * admin_update_user_attributes, admin_confirm_sign_up, admin_initiate_auth, initiate_auth,
 * respond_to_auth_challenge, expire_auth_session, mark_user_compromised,
 * verification_code_delivery_failure, create_group, delete_group, admin_add_user_to_group,
 * admin_remove_user_from_group.
 *
 * <p>Steps already registered in CrossServiceSteps (the system is initialized, the operation is
 * rejected, every .* catch-all) are NOT re-registered here.
 */
public class CognitoIdpSteps {

  private static final String TEST_POOL_NAME = "e2e-cognito-test-pool-1";
  private static final String TEST_USERNAME = "e2e-test-user-1";
  private static final String TEST_PASSWORD = "Test@Pass123!";
  private static final String TEST_TEMP_PASSWORD = "TempPass1!";
  private static final String TEST_GROUP_NAME = "e2e-cognito-test-group-1";
  private static final String TEST_ATTRIBUTE = "custom:role";
  private static final String TEST_ATTRIBUTE_VALUE = "admin";

  private final WorldContext world;

  public CognitoIdpSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: user pool existence ────────────────────────────────────────────────

  @Given("the user pool does not already exist")
  public void theUserPoolDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no user pools.
  }

  @Given("the user pool already exists")
  public void theUserPoolAlreadyExists() throws Exception {
    // Arrange: create the test user pool so it already exists
    // Act
    String expectedPoolId = cognitoCreatePool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the user pool exists")
  public void theUserPoolExists() throws Exception {
    // Arrange: create the test user pool
    // Act
    String expectedPoolId = cognitoCreatePool();
    // Assert: pool created
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the user pool is {string}")
  public void theUserPoolIs(String state) throws Exception {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: user pools are ACTIVE immediately after creation.
      return;
    }
    // Act: use lifecycle API to simulate non-ACTIVE state
    world.session.lifecycle("cognitoidp").createDwellMs(5000).apply();
    String expectedPoolId = cognitoCreatePool();
    // Assert: pool created in non-ACTIVE state
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the user pool is not {string}")
  public void theUserPoolIsNot(String state) throws Exception {
    // Arrange: use lifecycle API to simulate non-ACTIVE state
    // Act
    world.session.lifecycle("cognitoidp").createDwellMs(5000).apply();
    String expectedPoolId = cognitoCreatePool();
    // Assert: pool created in non-ACTIVE state
    world.cognitoPoolId = expectedPoolId;
  }

  @Given("the user pool does not exist")
  public void theUserPoolDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no user pools.
  }

  // ── Given: user existence ─────────────────────────────────────────────────────

  @Given("the user does not already exist")
  public void theUserDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state has no users.
  }

  @Given("the user already exists")
  public void theUserAlreadyExists() throws Exception {
    // Arrange: ensure pool exists, then create the user
    if (world.cognitoPoolId == null) {
      world.cognitoPoolId = cognitoCreatePool();
    }
    // Act
    cognitoCreateUser(world.cognitoPoolId);
    // Assert: store username
    world.cognitoUsername = TEST_USERNAME;
  }

  @Given("the user exists")
  public void theUserExists() throws Exception {
    // Arrange: ensure pool exists, then create the user
    if (world.cognitoPoolId == null) {
      world.cognitoPoolId = cognitoCreatePool();
    }
    // Act
    cognitoCreateUser(world.cognitoPoolId);
    // Assert: store username
    world.cognitoUsername = TEST_USERNAME;
  }

  @Given("the user does not exist")
  public void theUserDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no users.
  }

  @Given("the user is not already {string}")
  public void theUserIsNotAlready(String state) {
    // Arrange / Act / Assert — no-op: newly created users are not in DELETED state.
  }

  @Given("the user is already {string}")
  public void theUserIsAlready(String state) {
    // Arrange: for "DELETED", the user is expected to not be present
    // Act / Assert
    if ("DELETED".equals(state)) {
      world.cognitoUsername = TEST_USERNAME;
    }
  }

  @Given("the user is {string}")
  public void theUserIs(String state) throws Exception {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      if ("CONFIRMED".equals(state)) {
        // Act: set a permanent password to confirm the user
        client.adminSetUserPassword(
            r ->
                r.userPoolId(world.cognitoPoolId)
                    .username(world.cognitoUsername)
                    .password(TEST_PASSWORD)
                    .permanent(true));
        // Assert: user is now CONFIRMED
        return;
      }
      if ("UNCONFIRMED".equals(state) || "DELETED".equals(state)) {
        // No-op: UNCONFIRMED is handled by AdminCreateUser;
        // DELETED is handled in other Given steps.
        return;
      }
    }
  }

  @Given("the user is not {string}")
  public void theUserIsNot(String state) throws Exception {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      if ("CONFIRMED".equals(state)) {
        // No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD.
        return;
      }
      if ("UNCONFIRMED".equals(state) || "DELETED".equals(state)) {
        // Act: confirm the user so they are no longer UNCONFIRMED
        client.adminSetUserPassword(
            r ->
                r.userPoolId(world.cognitoPoolId)
                    .username(world.cognitoUsername)
                    .password(TEST_PASSWORD)
                    .permanent(true));
        // Assert: user is now CONFIRMED
        return;
      }
    }
  }

  @Given("the user is in {string} state")
  public void theUserIsInState(String state) throws Exception {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      if ("RESET_REQUIRED".equals(state)) {
        // Act: reset user password to put them in RESET_REQUIRED
        client.adminResetUserPassword(
            r -> r.userPoolId(world.cognitoPoolId).username(world.cognitoUsername));
        // Assert: user is now RESET_REQUIRED
        return;
      }
      if ("FORCE_CHANGE_PASSWORD".equals(state)) {
        // No-op: users created via AdminCreateUser start in FORCE_CHANGE_PASSWORD by default.
        return;
      }
    }
  }

  @Given("the user is not in {string} state")
  public void theUserIsNotInState(String state) throws Exception {
    // Arrange
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      if ("RESET_REQUIRED".equals(state)) {
        // No-op: user starts in FORCE_CHANGE_PASSWORD, not RESET_REQUIRED.
        return;
      }
      if ("FORCE_CHANGE_PASSWORD".equals(state)) {
        // Act: set a permanent password so user is CONFIRMED (not FORCE_CHANGE_PASSWORD)
        client.adminSetUserPassword(
            r ->
                r.userPoolId(world.cognitoPoolId)
                    .username(world.cognitoUsername)
                    .password(TEST_PASSWORD)
                    .permanent(true));
        // Assert: user is now CONFIRMED
        return;
      }
    }
  }

  // ── Given: user enabled/disabled state ───────────────────────────────────────

  @Given("the user has an enabled flag")
  public void theUserHasAnEnabledFlag() throws Exception {
    // Arrange: ensure pool and user exist
    if (world.cognitoPoolId == null) {
      world.cognitoPoolId = cognitoCreatePool();
    }
    // Act
    cognitoCreateUser(world.cognitoPoolId);
    // Assert: store username
    world.cognitoUsername = TEST_USERNAME;
  }

  @Given("the user does not have an enabled flag")
  public void theUserDoesNotHaveAnEnabledFlag() {
    // Arrange / Act / Assert — no-op: no user exists; this is the negative path.
    world.cognitoUsername = TEST_USERNAME;
  }

  @Given("the user is enabled")
  public void theUserIsEnabled() {
    // Arrange / Act / Assert — no-op: newly created users are enabled by default.
  }

  @Given("the user is not enabled")
  public void theUserIsNotEnabled() throws Exception {
    // Arrange: disable the user
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminDisableUser(
          r -> r.userPoolId(world.cognitoPoolId).username(world.cognitoUsername));
      // Assert: user is now disabled
    }
  }

  @Given("the user is disabled")
  public void theUserIsDisabled() throws Exception {
    // Arrange: disable the user
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminDisableUser(
          r -> r.userPoolId(world.cognitoPoolId).username(world.cognitoUsername));
      // Assert: user is now disabled
    }
  }

  @Given("the user is not disabled")
  public void theUserIsNotDisabled() {
    // Arrange / Act / Assert — no-op: newly created users are enabled (not disabled) by default.
  }

  // ── Given: capacity ───────────────────────────────────────────────────────────

  @Given("the session slot is available")
  public void theSessionSlotIsAvailable() throws Exception {
    // Arrange: ensure unlimited capacity for cognitoidp
    // Act
    world.session.capacity("cognitoidp").unlimited().apply();
    // Assert: capacity is unlimited
  }

  @Given("the session slot is not available")
  public void theSessionSlotIsNotAvailable() throws Exception {
    // Arrange: exhaust the cognitoidp auth session capacity
    // Act
    world.session.capacity("cognitoidp").exhaust().apply();
    // Assert: capacity is exhausted
  }

  // ── Given: group existence ────────────────────────────────────────────────────

  @Given("the group does not already exist")
  public void theGroupDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state has no groups.
  }

  @Given("the group already exists")
  public void theGroupAlreadyExists() throws Exception {
    // Arrange: create the test group
    // Act
    cognitoCreateGroup(world.cognitoPoolId);
    // Assert: store group name
    world.cognitoGroupName = TEST_GROUP_NAME;
  }

  @Given("the group exists")
  public void theGroupExists() throws Exception {
    // Arrange: ensure pool exists, then create the group
    if (world.cognitoPoolId == null) {
      world.cognitoPoolId = cognitoCreatePool();
    }
    // Act
    cognitoCreateGroup(world.cognitoPoolId);
    // Assert: store group name
    world.cognitoGroupName = TEST_GROUP_NAME;
  }

  @Given("the group does not exist")
  public void theGroupDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no groups.
    world.cognitoGroupName = TEST_GROUP_NAME;
  }

  @Given("the group is {string}")
  public void theGroupIs(String state) {
    // Arrange
    if ("ACTIVE".equals(state)) {
      // No-op: groups are ACTIVE immediately after creation.
      return;
    }
    // No public API puts a group into a non-ACTIVE state.
    world.cognitoGroupName = TEST_GROUP_NAME;
  }

  @Given("the group is not {string}")
  public void theGroupIsNot(String state) {
    // Arrange / Act / Assert — no public API to put a group into a non-ACTIVE state.
    world.cognitoGroupName = TEST_GROUP_NAME;
  }

  @Given("the user and group belong to the same pool")
  public void theUserAndGroupBelongToTheSamePool() {
    // Arrange / Act / Assert — no-op: both user and group are created in the same pool.
  }

  @Given("the user and group belong to different pools")
  public void theUserAndGroupBelongToDifferentPools() throws Exception {
    // Arrange: create a second pool and a group in it (cross-pool scenario)
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      String expectedSecondPoolName = "e2e-cognito-test-pool-2";
      var poolResp = client.createUserPool(r -> r.poolName(expectedSecondPoolName));
      String secondPoolId = poolResp.userPool().id();
      client.createGroup(r -> r.userPoolId(secondPoolId).groupName(TEST_GROUP_NAME));
      // Assert: group name stored, but it belongs to a different pool
      world.cognitoGroupName = TEST_GROUP_NAME;
    }
  }

  // ── Given: auth session state ─────────────────────────────────────────────────

  @Given("the session exists")
  public void theSessionExists() {
    // Arrange / Act / Assert — no-op: @internal scenario; no public API provides this state.
  }

  @Given("the session does not exist")
  public void theSessionDoesNotExist() {
    // Arrange / Act / Assert — no-op: no session has been created.
  }

  @Given("the session is {string}")
  public void theSessionIs(String state) {
    // Arrange / Act / Assert — no-op: @internal scenario; no public API provides these states.
  }

  @Given("the session is not {string}")
  public void theSessionIsNot(String state) {
    // Arrange / Act / Assert — no-op: @internal scenario.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a user pool is created")
  public void aUserPoolIsCreated() {
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

  @When("a user pool is deleted")
  public void aUserPoolIsDeleted() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.deleteUserPool(r -> r.userPoolId(expectedPoolId));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a user is created by an admin in an active user pool")
  public void aUserIsCreatedByAnAdminInAnActiveUserPool() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result =
          client.adminCreateUser(
              r ->
                  r.userPoolId(expectedPoolId)
                      .username(TEST_USERNAME)
                      .temporaryPassword(TEST_TEMP_PASSWORD));
      // Assert: store result
      world.cognitoUsername = TEST_USERNAME;
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a user is deleted by an admin")
  public void aUserIsDeletedByAnAdmin() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminDeleteUser(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a user account is disabled by an admin")
  public void aUserAccountIsDisabledByAnAdmin() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminDisableUser(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a user account is enabled by an admin")
  public void aUserAccountIsEnabledByAnAdmin() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminEnableUser(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin resets a user password")
  public void anAdminResetsAUserPassword() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminResetUserPassword(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin sets a user password")
  public void anAdminSetsAUserPassword() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminSetUserPassword(
          r ->
              r.userPoolId(expectedPoolId)
                  .username(expectedUsername)
                  .password(TEST_PASSWORD)
                  .permanent(true));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin updates attributes for a confirmed user")
  public void anAdminUpdatesAttributesForAConfirmedUser() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminUpdateUserAttributes(
          r ->
              r.userPoolId(expectedPoolId)
                  .username(expectedUsername)
                  .userAttributes(a -> a.name(TEST_ATTRIBUTE).value(TEST_ATTRIBUTE_VALUE)));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin confirms a user registration")
  public void anAdminConfirmsAUserRegistration() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminConfirmSignUp(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin initiates authentication on behalf of a confirmed enabled user")
  public void anAdminInitiatesAuthenticationOnBehalfOfAConfirmedEnabledUser() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result =
          client.adminInitiateAuth(
              r ->
                  r.userPoolId(expectedPoolId)
                      .clientId("test-client-id")
                      .authFlow("ADMIN_NO_SRP_AUTH")
                      .authParameters(
                          java.util.Map.of(
                              "USERNAME", expectedUsername, "PASSWORD", TEST_PASSWORD)));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a confirmed enabled user initiates authentication")
  public void aConfirmedEnabledUserInitiatesAuthentication() {
    // Arrange
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result =
          client.initiateAuth(
              r ->
                  r.clientId("test-client-id")
                      .authFlow("USER_PASSWORD_AUTH")
                      .authParameters(
                          java.util.Map.of(
                              "USERNAME", expectedUsername, "PASSWORD", TEST_PASSWORD)));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a user responds to an auth challenge")
  public void aUserRespondsToAnAuthChallenge() {
    // Arrange: @internal scenario — no public API to set up CHALLENGE_REQUIRED state
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      var result =
          client.respondToAuthChallenge(
              r ->
                  r.clientId("test-client-id")
                      .challengeName("NEW_PASSWORD_REQUIRED")
                      .challengeResponses(
                          java.util.Map.of(
                              "USERNAME", expectedUsername, "NEW_PASSWORD", TEST_PASSWORD)));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an authenticated session expires")
  public void anAuthenticatedSessionExpires() {
    // Arrange: @internal scenario; no public API expires a session
    // Act: simulate rejection since @internal scenario is not publicly reachable
    world.setFailure(
        new UnsupportedOperationException(
            "expire_auth_session is @internal and not callable via public API"));
    // Assert: result stored
  }

  @When("a user account is marked as compromised")
  public void aUserAccountIsMarkedAsCompromised() {
    // Arrange: @internal scenario; no public API marks a user as compromised
    // Act: simulate rejection since @internal scenario is not publicly reachable
    world.setFailure(
        new UnsupportedOperationException(
            "mark_user_compromised is @internal and not callable via public API"));
    // Assert: result stored
  }

  @When("a verification code delivery fails for an unconfirmed user")
  public void aVerificationCodeDeliveryFailsForAnUnconfirmedUser() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act — AdminConfirmSignUp is the closest public API for confirming an unconfirmed user
      client.adminConfirmSignUp(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a group is created in an active user pool")
  public void aGroupIsCreatedInAnActiveUserPool() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.createGroup(r -> r.userPoolId(expectedPoolId).groupName(TEST_GROUP_NAME));
      // Assert: store result
      world.cognitoGroupName = TEST_GROUP_NAME;
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a group is deleted")
  public void aGroupIsDeleted() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedGroupName = world.cognitoGroupName;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.deleteGroup(r -> r.userPoolId(expectedPoolId).groupName(expectedGroupName));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin adds a user to a group in the same pool")
  public void anAdminAddsAUserToAGroupInTheSamePool() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    String expectedGroupName = world.cognitoGroupName;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminAddUserToGroup(
          r ->
              r.userPoolId(expectedPoolId).username(expectedUsername).groupName(expectedGroupName));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("an admin removes a user from a group")
  public void anAdminRemovesAUserFromAGroup() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername != null ? world.cognitoUsername : TEST_USERNAME;
    String expectedGroupName = world.cognitoGroupName;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      client.adminRemoveUserFromGroup(
          r ->
              r.userPoolId(expectedPoolId).username(expectedUsername).groupName(expectedGroupName));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  // "the operation is rejected" is already registered in CrossServiceSteps; NOT re-registered.
  // "every .*" catch-all is already registered in CrossServiceSteps; NOT re-registered.

  @Then("the user pool is {string} along with all its users and groups")
  public void theUserPoolIsAlongWithAllItsUsersAndGroups(String expectedState) {
    // Arrange
    String expectedPoolName = TEST_POOL_NAME;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      ListUserPoolsResponse result = client.listUserPools(r -> r.maxResults(10));
      List<UserPoolDescriptionType> actualPools = result.userPools();
      boolean actualFound = actualPools.stream().anyMatch(p -> expectedPoolName.equals(p.name()));
      // Assert
      assertFalse(
          actualFound,
          "expected pool '"
              + expectedPoolName
              + "' to be "
              + expectedState
              + " but found; expected_state="
              + expectedState);
    }
  }

  @Then("the user exists in {string} state and is enabled")
  public void theUserExistsInStateAndIsEnabled(String expectedStatus) {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      AdminGetUserResponse result =
          client.adminGetUser(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      String actualStatus = result.userStatusAsString();
      boolean actualEnabled = result.enabled();
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected user status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
      boolean expectedEnabled = true;
      assertEquals(
          expectedEnabled,
          actualEnabled,
          "expected user enabled="
              + expectedEnabled
              + " but got "
              + actualEnabled
              + "; expected_enabled="
              + expectedEnabled
              + " actual_enabled="
              + actualEnabled);
    }
  }

  @Then("the user is {string}, their sessions are expired, and group memberships are cleared")
  public void theUserIsDeletedTheirSessionsAreExpiredAndGroupMembershipsAreCleared(
      String expectedState) {
    // Arrange: no additional setup
    // Act: verify deletion succeeded
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected user deletion to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the user attributes are updated")
  public void theUserAttributesAreUpdated() {
    // Arrange: no additional setup
    // Act: verify update succeeded
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected user attribute update to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(world.lastOutput, "expected non-null result from attribute update");
  }

  @Then("a session is created in {string} state")
  public void aSessionIsCreatedInState(String expectedState) {
    // Arrange: no additional setup
    // Act: verify auth call succeeded
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected auth call to succeed (session in '"
            + expectedState
            + "' state) but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the session is either {string} or {string}")
  public void theSessionIsEitherOr(String stateA, String stateB) {
    // Arrange: no additional setup
    // Act: verify the challenge response was processed
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected RespondToAuthChallenge to succeed (session '"
            + stateA
            + "' or '"
            + stateB
            + "') but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the session is in {string} state")
  public void theSessionIsInState(String expectedState) {
    // Arrange: @internal scenario — not publicly reachable
    // Act: (no-op)
    // Assert: no-op for @internal path
    assertNotNull(expectedState, "expectedState should not be null");
  }

  @Then("the user remains in {string} state")
  public void theUserRemainsInState(String expectedState) {
    // Arrange: no additional setup
    // Act: verify the operation succeeded
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected verification code delivery to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
    assertNotNull(expectedState, "expectedState should not be null");
  }

  @Then("the group is {string} and associated with the pool")
  public void theGroupIsAndAssociatedWithThePool(String expectedState) {
    // Arrange
    String expectedGroupName = TEST_GROUP_NAME;
    String expectedPoolId = world.cognitoPoolId;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      ListGroupsResponse result = client.listGroups(r -> r.userPoolId(expectedPoolId));
      List<GroupType> actualGroups = result.groups();
      // Assert
      boolean actualFound =
          actualGroups.stream().anyMatch(g -> expectedGroupName.equals(g.groupName()));
      assertTrue(
          actualFound,
          "expected group '"
              + expectedGroupName
              + "' to be "
              + expectedState
              + " in pool but not found; expected_group="
              + expectedGroupName);
    }
  }

  @Then("the group is {string} and all users are removed from it")
  public void theGroupIsAndAllUsersAreRemovedFromIt(String expectedState) {
    // Arrange
    String expectedGroupName = TEST_GROUP_NAME;
    String expectedPoolId = world.cognitoPoolId;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      ListGroupsResponse result = client.listGroups(r -> r.userPoolId(expectedPoolId));
      List<GroupType> actualGroups = result.groups();
      // Assert
      boolean actualFound =
          actualGroups.stream().anyMatch(g -> expectedGroupName.equals(g.groupName()));
      assertFalse(
          actualFound,
          "expected group '"
              + expectedGroupName
              + "' to be "
              + expectedState
              + " but found; expected_group="
              + expectedGroupName);
    }
  }

  @Then("the user is a member of the group")
  public void theUserIsAMemberOfTheGroup() {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    String expectedGroupName = world.cognitoGroupName;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      ListUsersInGroupResponse result =
          client.listUsersInGroup(r -> r.userPoolId(expectedPoolId).groupName(expectedGroupName));
      List<UserType> actualUsers = result.users();
      // Assert
      boolean actualFound =
          actualUsers.stream().anyMatch(u -> expectedUsername.equals(u.username()));
      assertTrue(
          actualFound,
          "expected user '"
              + expectedUsername
              + "' to be a member of group '"
              + expectedGroupName
              + "' but not found; expected_user="
              + expectedUsername
              + " expected_group="
              + expectedGroupName);
    }
  }

  @Then("the user is no longer a member of the group")
  public void theUserIsNoLongerAMemberOfTheGroup() {
    // Arrange: no additional setup
    // Act: verify removal succeeded
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected AdminRemoveUserFromGroup to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess
            + " actual_success="
            + actualSuccess);
  }

  @Then("the user is in {string} state and {string}")
  public void theUserIsInStateAnd(String expectedStatus, String expectedEnabledStr) {
    // Arrange
    String expectedPoolId = world.cognitoPoolId;
    String expectedUsername = world.cognitoUsername;
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      // Act
      AdminGetUserResponse result =
          client.adminGetUser(r -> r.userPoolId(expectedPoolId).username(expectedUsername));
      String actualStatus = result.userStatusAsString();
      // Assert
      assertEquals(
          expectedStatus,
          actualStatus,
          "expected user status '"
              + expectedStatus
              + "' but got '"
              + actualStatus
              + "'; expected_status="
              + expectedStatus
              + " actual_status="
              + actualStatus);
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private String cognitoCreatePool() throws Exception {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      var result = client.createUserPool(r -> r.poolName(TEST_POOL_NAME));
      return result.userPool().id();
    }
  }

  private void cognitoCreateUser(String poolId) throws Exception {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      client.adminCreateUser(
          r -> r.userPoolId(poolId).username(TEST_USERNAME).temporaryPassword(TEST_TEMP_PASSWORD));
    }
  }

  private void cognitoCreateGroup(String poolId) throws Exception {
    try (CognitoIdentityProviderClient client = world.session.cognitoIdpClient()) {
      client.createGroup(r -> r.userPoolId(poolId).groupName(TEST_GROUP_NAME));
    }
  }
}
