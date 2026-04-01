@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User Pool" Is Deleted

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    When a "cognito" "user pool" is deleted
    Then the "cognito" "user pool" will be "DELETED" along with all its users and groups
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user pool" is deleted
    Then the operation is rejected

  @guard @negative @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user pool" is deleted
    Then the operation is rejected
