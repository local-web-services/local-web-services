@cognitoidp @generated
Feature: CognitoIdp - An Authenticated "Cognito" "Session" Expires

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @expire_auth_session @internal
  Scenario: an authenticated "cognito" "session" expires
    Given the "cognito" "session" existed
    And the "cognito" "session" was "AUTHENTICATED"
    When an authenticated "cognito" "session" expires
    Then the "cognito" "session" will be in "EXPIRED" state
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @expire_auth_session @internal
  Scenario: an authenticated "cognito" "session" expires fails when the "cognito" "session" did not exist
    Given the "cognito" "session" did not exist
    When an authenticated "cognito" "session" expires
    Then the operation is rejected

  @guard @negative @expire_auth_session @internal
  Scenario: an authenticated "cognito" "session" expires fails when the "cognito" "session" was not "AUTHENTICATED"
    Given the "cognito" "session" existed
    And the "cognito" "session" was not "AUTHENTICATED"
    When an authenticated "cognito" "session" expires
    Then the operation is rejected
