@cognito_idp @delete_user_pool @happy @controlplane
Feature: Cognito DeleteUserPool

  Scenario: Delete an existing user pool
    Given a user pool named "e2e-del-pool" was created
    When I delete user pool "e2e-del-pool"
    Then the command will succeed
    And the user pool list will not include "e2e-del-pool"
