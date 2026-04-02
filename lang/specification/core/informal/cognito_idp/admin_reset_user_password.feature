@cognitoidp @generated
Feature: CognitoIdp - An Admin Resets A "Cognito" "User" Password

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_reset_user_password
  Scenario: an admin resets a "cognito" "user" password
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    When an admin resets a "cognito" "user" password
    Then the "cognito" "user" will be in "RESET_REQUIRED" state
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_reset_user_password
  Scenario: an admin resets a "cognito" "user" password fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin resets a "cognito" "user" password
    Then the operation is rejected

  @guard @negative @admin_reset_user_password
  Scenario: an admin resets a "cognito" "user" password fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When an admin resets a "cognito" "user" password
    Then the operation is rejected
