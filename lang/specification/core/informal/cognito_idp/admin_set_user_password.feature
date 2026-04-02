@cognitoidp @generated
Feature: CognitoIdp - An Admin Sets A "Cognito" "User" Password

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_set_user_password
  Scenario: an admin sets a "cognito" "user" password
    Given the "cognito" "user" existed
    And the "cognito" "user" is in "RESET_REQUIRED" state
    And the "cognito" "user" is in "FORCE_CHANGE_PASSWORD" state
    When an admin sets a "cognito" "user" password
    Then the "cognito" "user" will be "CONFIRMED"
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a "cognito" "user" password fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin sets a "cognito" "user" password
    Then the operation is rejected

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a "cognito" "user" password fails when the "cognito" "user" is not in "RESET_REQUIRED" state
    Given the "cognito" "user" existed
    And the "cognito" "user" is not in "RESET_REQUIRED" state
    When an admin sets a "cognito" "user" password
    Then the operation is rejected

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a "cognito" "user" password fails when the "cognito" "user" is not in "FORCE_CHANGE_PASSWORD" state
    Given the "cognito" "user" existed
    And the "cognito" "user" is in "RESET_REQUIRED" state
    And the "cognito" "user" is not in "FORCE_CHANGE_PASSWORD" state
    When an admin sets a "cognito" "user" password
    Then the operation is rejected
