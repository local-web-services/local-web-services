@mock @status @controlplane
Feature: Mock Server Status

  @happy
  Scenario: Get status of a mock server with no routes
    Given a mock server "e2e-mock-status-empty" was created
    When I get status of mock server "e2e-mock-status-empty"
    Then the command will succeed
    And the output will contain mock server "e2e-mock-status-empty"
    And the output will show 0 route(s)

  @happy
  Scenario: Get status shows route count
    Given a mock server "e2e-mock-status-routes" was created
    And a route "/v1/items" with method "GET" and status 200 was added to "e2e-mock-status-routes"
    And a route "/v1/orders" with method "POST" and status 201 was added to "e2e-mock-status-routes"
    When I get status of mock server "e2e-mock-status-routes"
    Then the command will succeed
    And the output will show 2 route(s)

  @happy
  Scenario: Get status shows protocol
    Given a mock server "e2e-mock-status-proto" was created with protocol "graphql"
    When I get status of mock server "e2e-mock-status-proto"
    Then the command will succeed
    And the output will have protocol "graphql"

  @error
  Scenario: Get status of nonexistent mock server
    When I get status of mock server "e2e-mock-status-missing"
    Then the command will fail
    And the output will contain "not found"
