@mock @add_route @controlplane
Feature: Mock Add Route

  @happy
  Scenario: Add a route to a mock server
    Given a mock server "e2e-mock-add-route" was created
    When I add route "/v1/items" with method "GET" and status 200 to "e2e-mock-add-route"
    Then the command will succeed
    And the route file will exist for "/v1/items" with method "GET" in "e2e-mock-add-route"

  @happy
  Scenario: Add a POST route with a custom body
    Given a mock server "e2e-mock-add-post" was created
    When I add route "/v1/orders" with method "POST" and status 201 and body '{"created": true}' to "e2e-mock-add-post"
    Then the command will succeed
    And the route file will exist for "/v1/orders" with method "POST" in "e2e-mock-add-post"

  @happy
  Scenario: Add multiple routes to a mock server
    Given a mock server "e2e-mock-multi-route" was created
    And a route "/v1/alpha" with method "GET" and status 200 was added to "e2e-mock-multi-route"
    When I add route "/v1/beta" with method "POST" and status 201 to "e2e-mock-multi-route"
    Then the command will succeed
    And the route file will exist for "/v1/alpha" with method "GET" in "e2e-mock-multi-route"
    And the route file will exist for "/v1/beta" with method "POST" in "e2e-mock-multi-route"

  @error
  Scenario: Add a route to a nonexistent mock server
    When I add route "/v1/test" with method "GET" and status 200 to "e2e-mock-add-missing"
    Then the command will fail
    And the output will contain "not found"
