@cognitoidp @generated
Feature: CognitoIdp - A Confirmed Enabled User Initiates Authentication

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @initiate_auth
  Scenario: a confirmed enabled user initiates authentication
    Given the user exists
    And the user is "CONFIRMED"
    And the user is enabled
    And the session slot is available
    When a confirmed enabled user initiates authentication
    Then a session is created in "CHALLENGE_REQUIRED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @standard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the user does not exist
    Given the user does not exist
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @standard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the user is not "CONFIRMED"
    Given the user exists
    And the user is not "CONFIRMED"
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @standard @negative @initiate_auth
  Scenario: a confirmed enabled user initiates authentication fails when the user is not enabled
    Given the user exists
    And the user is "CONFIRMED"
    And the user is not enabled
    When a confirmed enabled user initiates authentication
    Then the operation is rejected

  @standard @negative @initiate_auth @capacity @internal
  Scenario: a confirmed enabled user initiates authentication fails when the session slot is not available
    Given the user exists
    And the user is "CONFIRMED"
    And the user is enabled
    And the session slot is not available
    When a confirmed enabled user initiates authentication
    Then the operation is rejected
