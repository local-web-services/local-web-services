@mock @header_routing @controlplane
Feature: Mock Header Routing

  @happy
  Scenario: Add a route with response headers
    Given a mock server "e2e-mock-header-route" was created
    When I add route "/v1/data" with method "GET" and status 200 and header "X-Custom:test-value" to "e2e-mock-header-route"
    Then the command will succeed
    And the route file will exist for "/v1/data" with method "GET" in "e2e-mock-header-route"

  @happy
  Scenario: Route file for different methods on same path
    Given a mock server "e2e-mock-header-methods" was created
    And a route "/v1/resource" with method "GET" and status 200 was added to "e2e-mock-header-methods"
    When I add route "/v1/resource" with method "POST" and status 201 to "e2e-mock-header-methods"
    Then the command will succeed
    And the route file will exist for "/v1/resource" with method "GET" in "e2e-mock-header-methods"
    And the route file will exist for "/v1/resource" with method "POST" in "e2e-mock-header-methods"
