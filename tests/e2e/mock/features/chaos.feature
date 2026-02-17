@mock @chaos @controlplane
Feature: Mock Chaos Configuration

  @happy
  Scenario: Create server with default chaos disabled
    Given a mock server "e2e-mock-chaos-default" was created
    When I get status of mock server "e2e-mock-chaos-default"
    Then the command will succeed
