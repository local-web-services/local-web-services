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
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

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
