@fake @status @controlplane
Feature: Fake Server Status

  @happy
  Scenario: Get status of a fake server with no routes
    Given a fake server "e2e-fake-status-empty" was created
    When I get status of fake server "e2e-fake-status-empty"
    Then the command will succeed
    And the output will contain fake server "e2e-fake-status-empty"
    And the output will show 0 route(s)

  @happy
  Scenario: Get status shows route count
    Given a fake server "e2e-fake-status-routes" was created
    And a route "/v1/items" with method "GET" and status 200 was added to "e2e-fake-status-routes"
    And a route "/v1/orders" with method "POST" and status 201 was added to "e2e-fake-status-routes"
    When I get status of fake server "e2e-fake-status-routes"
    Then the command will succeed
    And the output will show 2 route(s)

  @happy
  Scenario: Get status shows protocol
    Given a fake server "e2e-fake-status-proto" was created with protocol "graphql"
    When I get status of fake server "e2e-fake-status-proto"
    Then the command will succeed
    And the output will have protocol "graphql"

  @error
  Scenario: Get status of nonexistent fake server
    When I get status of fake server "e2e-fake-status-missing"
    Then the command will fail
    And the output will contain "not found"
