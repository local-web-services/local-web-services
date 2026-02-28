@cognito_idp @list_users @happy @controlplane
Feature: Cognito ListUsers

  Scenario: List users in a pool
    Given a user pool named "e2e-list-users-pool" was created
    When I list users in pool "e2e-list-users-pool"
    Then the command will succeed
