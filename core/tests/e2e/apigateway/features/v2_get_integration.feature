@apigateway @v2_get_integration @happy @controlplane @v2
Feature: API Gateway V2 GetIntegration

  Scenario: Get an integration by ID
    Given a V2 API "e2e-v2-get-int" was created
    And a V2 integration with type "AWS_PROXY" was created
    When I get the V2 integration
    Then the command will succeed
    And the output "integrationId" will match the integration ID
