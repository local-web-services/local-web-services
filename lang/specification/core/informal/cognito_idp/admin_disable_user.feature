@cognitoidp @generated
Feature: CognitoIdp - A User Account Is Disabled By An Admin

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_disable_user
  Scenario: a user account is disabled by an admin
    Given the user has an enabled flag
    And the user is enabled
    When a user account is disabled by an admin
    Then the user is disabled
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_disable_user
  Scenario: a user account is disabled by an admin fails when the user does not have an enabled flag
    Given the user does not have an enabled flag
    When a user account is disabled by an admin
    Then the operation is rejected

  @guard @negative @admin_disable_user
  Scenario: a user account is disabled by an admin fails when the user is not enabled
    Given the user has an enabled flag
    And the user is not enabled
    When a user account is disabled by an admin
    Then the operation is rejected
