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
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @create_user_pool
  Scenario: a "cognito" "user pool" is created fails when the "cognito" "user pool" already existed
    Given the "cognito" "user pool" already existed
    When a "cognito" "user pool" is created
    Then the operation is rejected
