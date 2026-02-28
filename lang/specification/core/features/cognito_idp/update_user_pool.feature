@cognito_idp @update_user_pool @happy @controlplane
Feature: Cognito UpdateUserPool

  Scenario: Update an existing user pool
    Given a user pool named "e2e-update-pool" was created
    When I update user pool "e2e-update-pool"
    Then the command will succeed
