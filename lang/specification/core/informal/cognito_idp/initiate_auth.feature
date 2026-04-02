@cognitoidp @generated
Feature: CognitoIdp - A Confirmed Enabled "Cognito" "User" Initiates Authentication

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @initiate_auth
  Scenario: a confirmed enabled "cognito" "user" initiates authentication
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was "ENABLED"
    And the "cognito" "session" slot is available
    When a confirmed enabled "cognito" "user" initiates authentication
    Then a "cognito" "session" will be created in "CHALLENGE_REQUIRED" state
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled "cognito" "user" initiates authentication fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a confirmed enabled "cognito" "user" initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled "cognito" "user" initiates authentication fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When a confirmed enabled "cognito" "user" initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth
  Scenario: a confirmed enabled "cognito" "user" initiates authentication fails when the "cognito" "user" was not "ENABLED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was not "ENABLED"
    When a confirmed enabled "cognito" "user" initiates authentication
    Then the operation is rejected

  @guard @negative @initiate_auth @capacity
  Scenario: a confirmed enabled "cognito" "user" initiates authentication fails when the "cognito" "session" slot is not available
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    And the "cognito" "user" was "ENABLED"
    And the "cognito" "session" slot is not available
    When a confirmed enabled "cognito" "user" initiates authentication
    Then the operation is rejected
