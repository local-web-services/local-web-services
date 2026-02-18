@chaos @error_injection @dataplane
Feature: Chaos error injection across AWS services

  Chaos middleware injects errors in the correct wire-protocol format
  for each AWS service when error rate is set to 100%.

  @happy
  Scenario: DynamoDB returns JSON error when chaos is active
    Given chaos was configured for "dynamodb" with full error rate
    When I list DynamoDB tables
    Then the output will contain a DynamoDB chaos error
    And chaos was cleaned up for "dynamodb"

  @happy
  Scenario: SQS returns XML error when chaos is active
    Given chaos was configured for "sqs" with full error rate
    When I list SQS queues
    Then the output will contain an SQS chaos error
    And chaos was cleaned up for "sqs"

  @happy
  Scenario: S3 returns XML error when chaos is active
    Given chaos was configured for "s3" with full error rate
    When I list S3 buckets
    Then the output will contain an S3 chaos error
    And chaos was cleaned up for "s3"

  @happy
  Scenario: SNS returns XML error when chaos is active
    Given chaos was configured for "sns" with full error rate
    When I list SNS topics
    Then the output will contain an SNS chaos error
    And chaos was cleaned up for "sns"
