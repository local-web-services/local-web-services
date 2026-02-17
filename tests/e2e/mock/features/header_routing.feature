@mock @header_routing @dataplane
Feature: Mock Header Routing

  @happy
  Scenario: Add multiple routes to a mock server
    Given a mock server "e2e-mock-multi-route" was created
    And a route "/v1/alpha" with method "GET" and status 200 was added to "e2e-mock-multi-route"
    When I add route "/v1/beta" with method "POST" and status 201 to "e2e-mock-multi-route"
    Then the command will succeed
