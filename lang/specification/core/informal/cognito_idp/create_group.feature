@cognitoidp @generated
Feature: CognitoIdp - A Group Is Created In An Active User Pool

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @create_group
  Scenario: a group is created in an active user pool
    Given the user pool exists
    And the user pool is "ACTIVE"
    And the group does not already exist
    When a group is created in an active user pool
    Then the group is "ACTIVE" and associated with the pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @create_group
  Scenario: a group is created in an active user pool fails when the user pool does not exist
    Given the user pool does not exist
    When a group is created in an active user pool
    Then the operation is rejected

  @guard @negative @create_group
  Scenario: a group is created in an active user pool fails when the user pool is not "ACTIVE"
    Given the user pool exists
    And the user pool is not "ACTIVE"
    When a group is created in an active user pool
    Then the operation is rejected

  @guard @negative @create_group
  Scenario: a group is created in an active user pool fails when the group already exists
    Given the user pool exists
    And the user pool is "ACTIVE"
    And the group already exists
    When a group is created in an active user pool
    Then the operation is rejected
