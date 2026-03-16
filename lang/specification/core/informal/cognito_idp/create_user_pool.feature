@cognitoidp @generated
Feature: CognitoIdp - A User Pool Is Created

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a user pool is created
    Given the user pool does not already exist
    When a user pool is created
    Then the user pool is "ACTIVE"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @standard @negative @create_user_pool
  Scenario: a user pool is created fails when the user pool already exists
    Given the user pool already exists
    When a user pool is created
    Then the operation is rejected
