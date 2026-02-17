@mock @chaos @controlplane
Feature: Mock Chaos Configuration

  @happy
  Scenario: New server has chaos disabled by default
    Given a mock server "e2e-mock-chaos-default" was created
    When I get status of mock server "e2e-mock-chaos-default"
    Then the command will succeed
    And the config will have chaos disabled

  @happy
  Scenario: Chaos config has zero error rate by default
    Given a mock server "e2e-mock-chaos-error-rate" was created
    When I read the config of mock server "e2e-mock-chaos-error-rate"
    Then the chaos error rate will be 0.0

  @happy
  Scenario: Chaos config has zero latency by default
    Given a mock server "e2e-mock-chaos-latency" was created
    When I read the config of mock server "e2e-mock-chaos-latency"
    Then the chaos latency min will be 0
    And the chaos latency max will be 0

  @happy
  Scenario: Chaos config has zero connection reset rate by default
    Given a mock server "e2e-mock-chaos-conn-reset" was created
    When I read the config of mock server "e2e-mock-chaos-conn-reset"
    Then the chaos connection reset rate will be 0.0

  @happy
  Scenario: Chaos config has zero timeout rate by default
    Given a mock server "e2e-mock-chaos-timeout" was created
    When I read the config of mock server "e2e-mock-chaos-timeout"
    Then the chaos timeout rate will be 0.0
