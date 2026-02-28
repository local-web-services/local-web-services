@fake @add_route @controlplane
Feature: Fake Add Route

  @happy
  Scenario: Add a route to a fake server
    Given a fake server "e2e-fake-add-route" was created
    When I add route "/v1/items" with method "GET" and status 200 to "e2e-fake-add-route"
    Then the command will succeed
    And the route file will exist for "/v1/items" with method "GET" in "e2e-fake-add-route"

  @happy
  Scenario: Add a POST route with a custom body
    Given a fake server "e2e-fake-add-post" was created
    When I add route "/v1/orders" with method "POST" and status 201 and body '{"created": true}' to "e2e-fake-add-post"
    Then the command will succeed
    And the route file will exist for "/v1/orders" with method "POST" in "e2e-fake-add-post"

  @happy
  Scenario: Add multiple routes to a fake server
    Given a fake server "e2e-fake-multi-route" was created
    And a route "/v1/alpha" with method "GET" and status 200 was added to "e2e-fake-multi-route"
    When I add route "/v1/beta" with method "POST" and status 201 to "e2e-fake-multi-route"
    Then the command will succeed
    And the route file will exist for "/v1/alpha" with method "GET" in "e2e-fake-multi-route"
    And the route file will exist for "/v1/beta" with method "POST" in "e2e-fake-multi-route"

  @error
  Scenario: Add a route to a nonexistent fake server
    When I add route "/v1/test" with method "GET" and status 200 to "e2e-fake-add-missing"
    Then the command will fail
    And the output will contain "not found"
