@cognito_idp @create_user_pool_client @happy @controlplane
Feature: Cognito CreateUserPoolClient

  Scenario: Create a user pool client
    Given a user pool named "e2e-create-upc-pool" was created
    When I create a user pool client named "e2e-test-client" in pool "e2e-create-upc-pool"
    Then the command will succeed
