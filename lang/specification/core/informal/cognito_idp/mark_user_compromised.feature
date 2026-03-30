@cognitoidp @generated
Feature: CognitoIdp - A User Account Is Marked As Compromised

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @mark_user_compromised @internal
  Scenario: a user account is marked as compromised
    Given the user exists
    And the user is "CONFIRMED"
    When a user account is marked as compromised
    Then the user is in "COMPROMISED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @mark_user_compromised @internal
  Scenario: a user account is marked as compromised fails when the user does not exist
    Given the user does not exist
    When a user account is marked as compromised
    Then the operation is rejected

  @guard @negative @mark_user_compromised @internal
  Scenario: a user account is marked as compromised fails when the user is not "CONFIRMED"
    Given the user exists
    And the user is not "CONFIRMED"
    When a user account is marked as compromised
    Then the operation is rejected
