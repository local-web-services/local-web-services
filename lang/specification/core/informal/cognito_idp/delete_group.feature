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
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

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
