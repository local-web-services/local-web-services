@aws_fake @fake_fallthrough @dataplane
Feature: AWS fake falls through for unmatched operations

  When a fake rule is configured for one operation, requests for
  other operations reach the real provider unchanged.

  @happy @dynamodb
  Scenario: DynamoDB unfaked operation falls through
    Given an AWS fake rule for "dynamodb" operation "get-item" was configured
    When I list DynamoDB tables
    Then the output will not contain "faked"
    And the AWS fake rule for "dynamodb" was cleaned up

  @happy @sqs
  Scenario: SQS unfaked operation falls through
    Given an AWS fake rule for "sqs" operation "send-message" was configured
    When I list SQS queues
    Then the output will not contain "faked"
    And the AWS fake rule for "sqs" was cleaned up

  @happy @s3
  Scenario: S3 unfaked operation falls through
    Given an AWS fake rule for "s3" operation "get-object" was configured
    When I list S3 buckets
    Then the output will not contain "faked"
    And the AWS fake rule for "s3" was cleaned up

  @happy @sns
  Scenario: SNS unfaked operation falls through
    Given an AWS fake rule for "sns" operation "publish" was configured
    When I list SNS topics
    Then the output will not contain "faked"
    And the AWS fake rule for "sns" was cleaned up

  @happy @stepfunctions
  Scenario: Step Functions unfaked operation falls through
    Given an AWS fake rule for "stepfunctions" operation "start-execution" was configured
    When I list Step Functions state machines
    Then the output will not contain "faked"
    And the AWS fake rule for "stepfunctions" was cleaned up

  @happy @events
  Scenario: EventBridge unfaked operation falls through
    Given an AWS fake rule for "events" operation "put-events" was configured
    When I list EventBridge event buses
    Then the output will not contain "faked"
    And the AWS fake rule for "events" was cleaned up

  @happy @cognito_idp
  Scenario: Cognito unfaked operation falls through
    Given an AWS fake rule for "cognito-idp" operation "initiate-auth" was configured
    When I list Cognito user pools
    Then the output will not contain "faked"
    And the AWS fake rule for "cognito-idp" was cleaned up

  @happy @ssm
  Scenario: SSM unfaked operation falls through
    Given an AWS fake rule for "ssm" operation "get-parameter" was configured
    When I describe SSM parameters
    Then the output will not contain "faked"
    And the AWS fake rule for "ssm" was cleaned up

  @happy @secretsmanager
  Scenario: Secrets Manager unfaked operation falls through
    Given an AWS fake rule for "secretsmanager" operation "get-secret-value" was configured
    When I list Secrets Manager secrets
    Then the output will not contain "faked"
    And the AWS fake rule for "secretsmanager" was cleaned up
