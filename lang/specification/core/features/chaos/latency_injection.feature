@chaos @latency_injection @dataplane
Feature: Chaos latency injection across AWS services

  Chaos middleware injects latency into service calls when configured.
  Each scenario sets a fixed 200ms latency and verifies the call is delayed.

  @happy
  Scenario: DynamoDB call is delayed when latency chaos is active
    Given chaos was configured for "dynamodb" with 200ms latency
    When I list DynamoDB tables with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "dynamodb"

  @happy
  Scenario: SQS call is delayed when latency chaos is active
    Given chaos was configured for "sqs" with 200ms latency
    When I list SQS queues with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "sqs"

  @happy
  Scenario: S3 call is delayed when latency chaos is active
    Given chaos was configured for "s3" with 200ms latency
    When I list S3 buckets with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "s3"

  @happy
  Scenario: SNS call is delayed when latency chaos is active
    Given chaos was configured for "sns" with 200ms latency
    When I list SNS topics with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "sns"

  @happy
  Scenario: Step Functions call is delayed when latency chaos is active
    Given chaos was configured for "stepfunctions" with 200ms latency
    When I list Step Functions state machines with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "stepfunctions"

  @happy
  Scenario: EventBridge call is delayed when latency chaos is active
    Given chaos was configured for "events" with 200ms latency
    When I list EventBridge event buses with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "events"

  @happy
  Scenario: Cognito call is delayed when latency chaos is active
    Given chaos was configured for "cognito-idp" with 200ms latency
    When I list Cognito user pools with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "cognito-idp"

  @happy
  Scenario: SSM call is delayed when latency chaos is active
    Given chaos was configured for "ssm" with 200ms latency
    When I describe SSM parameters with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "ssm"

  @happy
  Scenario: Secrets Manager call is delayed when latency chaos is active
    Given chaos was configured for "secretsmanager" with 200ms latency
    When I list Secrets Manager secrets with timing
    Then the call will have taken at least 200 milliseconds
    And chaos was cleaned up for "secretsmanager"
