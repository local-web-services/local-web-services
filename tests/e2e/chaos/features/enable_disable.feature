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
  Scenario: Show chaos status for all services
    When I request chaos status
    Then the command will succeed
    And the chaos status will contain "dynamodb"
    And the chaos status will contain "s3"
    And the chaos status will contain "sqs"
    And the chaos status will contain "sns"
