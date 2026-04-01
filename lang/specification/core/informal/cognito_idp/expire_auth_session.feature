@cognitoidp @generated
Feature: CognitoIdp - An Authenticated Session Expires

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @expire_auth_session @internal
  Scenario: an authenticated session expires
    Given the "cognito" "session" existed
    And the "cognito" "session" was "AUTHENTICATED"
    When an authenticated session expires
    Then the "cognito" "session" will be in "EXPIRED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @expire_auth_session @internal
  Scenario: an authenticated session expires fails when the "cognito" "session" did not exist
    Given the "cognito" "session" did not exist
    When an authenticated session expires
    Then the operation is rejected

  @guard @negative @expire_auth_session @internal
  Scenario: an authenticated session expires fails when the "cognito" "session" was not "AUTHENTICATED"
    Given the "cognito" "session" existed
    And the "cognito" "session" was not "AUTHENTICATED"
    When an authenticated session expires
    Then the operation is rejected
