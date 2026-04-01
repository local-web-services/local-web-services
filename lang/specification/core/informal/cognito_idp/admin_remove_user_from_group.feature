@cognitoidp @generated
Feature: CognitoIdp - An Admin Removes A "Cognito" "User" From A "Cognito" "Group"

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_remove_user_from_group
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" existed
    And the "cognito" "group" was "ACTIVE"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    Then the "cognito" "user" will no longer be a member of the "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin removes a "cognito" "user" from a "cognito" "group"
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" fails when the "cognito" "user" was "DELETED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "DELETED"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" fails when the "cognito" "group" did not exist
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" did not exist
    When an admin removes a "cognito" "user" from a "cognito" "group"
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" fails when the "cognito" "group" was not "ACTIVE"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" existed
    And the "cognito" "group" was not "ACTIVE"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    Then the operation is rejected
