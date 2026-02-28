@apigateway @cors_preflight @happy @dataplane @v2
Feature: API Gateway V2 CORS Preflight

  Scenario: OPTIONS request returns CORS headers
    Given a V2 API "e2e-cors-preflight" was created with CORS allowing all origins
    And a V2 integration with type "AWS_PROXY" was created
    And a V2 route with key "GET /e2e-cors-items" targeting the integration was created
    When I test invoke OPTIONS on "/e2e-cors-items" with origin "http://example.com"
    Then the command will succeed
    And the invoke response status will be 204
    And the invoke response header "access-control-allow-origin" will contain "*"
