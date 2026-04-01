@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Responds To An Auth Challenge

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @respond_to_auth_challenge
  Scenario: a "cognito" "user" responds to an auth challenge
    Given the "cognito" "session" existed
    And the "cognito" "session" was "CHALLENGE_REQUIRED"
    When a "cognito" "user" responds to an auth challenge
    Then the "cognito" "session" will be either "AUTHENTICATED" or "CHALLENGE_FAILED"
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @respond_to_auth_challenge
  Scenario: a "cognito" "user" responds to an auth challenge fails when the "cognito" "session" did not exist
    Given the "cognito" "session" did not exist
    When a "cognito" "user" responds to an auth challenge
    Then the operation is rejected

  @guard @negative @respond_to_auth_challenge
  Scenario: a "cognito" "user" responds to an auth challenge fails when the "cognito" "session" was not "CHALLENGE_REQUIRED"
    Given the "cognito" "session" existed
    And the "cognito" "session" was not "CHALLENGE_REQUIRED"
    When a "cognito" "user" responds to an auth challenge
    Then the operation is rejected
