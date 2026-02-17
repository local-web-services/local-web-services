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

  @happy
  Scenario: Chaos config with custom latency values
    Given a mock server "e2e-mock-chaos-latency-set" was created with chaos latency min 100 and max 500
    When I read the config of mock server "e2e-mock-chaos-latency-set"
    Then the chaos latency min will be 100
    And the chaos latency max will be 500

  @happy
  Scenario: Chaos config with custom timeout rate
    Given a mock server "e2e-mock-chaos-timeout-set" was created with chaos timeout rate 0.15
    When I read the config of mock server "e2e-mock-chaos-timeout-set"
    Then the chaos timeout rate will be 0.15

  @happy
  Scenario: Chaos config with custom error rate
    Given a mock server "e2e-mock-chaos-error-set" was created with chaos error rate 0.25
    When I read the config of mock server "e2e-mock-chaos-error-set"
    Then the chaos error rate will be 0.25

  @happy
  Scenario: Chaos config with custom connection reset rate
    Given a mock server "e2e-mock-chaos-reset-set" was created with chaos connection reset rate 0.05
    When I read the config of mock server "e2e-mock-chaos-reset-set"
    Then the chaos connection reset rate will be 0.05

  @happy
  Scenario: Chaos config with all custom values
    Given a mock server "e2e-mock-chaos-all" was created with chaos latency min 50 and max 200 and error rate 0.1 and timeout rate 0.05
    When I read the config of mock server "e2e-mock-chaos-all"
    Then the chaos latency min will be 50
    And the chaos latency max will be 200
    And the chaos error rate will be 0.1
    And the chaos timeout rate will be 0.05
