@cognitoidp @generated
Feature: CognitoIdp - An Admin Sets A User Password

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_set_user_password
  Scenario: an admin sets a user password
    Given the user exists
    And the user is in "RESET_REQUIRED" state
    And the user is in "FORCE_CHANGE_PASSWORD" state
    When an admin sets a user password
    Then the user is "CONFIRMED"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a user password fails when the user does not exist
    Given the user does not exist
    When an admin sets a user password
    Then the operation is rejected

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a user password fails when the user is not in "RESET_REQUIRED" state
    Given the user exists
    And the user is not in "RESET_REQUIRED" state
    When an admin sets a user password
    Then the operation is rejected

  @guard @negative @admin_set_user_password
  Scenario: an admin sets a user password fails when the user is not in "FORCE_CHANGE_PASSWORD" state
    Given the user exists
    And the user is in "RESET_REQUIRED" state
    And the user is not in "FORCE_CHANGE_PASSWORD" state
    When an admin sets a user password
    Then the operation is rejected
