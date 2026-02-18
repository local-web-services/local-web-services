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

  @happy
  Scenario: Set error rate for sqs
    When I set chaos for "sqs" with error rate 0.3
    Then the command will succeed
    And chaos for "sqs" will have error rate 0.3

  @happy
  Scenario: Set error rate for s3
    When I set chaos for "s3" with error rate 0.7
    Then the command will succeed
    And chaos for "s3" will have error rate 0.7

  @happy
  Scenario: Set error rate for sns
    When I set chaos for "sns" with error rate 0.4
    Then the command will succeed
    And chaos for "sns" will have error rate 0.4

  @happy
  Scenario: Set latency for sqs
    When I set chaos for "sqs" with latency min 100 and max 500
    Then the command will succeed
    And chaos for "sqs" will have latency min 100
    And chaos for "sqs" will have latency max 500
