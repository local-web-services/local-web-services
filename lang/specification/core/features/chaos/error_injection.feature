@chaos @error_injection @dataplane
Feature: Chaos error injection across AWS services

  Chaos middleware injects errors in the correct wire-protocol format
  for each AWS service when error rate is set to 100%.

  @happy
  Scenario: DynamoDB returns JSON error when chaos is active
    Given chaos was configured for "dynamodb" with full error rate
    When I list DynamoDB tables
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "dynamodb"

  @happy
  Scenario: SQS returns XML error when chaos is active
    Given chaos was configured for "sqs" with full error rate
    When I list SQS queues
    Then the output will contain an XML chaos error
    And chaos was cleaned up for "sqs"

  @happy
  Scenario: S3 returns XML error when chaos is active
    Given chaos was configured for "s3" with full error rate
    When I list S3 buckets
    Then the output will contain an S3 XML chaos error
    And chaos was cleaned up for "s3"

  @happy
  Scenario: SNS returns XML error when chaos is active
    Given chaos was configured for "sns" with full error rate
    When I list SNS topics
    Then the output will contain an XML chaos error
    And chaos was cleaned up for "sns"

  @happy
  Scenario: Step Functions returns JSON error when chaos is active
    Given chaos was configured for "stepfunctions" with full error rate
    When I list Step Functions state machines
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "stepfunctions"

  @happy
  Scenario: EventBridge returns JSON error when chaos is active
    Given chaos was configured for "events" with full error rate
    When I list EventBridge event buses
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "events"

  @happy
  Scenario: Cognito returns JSON error when chaos is active
    Given chaos was configured for "cognito-idp" with full error rate
    When I list Cognito user pools
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "cognito-idp"

  @happy
  Scenario: SSM returns JSON error when chaos is active
    Given chaos was configured for "ssm" with full error rate
    When I describe SSM parameters
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "ssm"

  @happy
  Scenario: Secrets Manager returns JSON error when chaos is active
    Given chaos was configured for "secretsmanager" with full error rate
    When I list Secrets Manager secrets
    Then the output will contain a JSON chaos error
    And chaos was cleaned up for "secretsmanager"
