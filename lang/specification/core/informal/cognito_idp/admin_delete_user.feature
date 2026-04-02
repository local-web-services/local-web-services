@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Is Deleted By An Admin

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_delete_user
  Scenario: a "cognito" "user" is deleted by an admin
    Given the "cognito" "user" existed
    And the "cognito" "user" is not already "DELETED"
    When a "cognito" "user" is deleted by an admin
    Then the "cognito" "user" will be deleted, their sessions are expired, and group memberships are cleared
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_delete_user
  Scenario: a "cognito" "user" is deleted by an admin fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a "cognito" "user" is deleted by an admin
    Then the operation is rejected

  @guard @negative @admin_delete_user
  Scenario: a "cognito" "user" is deleted by an admin fails when the "cognito" "user" is already "DELETED"
    Given the "cognito" "user" existed
    And the "cognito" "user" is already "DELETED"
    When a "cognito" "user" is deleted by an admin
    Then the operation is rejected
