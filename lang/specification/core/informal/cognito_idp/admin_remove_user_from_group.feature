@cognitoidp @generated
Feature: CognitoIdp - An Admin Removes A User From A Group

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_remove_user_from_group
  Scenario: an admin removes a user from a group
    Given the user exists
    And the user is not "DELETED"
    And the group exists
    And the group is "ACTIVE"
    When an admin removes a user from a group
    Then the user is no longer a member of the group
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a user from a group fails when the user does not exist
    Given the user does not exist
    When an admin removes a user from a group
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a user from a group fails when the user is "DELETED"
    Given the user exists
    And the user is "DELETED"
    When an admin removes a user from a group
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a user from a group fails when the group does not exist
    Given the user exists
    And the user is not "DELETED"
    And the group does not exist
    When an admin removes a user from a group
    Then the operation is rejected

  @guard @negative @admin_remove_user_from_group
  Scenario: an admin removes a user from a group fails when the group is not "ACTIVE"
    Given the user exists
    And the user is not "DELETED"
    And the group exists
    And the group is not "ACTIVE"
    When an admin removes a user from a group
    Then the operation is rejected
