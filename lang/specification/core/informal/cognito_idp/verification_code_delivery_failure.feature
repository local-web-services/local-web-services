@cognitoidp @generated
Feature: CognitoIdp - A Verification Code Delivery Fails For An Unconfirmed User

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user
    Given the "cognito" "user" existed
    And the "cognito" "user" was "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed user
    Then the "cognito" "user" remains in "UNCONFIRMED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @guard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a verification code delivery fails for an unconfirmed user
    Then the operation is rejected

  @guard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user fails when the "cognito" "user" was not "UNCONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed user
    Then the operation is rejected
