@fake @header_routing @controlplane
Feature: Fake Header Routing

  @happy
  Scenario: Add a route with response headers
    Given a fake server "e2e-fake-header-route" was created
    When I add route "/v1/data" with method "GET" and status 200 and header "X-Custom:test-value" to "e2e-fake-header-route"
    Then the command will succeed
    And the route file will exist for "/v1/data" with method "GET" in "e2e-fake-header-route"

  @happy
  Scenario: Route file for different methods on same path
    Given a fake server "e2e-fake-header-methods" was created
    And a route "/v1/resource" with method "GET" and status 200 was added to "e2e-fake-header-methods"
    When I add route "/v1/resource" with method "POST" and status 201 to "e2e-fake-header-methods"
    Then the command will succeed
    And the route file will exist for "/v1/resource" with method "GET" in "e2e-fake-header-methods"
    And the route file will exist for "/v1/resource" with method "POST" in "e2e-fake-header-methods"
