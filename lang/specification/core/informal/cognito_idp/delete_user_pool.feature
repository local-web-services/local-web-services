@cognitoidp @generated
Feature: CognitoIdp - A User Pool Is Deleted

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a user pool is deleted
    Given the user pool exists
    And the user pool is "ACTIVE"
    When a user pool is deleted
    Then the user pool is "DELETED" along with all its users and groups
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @standard @negative @delete_user_pool
  Scenario: a user pool is deleted fails when the user pool does not exist
    Given the user pool does not exist
    When a user pool is deleted
    Then the operation is rejected

  @standard @negative @delete_user_pool
  Scenario: a user pool is deleted fails when the user pool is not "ACTIVE"
    Given the user pool exists
    And the user pool is not "ACTIVE"
    When a user pool is deleted
    Then the operation is rejected
