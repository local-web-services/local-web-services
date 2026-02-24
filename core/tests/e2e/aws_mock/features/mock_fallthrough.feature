@aws_mock @mock_fallthrough @dataplane
Feature: AWS mock falls through for unmatched operations

  When a mock rule is configured for one operation, requests for
  other operations reach the real provider unchanged.

  @happy @dynamodb
  Scenario: DynamoDB unmocked operation falls through
    Given an AWS mock rule for "dynamodb" operation "get-item" was configured
    When I list DynamoDB tables
    Then the output will not contain "mocked"
    And the AWS mock rule for "dynamodb" was cleaned up

  @happy @sqs
  Scenario: SQS unmocked operation falls through
    Given an AWS mock rule for "sqs" operation "send-message" was configured
    When I list SQS queues
    Then the output will not contain "mocked"
    And the AWS mock rule for "sqs" was cleaned up

  @happy @s3
  Scenario: S3 unmocked operation falls through
    Given an AWS mock rule for "s3" operation "get-object" was configured
    When I list S3 buckets
    Then the output will not contain "mocked"
    And the AWS mock rule for "s3" was cleaned up

  @happy @sns
  Scenario: SNS unmocked operation falls through
    Given an AWS mock rule for "sns" operation "publish" was configured
    When I list SNS topics
    Then the output will not contain "mocked"
    And the AWS mock rule for "sns" was cleaned up

  @happy @stepfunctions
  Scenario: Step Functions unmocked operation falls through
    Given an AWS mock rule for "stepfunctions" operation "start-execution" was configured
    When I list Step Functions state machines
    Then the output will not contain "mocked"
    And the AWS mock rule for "stepfunctions" was cleaned up

  @happy @events
  Scenario: EventBridge unmocked operation falls through
    Given an AWS mock rule for "events" operation "put-events" was configured
    When I list EventBridge event buses
    Then the output will not contain "mocked"
    And the AWS mock rule for "events" was cleaned up

  @happy @cognito_idp
  Scenario: Cognito unmocked operation falls through
    Given an AWS mock rule for "cognito-idp" operation "initiate-auth" was configured
    When I list Cognito user pools
    Then the output will not contain "mocked"
    And the AWS mock rule for "cognito-idp" was cleaned up

  @happy @ssm
  Scenario: SSM unmocked operation falls through
    Given an AWS mock rule for "ssm" operation "get-parameter" was configured
    When I describe SSM parameters
    Then the output will not contain "mocked"
    And the AWS mock rule for "ssm" was cleaned up

  @happy @secretsmanager
  Scenario: Secrets Manager unmocked operation falls through
    Given an AWS mock rule for "secretsmanager" operation "get-secret-value" was configured
    When I list Secrets Manager secrets
    Then the output will not contain "mocked"
    And the AWS mock rule for "secretsmanager" was cleaned up
