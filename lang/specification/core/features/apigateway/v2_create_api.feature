@apigateway @v2_create_api @happy @controlplane @v2
Feature: API Gateway V2 CreateApi

  Scenario: Create a new HTTP API
    When I create a V2 API named "e2e-v2-create-api"
    Then the command will succeed
    And the output will contain an "apiId" field
    And the output "name" will be "e2e-v2-create-api"
