@cognitoidp @generated
Feature: CognitoIdp - An Admin Confirms A "Cognito" "User" Registration

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_confirm_sign_up
  Scenario: an admin confirms a "cognito" "user" registration
    Given the "cognito" "user" existed
    And the "cognito" "user" was "UNCONFIRMED"
    When an admin confirms a "cognito" "user" registration
    Then the "cognito" "user" will be "CONFIRMED"
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_confirm_sign_up
  Scenario: an admin confirms a "cognito" "user" registration fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin confirms a "cognito" "user" registration
    Then the operation is rejected

  @guard @negative @admin_confirm_sign_up
  Scenario: an admin confirms a "cognito" "user" registration fails when the "cognito" "user" was not "UNCONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "UNCONFIRMED"
    When an admin confirms a "cognito" "user" registration
    Then the operation is rejected
