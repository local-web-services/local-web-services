@apigateway @v2_create_route @happy @controlplane @v2
Feature: API Gateway V2 CreateRoute

  Scenario: Create a route for an HTTP API
    Given a V2 API "e2e-v2-create-route" was created
    When I create a V2 route with key "GET /items"
    Then the command will succeed
    And the output will contain a "routeId" field
    And the output "routeKey" will be "GET /items"
