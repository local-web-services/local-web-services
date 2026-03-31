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
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

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
