@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Was "Enabled" By An Admin

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_enable_user
  Scenario: a "cognito" "user" was "ENABLED" by an admin
    Given the "cognito" "user" had an enabled flag
    And the "cognito" "user" was "DISABLED"
    When a "cognito" "user" was "ENABLED" by an admin
    Then the "cognito" "user" will be "ENABLED"
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_enable_user
  Scenario: a "cognito" "user" was "ENABLED" by an admin fails when the "cognito" "user" did not have an enabled flag
    Given the "cognito" "user" did not have an enabled flag
    When a "cognito" "user" was "ENABLED" by an admin
    Then the operation is rejected

  @guard @negative @admin_enable_user
  Scenario: a "cognito" "user" was "ENABLED" by an admin fails when the "cognito" "user" was not "DISABLED"
    Given the "cognito" "user" had an enabled flag
    And the "cognito" "user" was not "DISABLED"
    When a "cognito" "user" was "ENABLED" by an admin
    Then the operation is rejected
