@apigateway @v2_delete_integration @happy @controlplane @v2
Feature: API Gateway V2 DeleteIntegration

  Scenario: Delete an integration from an HTTP API
    Given a V2 API "e2e-v2-del-int" was created
    And a V2 integration with type "AWS_PROXY" was created
    When I delete the V2 integration
    Then the command will succeed
