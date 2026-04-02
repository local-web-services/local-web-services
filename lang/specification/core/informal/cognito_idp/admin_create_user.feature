@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User" Is Created By An Admin In An Active "Cognito" "User Pool"

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_create_user
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user" did not already exist
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Then the "cognito" "user" will exist in "FORCE_CHANGE_PASSWORD" state and will be enabled
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_create_user
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @admin_create_user
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @admin_create_user
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" fails when the "cognito" "user" already existed
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "user" already existed
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Then the operation is rejected
