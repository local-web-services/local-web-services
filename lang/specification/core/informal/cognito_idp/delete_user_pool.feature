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
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

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
