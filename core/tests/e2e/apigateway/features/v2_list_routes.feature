@apigateway @v2_list_routes @happy @controlplane @v2
Feature: API Gateway V2 ListRoutes

  Scenario: List routes for an HTTP API
    Given a V2 API "e2e-v2-list-routes" was created
    And a V2 route with key "GET /orders" was created
    When I list V2 routes
    Then the command will succeed
    And the output will contain an "items" list with at least 1 entry
