@cognito_idp @describe_user_pool_client @happy @controlplane
Feature: Cognito DescribeUserPoolClient

  Scenario: Describe a user pool client
    Given a user pool named "e2e-desc-upc-pool" was created
    And a user pool client named "e2e-desc-client" was created in pool "e2e-desc-upc-pool"
    When I describe the user pool client in pool "e2e-desc-upc-pool"
    Then the command will succeed
