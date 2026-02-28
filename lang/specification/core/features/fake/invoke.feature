@fake @invoke @controlplane
Feature: Fake Invoke

  @happy
  Scenario: Status shows route count after adding routes
    Given a fake server "e2e-fake-invoke-count" was created
    And a route "/v1/items" with method "GET" and status 200 was added to "e2e-fake-invoke-count"
    When I get status of fake server "e2e-fake-invoke-count"
    Then the command will succeed
    And the output will show 1 route(s)

  @happy
  Scenario: Status shows updated count after removing a route
    Given a fake server "e2e-fake-invoke-remove" was created
    And a route "/v1/alpha" with method "GET" and status 200 was added to "e2e-fake-invoke-remove"
    And a route "/v1/beta" with method "POST" and status 201 was added to "e2e-fake-invoke-remove"
    When I remove route "/v1/alpha" with method "GET" from "e2e-fake-invoke-remove"
    Then the command will succeed
    When I get status of fake server "e2e-fake-invoke-remove"
    Then the command will succeed
    And the output will show 1 route(s)
