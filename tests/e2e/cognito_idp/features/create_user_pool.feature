@cognito_idp @create_user_pool @happy @controlplane
Feature: Cognito CreateUserPool

  Scenario: Create a new user pool
    When I create a user pool named "e2e-create-pool"
    Then the command will succeed
    And the output will contain a user pool named "e2e-create-pool"
    And user pool "e2e-create-pool" will exist
