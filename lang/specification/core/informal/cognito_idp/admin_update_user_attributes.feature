@cognitoidp @generated
Feature: CognitoIdp - An Admin Updates Attributes For A Confirmed "Cognito" "User"

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @minimal @happy @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed "cognito" "user"
    Given the "cognito" "user" existed
    And the "cognito" "user" was "CONFIRMED"
    When an admin updates attributes for a confirmed "cognito" "user"
    Then the "cognito" "user" attributes are updated
    And every "cognito" "user pool" has a valid status ("ACTIVE" or "DELETED")
    And every "cognito" "user" has a valid status
    And every non-deleted "cognito" "user" has an enabled flag set
    And every "cognito" "group" membership references an existing active "cognito" "group"
    And every "cognito" "session" has a valid status
    And deleted "cognito" "user"s do not have active authenticated "cognito" "session"s
    And disabled "cognito" "user"s do not have active authenticated "cognito" "session"s

  @guard @negative @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed "cognito" "user" fails when the "cognito" "user" did not exist
    Given the "cognito" "user" did not exist
    When an admin updates attributes for a confirmed "cognito" "user"
    Then the operation is rejected

  @guard @negative @admin_update_user_attributes
  Scenario: an admin updates attributes for a confirmed "cognito" "user" fails when the "cognito" "user" was not "CONFIRMED"
    Given the "cognito" "user" existed
    And the "cognito" "user" was not "CONFIRMED"
    When an admin updates attributes for a confirmed "cognito" "user"
    Then the operation is rejected
