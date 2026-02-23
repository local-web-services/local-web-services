@apigateway @v2_delete_route @happy @controlplane @v2
Feature: API Gateway V2 DeleteRoute

  Scenario: Delete a route from an HTTP API
    Given a V2 API "e2e-v2-del-route" was created
    And a V2 route with key "DELETE /temp" was created
    When I delete the V2 route
    Then the command will succeed
