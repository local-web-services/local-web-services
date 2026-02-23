@mock @invoke @controlplane
Feature: Mock Invoke

  @happy
  Scenario: Status shows route count after adding routes
    Given a mock server "e2e-mock-invoke-count" was created
    And a route "/v1/items" with method "GET" and status 200 was added to "e2e-mock-invoke-count"
    When I get status of mock server "e2e-mock-invoke-count"
    Then the command will succeed
    And the output will show 1 route(s)

  @happy
  Scenario: Status shows updated count after removing a route
    Given a mock server "e2e-mock-invoke-remove" was created
    And a route "/v1/alpha" with method "GET" and status 200 was added to "e2e-mock-invoke-remove"
    And a route "/v1/beta" with method "POST" and status 201 was added to "e2e-mock-invoke-remove"
    When I remove route "/v1/alpha" with method "GET" from "e2e-mock-invoke-remove"
    Then the command will succeed
    When I get status of mock server "e2e-mock-invoke-remove"
    Then the command will succeed
    And the output will show 1 route(s)
