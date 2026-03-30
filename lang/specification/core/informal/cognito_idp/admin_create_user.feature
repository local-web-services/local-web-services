@cognitoidp @generated
Feature: CognitoIdp - A User Is Created By An Admin In An Active User Pool

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_create_user
  Scenario: a user is created by an admin in an active user pool
    Given the user pool exists
    And the user pool is "ACTIVE"
    And the user does not already exist
    When a user is created by an admin in an active user pool
    Then the user exists in "FORCE_CHANGE_PASSWORD" state and is enabled
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_create_user
  Scenario: a user is created by an admin in an active user pool fails when the user pool does not exist
    Given the user pool does not exist
    When a user is created by an admin in an active user pool
    Then the operation is rejected

  @guard @negative @admin_create_user
  Scenario: a user is created by an admin in an active user pool fails when the user pool is not "ACTIVE"
    Given the user pool exists
    And the user pool is not "ACTIVE"
    When a user is created by an admin in an active user pool
    Then the operation is rejected

  @guard @negative @admin_create_user
  Scenario: a user is created by an admin in an active user pool fails when the user already exists
    Given the user pool exists
    And the user pool is "ACTIVE"
    And the user already exists
    When a user is created by an admin in an active user pool
    Then the operation is rejected
