@cognitoidp @generated
Feature: CognitoIdp - A Verification Code Delivery Fails For An Unconfirmed User

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user
    Given the user exists
    And the user is "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed user
    Then the user remains in "UNCONFIRMED" state
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @standard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user fails when the user does not exist
    Given the user does not exist
    When a verification code delivery fails for an unconfirmed user
    Then the operation is rejected

  @standard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed user fails when the user is not "UNCONFIRMED"
    Given the user exists
    And the user is not "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed user
    Then the operation is rejected
