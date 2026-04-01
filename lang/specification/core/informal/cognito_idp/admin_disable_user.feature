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
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

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
