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
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

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
