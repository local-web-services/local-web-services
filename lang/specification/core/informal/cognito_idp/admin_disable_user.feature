@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Was "Disabled" By An Admin

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_disable_user
  Scenario: a "cognito" "user" was "DISABLED" by an admin
    Given the "cognito" "user" had an enabled flag
    And the "cognito" "user" was "ENABLED"
    When a "cognito" "user" was "DISABLED" by an admin
    Then the "cognito" "user" will be "DISABLED"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_disable_user
  Scenario: a "cognito" "user" was "DISABLED" by an admin fails when the "cognito" "user" did not have an enabled flag
    Given the "cognito" "user" did not have an enabled flag
    When a "cognito" "user" was "DISABLED" by an admin
    Then the operation is rejected

  @guard @negative @admin_disable_user
  Scenario: a "cognito" "user" was "DISABLED" by an admin fails when the "cognito" "user" was not "ENABLED"
    Given the "cognito" "user" had an enabled flag
    And the "cognito" "user" was not "ENABLED"
    When a "cognito" "user" was "DISABLED" by an admin
    Then the operation is rejected
