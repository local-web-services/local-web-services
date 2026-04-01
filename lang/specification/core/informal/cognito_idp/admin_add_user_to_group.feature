@cognitoidp @generated
Feature: CognitoIdp - An Admin Adds A "Cognito" "User" To A "Cognito" "Group" In The Same Pool

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" existed
    And the "cognito" "group" was "ACTIVE"
    And the "cognito" "user" and group belonged to the same pool
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the "cognito" "user" will be a member of the "cognito" "group"
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the operation is rejected

  @guard @negative @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool fails when the "cognito" "user" was "DELETED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "DELETED"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the operation is rejected

  @guard @negative @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool fails when the "cognito" "group" did not exist
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" did not exist
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the operation is rejected

  @guard @negative @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool fails when the "cognito" "group" was not "ACTIVE"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" existed
    And the "cognito" "group" was not "ACTIVE"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the operation is rejected

  @guard @negative @admin_add_user_to_group
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool fails when the "cognito" "user" and group belonged to different pools
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "DELETED"
    And the "cognito" "group" existed
    And the "cognito" "group" was "ACTIVE"
    And the "cognito" "user" and group belonged to different pools
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Then the operation is rejected
