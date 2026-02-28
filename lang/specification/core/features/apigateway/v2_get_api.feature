@apigateway @v2_get_api @happy @controlplane @v2
Feature: API Gateway V2 GetApi

  Scenario: Get an HTTP API by ID
    Given a V2 API "e2e-v2-get-api" was created
    When I get the V2 API
    Then the command will succeed
    And the output "name" will be "e2e-v2-get-api"
