@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "User Pool" Is Created

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a "cognito" "user pool" is created
    Given the "cognito" "user pool" did not already exist
    When a "cognito" "user pool" is created
    Then the "cognito" "user pool" will be "ACTIVE"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @create_user_pool
  Scenario: a "cognito" "user pool" is created fails when the "cognito" "user pool" already existed
    Given the "cognito" "user pool" already existed
    When a "cognito" "user pool" is created
    Then the operation is rejected
