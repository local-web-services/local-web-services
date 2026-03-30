@cognitoidp @generated
Feature: CognitoIdp - A Group Is Deleted

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @delete_group
  Scenario: a group is deleted
    Given the group exists
    And the group is "ACTIVE"
    When a group is deleted
    Then the group is "DELETED" and all users are removed from it
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @delete_group
  Scenario: a group is deleted fails when the group does not exist
    Given the group does not exist
    When a group is deleted
    Then the operation is rejected

  @guard @negative @delete_group
  Scenario: a group is deleted fails when the group is not "ACTIVE"
    Given the group exists
    And the group is not "ACTIVE"
    When a group is deleted
    Then the operation is rejected
