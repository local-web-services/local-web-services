@cognitoidp @generated
Feature: CognitoIdp - A "Cognito" "Group" Is Created In An Active "Cognito" "User Pool"

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @create_group
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "group" did not already exist
    When a "cognito" "group" is created in an active "cognito" "user pool"
    Then the "cognito" "group" will be "ACTIVE" and associated with the "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @create_group
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "group" is created in an active "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @create_group
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" fails when the "cognito" "user pool" was not "ACTIVE"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was not "ACTIVE"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    Then the operation is rejected

  @guard @negative @create_group
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" fails when the "cognito" "group" already existed
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    And the "cognito" "group" already existed
    When a "cognito" "group" is created in an active "cognito" "user pool"
    Then the operation is rejected
