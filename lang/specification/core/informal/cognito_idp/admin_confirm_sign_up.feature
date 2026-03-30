@cognitoidp @generated
Feature: CognitoIdp - An Admin Confirms A User Registration

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_confirm_sign_up
  Scenario: an admin confirms a user registration
    Given the user exists
    And the user is "UNCONFIRMED"
    When an admin confirms a user registration
    Then the user is "CONFIRMED"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_confirm_sign_up
  Scenario: an admin confirms a user registration fails when the user does not exist
    Given the user does not exist
    When an admin confirms a user registration
    Then the operation is rejected

  @guard @negative @admin_confirm_sign_up
  Scenario: an admin confirms a user registration fails when the user is not "UNCONFIRMED"
    Given the user exists
    And the user is not "UNCONFIRMED"
    When an admin confirms a user registration
    Then the operation is rejected
