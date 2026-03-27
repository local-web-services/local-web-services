@cognitoidp @generated
Feature: CognitoIdp - An Admin Initiates Authentication On Behalf Of A Confirmed Enabled User

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_initiate_auth
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user
    Given the user exists
    And the user is "CONFIRMED"
    And the user is enabled
    And the session slot is available
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then a session is created in "AUTHENTICATED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @standard @negative @admin_initiate_auth
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user fails when the user does not exist
    Given the user does not exist
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then the operation is rejected

  @standard @negative @admin_initiate_auth
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user fails when the user is not "CONFIRMED"
    Given the user exists
    And the user is not "CONFIRMED"
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then the operation is rejected

  @standard @negative @admin_initiate_auth
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user fails when the user is not enabled
    Given the user exists
    And the user is "CONFIRMED"
    And the user is not enabled
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then the operation is rejected

  @standard @negative @internal @admin_initiate_auth @capacity
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user fails when the session slot is not available
    Given the user exists
    And the user is "CONFIRMED"
    And the user is enabled
    And the session slot is not available
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then the operation is rejected
