@fake @remove_route @controlplane
Feature: Fake Remove Route

  @happy
  Scenario: Remove a route from a fake server
    Given a fake server "e2e-fake-remove-route" was created
    And a route "/v1/data" with method "POST" and status 201 was added to "e2e-fake-remove-route"
    When I remove route "/v1/data" with method "POST" from "e2e-fake-remove-route"
    Then the command will succeed
    And the route file will not exist for "/v1/data" with method "POST" in "e2e-fake-remove-route"

  @error
  Scenario: Remove a route that does not exist
    Given a fake server "e2e-fake-remove-missing" was created
    When I remove route "/v1/nope" with method "GET" from "e2e-fake-remove-missing"
    Then the command will fail
    And the output will contain "not found"
