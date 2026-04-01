@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "Group" Is Deleted

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @delete_group
  Scenario: a "cognito" "group" is deleted
    Given the "cognito" "group" existed
    And the "cognito" "group" was "ACTIVE"
    When a "cognito" "group" is deleted
    Then the "cognito" "group" will be deleted and all users will be removed from it
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @delete_group
  Scenario: a "cognito" "group" is deleted fails when the "cognito" "group" did not exist
    Given the "cognito" "group" did not exist
    When a "cognito" "group" is deleted
    Then the operation is rejected

  @guard @negative @delete_group
  Scenario: a "cognito" "group" is deleted fails when the "cognito" "group" was not "ACTIVE"
    Given the "cognito" "group" existed
    And the "cognito" "group" was not "ACTIVE"
    When a "cognito" "group" is deleted
    Then the operation is rejected
