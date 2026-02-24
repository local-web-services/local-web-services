@chaos @enable_disable @controlplane
Feature: Chaos enable and disable

  @happy
  Scenario: Enable chaos for dynamodb
    When I enable chaos for "dynamodb"
    Then the command will succeed
    And chaos for "dynamodb" will be enabled

  @happy
  Scenario: Disable chaos for dynamodb
    Given chaos was enabled for "dynamodb"
    When I disable chaos for "dynamodb"
    Then the command will succeed
    And chaos for "dynamodb" will be disabled

  @happy
  Scenario: Enable chaos for sqs
    When I enable chaos for "sqs"
    Then the command will succeed
    And chaos for "sqs" will be enabled

  @happy
  Scenario: Disable chaos for sqs
    Given chaos was enabled for "sqs"
    When I disable chaos for "sqs"
    Then the command will succeed
    And chaos for "sqs" will be disabled

  @happy
  Scenario: Enable chaos for s3
    When I enable chaos for "s3"
    Then the command will succeed
    And chaos for "s3" will be enabled

  @happy
  Scenario: Disable chaos for s3
    Given chaos was enabled for "s3"
    When I disable chaos for "s3"
    Then the command will succeed
    And chaos for "s3" will be disabled

  @happy
  Scenario: Enable chaos for sns
    When I enable chaos for "sns"
    Then the command will succeed
    And chaos for "sns" will be enabled

  @happy
  Scenario: Disable chaos for sns
    Given chaos was enabled for "sns"
    When I disable chaos for "sns"
    Then the command will succeed
    And chaos for "sns" will be disabled

  @happy
  Scenario: Enable chaos for stepfunctions
    When I enable chaos for "stepfunctions"
    Then the command will succeed
    And chaos for "stepfunctions" will be enabled

  @happy
  Scenario: Disable chaos for stepfunctions
    Given chaos was enabled for "stepfunctions"
    When I disable chaos for "stepfunctions"
    Then the command will succeed
    And chaos for "stepfunctions" will be disabled

  @happy
  Scenario: Enable chaos for events
    When I enable chaos for "events"
    Then the command will succeed
    And chaos for "events" will be enabled

  @happy
  Scenario: Disable chaos for events
    Given chaos was enabled for "events"
    When I disable chaos for "events"
    Then the command will succeed
    And chaos for "events" will be disabled

  @happy
  Scenario: Enable chaos for cognito-idp
    When I enable chaos for "cognito-idp"
    Then the command will succeed
    And chaos for "cognito-idp" will be enabled

  @happy
  Scenario: Disable chaos for cognito-idp
    Given chaos was enabled for "cognito-idp"
    When I disable chaos for "cognito-idp"
    Then the command will succeed
    And chaos for "cognito-idp" will be disabled

  @happy
  Scenario: Enable chaos for ssm
    When I enable chaos for "ssm"
    Then the command will succeed
    And chaos for "ssm" will be enabled

  @happy
  Scenario: Disable chaos for ssm
    Given chaos was enabled for "ssm"
    When I disable chaos for "ssm"
    Then the command will succeed
    And chaos for "ssm" will be disabled

  @happy
  Scenario: Enable chaos for secretsmanager
    When I enable chaos for "secretsmanager"
    Then the command will succeed
    And chaos for "secretsmanager" will be enabled

  @happy
  Scenario: Disable chaos for secretsmanager
    Given chaos was enabled for "secretsmanager"
    When I disable chaos for "secretsmanager"
    Then the command will succeed
    And chaos for "secretsmanager" will be disabled

  @happy
  Scenario: Show chaos status for all services
    When I request chaos status
    Then the command will succeed
    And the chaos status will contain "dynamodb"
    And the chaos status will contain "s3"
    And the chaos status will contain "sqs"
    And the chaos status will contain "sns"
    And the chaos status will contain "stepfunctions"
    And the chaos status will contain "events"
    And the chaos status will contain "cognito-idp"
    And the chaos status will contain "ssm"
    And the chaos status will contain "secretsmanager"
