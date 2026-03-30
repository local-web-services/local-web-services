@cognitoidp @generated
Feature: CognitoIdp - A User Responds To An Auth Challenge

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @respond_to_auth_challenge
  Scenario: a user responds to an auth challenge
    Given the session exists
    And the session is "CHALLENGE_REQUIRED"
    When a user responds to an auth challenge
    Then the session is either "AUTHENTICATED" or "CHALLENGE_FAILED"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @respond_to_auth_challenge
  Scenario: a user responds to an auth challenge fails when the session does not exist
    Given the session does not exist
    When a user responds to an auth challenge
    Then the operation is rejected

  @guard @negative @respond_to_auth_challenge
  Scenario: a user responds to an auth challenge fails when the session is not "CHALLENGE_REQUIRED"
    Given the session exists
    And the session is not "CHALLENGE_REQUIRED"
    When a user responds to an auth challenge
    Then the operation is rejected
