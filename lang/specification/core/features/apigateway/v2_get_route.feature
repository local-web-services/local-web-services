@apigateway @v2_get_route @happy @controlplane @v2
Feature: API Gateway V2 GetRoute

  Scenario: Get a route by ID
    Given a V2 API "e2e-v2-get-route" was created
    And a V2 route with key "POST /data" was created
    When I get the V2 route
    Then the command will succeed
    And the output "routeKey" will be "POST /data"
