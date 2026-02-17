@chaos @set_config @controlplane
Feature: Chaos set configuration

  @happy
  Scenario: Set error rate for dynamodb
    When I set chaos for "dynamodb" with error rate 0.5
    Then the command will succeed
    And chaos for "dynamodb" will have error rate 0.5

  @happy
  Scenario: Set latency for dynamodb
    When I set chaos for "dynamodb" with latency min 50 and max 200
    Then the command will succeed
    And chaos for "dynamodb" will have latency min 50
    And chaos for "dynamodb" will have latency max 200
