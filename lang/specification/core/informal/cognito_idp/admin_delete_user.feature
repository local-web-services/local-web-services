@cognitoidp @generated
Feature: CognitoIdp - A User Is Deleted By An Admin

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_delete_user
  Scenario: a user is deleted by an admin
    Given the user exists
    And the user is not already "DELETED"
    When a user is deleted by an admin
    Then the user is "DELETED", their sessions are expired, and group memberships are cleared
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_delete_user
  Scenario: a user is deleted by an admin fails when the user does not exist
    Given the user does not exist
    When a user is deleted by an admin
    Then the operation is rejected

  @guard @negative @admin_delete_user
  Scenario: a user is deleted by an admin fails when the user is already "DELETED"
    Given the user exists
    And the user is already "DELETED"
    When a user is deleted by an admin
    Then the operation is rejected
