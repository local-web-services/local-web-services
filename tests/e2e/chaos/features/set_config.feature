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

  @happy
  Scenario: Set error rate for stepfunctions
    When I set chaos for "stepfunctions" with error rate 0.2
    Then the command will succeed
    And chaos for "stepfunctions" will have error rate 0.2

  @happy
  Scenario: Set error rate for events
    When I set chaos for "events" with error rate 0.6
    Then the command will succeed
    And chaos for "events" will have error rate 0.6

  @happy
  Scenario: Set error rate for cognito-idp
    When I set chaos for "cognito-idp" with error rate 0.15
    Then the command will succeed
    And chaos for "cognito-idp" will have error rate 0.15

  @happy
  Scenario: Set error rate for ssm
    When I set chaos for "ssm" with error rate 0.25
    Then the command will succeed
    And chaos for "ssm" will have error rate 0.25

  @happy
  Scenario: Set error rate for secretsmanager
    When I set chaos for "secretsmanager" with error rate 0.35
    Then the command will succeed
    And chaos for "secretsmanager" will have error rate 0.35

  @happy
  Scenario: Set latency for stepfunctions
    When I set chaos for "stepfunctions" with latency min 25 and max 150
    Then the command will succeed
    And chaos for "stepfunctions" will have latency min 25
    And chaos for "stepfunctions" will have latency max 150
