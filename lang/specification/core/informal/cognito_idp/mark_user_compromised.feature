@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Is Marked As Compromised

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @mark_user_compromised @internal
  Scenario: a "cognito" "user" is marked as compromised
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    When a "cognito" "user" is marked as compromised
    Then the "cognito" "user" will be in "COMPROMISED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @mark_user_compromised @internal
  Scenario: a "cognito" "user" is marked as compromised fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a "cognito" "user" is marked as compromised
    Then the operation is rejected

  @guard @negative @mark_user_compromised @internal
  Scenario: a "cognito" "user" is marked as compromised fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When a "cognito" "user" is marked as compromised
    Then the operation is rejected
