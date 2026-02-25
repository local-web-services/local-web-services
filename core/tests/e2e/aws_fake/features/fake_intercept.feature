@aws_fake @fake_intercept @dataplane
Feature: AWS fake intercepts matched operations

  Fake rules return canned responses for matched operations.

  @happy @dynamodb
  Scenario: DynamoDB fake intercepts ListTables
    Given an AWS fake rule for "dynamodb" operation "list-tables" was configured
    When I list DynamoDB tables
    Then the output will contain "faked"
    And the AWS fake rule for "dynamodb" was cleaned up

  @happy @sqs
  Scenario: SQS fake intercepts ListQueues
    Given an AWS fake rule for "sqs" operation "list-queues" was configured
    When I list SQS queues
    Then the output will contain "faked"
    And the AWS fake rule for "sqs" was cleaned up

  @happy @s3
  Scenario: S3 fake intercepts ListBuckets
    Given an AWS fake rule for "s3" operation "list-buckets" was configured
    When I list S3 buckets
    Then the output will contain "faked"
    And the AWS fake rule for "s3" was cleaned up

  @happy @sns
  Scenario: SNS fake intercepts ListTopics
    Given an AWS fake rule for "sns" operation "list-topics" was configured
    When I list SNS topics
    Then the output will contain "faked"
    And the AWS fake rule for "sns" was cleaned up

  @happy @stepfunctions
  Scenario: Step Functions fake intercepts ListStateMachines
    Given an AWS fake rule for "stepfunctions" operation "list-state-machines" was configured
    When I list Step Functions state machines
    Then the output will contain "faked"
    And the AWS fake rule for "stepfunctions" was cleaned up

  @happy @events
  Scenario: EventBridge fake intercepts ListEventBuses
    Given an AWS fake rule for "events" operation "list-event-buses" was configured
    When I list EventBridge event buses
    Then the output will contain "faked"
    And the AWS fake rule for "events" was cleaned up

  @happy @cognito_idp
  Scenario: Cognito fake intercepts ListUserPools
    Given an AWS fake rule for "cognito-idp" operation "list-user-pools" was configured
    When I list Cognito user pools
    Then the output will contain "faked"
    And the AWS fake rule for "cognito-idp" was cleaned up

  @happy @ssm
  Scenario: SSM fake intercepts DescribeParameters
    Given an AWS fake rule for "ssm" operation "describe-parameters" was configured
    When I describe SSM parameters
    Then the output will contain "faked"
    And the AWS fake rule for "ssm" was cleaned up

  @happy @secretsmanager
  Scenario: Secrets Manager fake intercepts ListSecrets
    Given an AWS fake rule for "secretsmanager" operation "list-secrets" was configured
    When I list Secrets Manager secrets
    Then the output will contain "faked"
    And the AWS fake rule for "secretsmanager" was cleaned up
