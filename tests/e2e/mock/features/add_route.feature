@mock @add_route @controlplane
Feature: Mock Add Route

  @happy
  Scenario: Add a route to a mock server
    Given a mock server "e2e-mock-add-route" was created
    When I add route "/v1/items" with method "GET" and status 200 to "e2e-mock-add-route"
    Then the command will succeed

  @happy
  Scenario: Remove a route from a mock server
    Given a mock server "e2e-mock-remove-route" was created
    And a route "/v1/data" with method "POST" and status 201 was added to "e2e-mock-remove-route"
    When I remove route "/v1/data" with method "POST" from "e2e-mock-remove-route"
    Then the command will succeed
