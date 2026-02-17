@mock @invoke @dataplane
Feature: Mock Invoke

  @happy
  Scenario: List mock servers after creating one
    Given a mock server "e2e-mock-list-test" was created
    When I list mock servers
    Then the command will succeed
    And the output will contain mock server "e2e-mock-list-test"

  @happy
  Scenario: Get mock server status
    Given a mock server "e2e-mock-status-test" was created
    When I get status of mock server "e2e-mock-status-test"
    Then the command will succeed
    And the output will contain mock server "e2e-mock-status-test"
