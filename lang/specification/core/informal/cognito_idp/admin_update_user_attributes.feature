@cognitoidp @generated
Feature: CognitoIdp - An Admin Updates Attributes For A Confirmed User

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed user
    Given the user exists
    And the user is "CONFIRMED"
    When an admin updates attributes for a confirmed user
    Then the user attributes are updated
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed user fails when the user does not exist
    Given the user does not exist
    When an admin updates attributes for a confirmed user
    Then the operation is rejected

  @guard @negative @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed user fails when the user is not "CONFIRMED"
    Given the user exists
    And the user is not "CONFIRMED"
    When an admin updates attributes for a confirmed user
    Then the operation is rejected
