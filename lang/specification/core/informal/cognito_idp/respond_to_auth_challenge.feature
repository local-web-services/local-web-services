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
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

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
