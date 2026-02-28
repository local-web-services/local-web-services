@apigateway @v2_create_integration @happy @controlplane @v2
Feature: API Gateway V2 CreateIntegration

  Scenario: Create an integration for an HTTP API
    Given a V2 API "e2e-v2-create-int" was created
    When I create a V2 integration with type "AWS_PROXY"
    Then the command will succeed
    And the output will contain an "integrationId" field
    And the output "integrationType" will be "AWS_PROXY"
