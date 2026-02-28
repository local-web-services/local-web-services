@apigateway @v2_cors_configuration @happy @controlplane @v2
Feature: API Gateway V2 CORS Configuration

  Scenario: Create a V2 API with CORS configuration
    When I create a V2 API named "e2e-cors-config" with CORS allowing all origins
    Then the command will succeed
    And the output will contain a "corsConfiguration" field

  Scenario: Get a V2 API returns CORS configuration
    Given a V2 API "e2e-cors-get" was created with CORS allowing all origins
    When I get the V2 API
    Then the command will succeed
    And the output will contain a "corsConfiguration" field
