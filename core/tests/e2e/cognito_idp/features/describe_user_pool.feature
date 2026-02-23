@cognito_idp @describe_user_pool @happy @controlplane
Feature: Cognito DescribeUserPool

  Scenario: Describe an existing user pool
    Given a user pool named "e2e-desc-pool" was created
    When I describe user pool "e2e-desc-pool"
    Then the command will succeed
    And the output will contain a user pool named "e2e-desc-pool"
