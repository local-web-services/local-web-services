@mock @remove_route @controlplane
Feature: Mock Remove Route

  @happy
  Scenario: Remove a route from a mock server
    Given a mock server "e2e-mock-remove-route" was created
    And a route "/v1/data" with method "POST" and status 201 was added to "e2e-mock-remove-route"
    When I remove route "/v1/data" with method "POST" from "e2e-mock-remove-route"
    Then the command will succeed
    And the route file will not exist for "/v1/data" with method "POST" in "e2e-mock-remove-route"

  @error
  Scenario: Remove a route that does not exist
    Given a mock server "e2e-mock-remove-missing" was created
    When I remove route "/v1/nope" with method "GET" from "e2e-mock-remove-missing"
    Then the command will fail
    And the output will contain "not found"
