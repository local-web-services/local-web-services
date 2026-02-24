@cognito_idp @list_user_pools @happy @controlplane
Feature: Cognito ListUserPools

  Scenario: List user pools includes a created pool
    Given a user pool named "e2e-list-pools" was created
    When I list user pools
    Then the command will succeed
    And the user pool list will include "e2e-list-pools"
