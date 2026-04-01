@cognitoidp @generated
Feature: CognitoIdp - A Confirmed Enabled User Initiates Authentication

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @initiate_auth
  Scenario: a confirmed enabled user initiates authentication
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was "ENABLED"
    And the "cognito" "session" slot is available
    When a confirmed enabled user initiates authentication
    Then a "cognito" "session" will be created in "CHALLENGE_REQUIRED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the "cognito" "user" was not "ENABLED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was not "ENABLED"
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth @capacity
  Scenario: a confirmed enabled user initiates authentication fails when the "cognito" "session" slot is not available
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was "ENABLED"
    And the "cognito" "session" slot is not available
    When a confirmed enabled user initiates authentication
    Then the operation is rejected
