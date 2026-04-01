@cognitoidp @generated
Feature: CognitoIdp - A Verification Code Delivery Fails For An Unconfirmed "Cognito" "User"

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed "cognito" "user"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed "cognito" "user"
    Then the "cognito" "user" remains in "UNCONFIRMED" state
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed "cognito" "user" fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When a verification code delivery fails for an unconfirmed "cognito" "user"
    Then the operation is rejected

  @guard @negative @verification_code_delivery_failure
  Scenario: a verification code delivery fails for an unconfirmed "cognito" "user" fails when the "cognito" "user" was not "UNCONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "UNCONFIRMED"
    When a verification code delivery fails for an unconfirmed "cognito" "user"
    Then the operation is rejected
