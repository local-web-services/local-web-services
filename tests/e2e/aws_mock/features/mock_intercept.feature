@aws_mock @mock_intercept @dataplane
Feature: AWS mock intercepts matched operations

  Mock rules return canned responses for matched operations.

  @happy @dynamodb
  Scenario: DynamoDB mock intercepts ListTables
    Given an AWS mock rule for "dynamodb" operation "list-tables" was configured
    When I list DynamoDB tables
    Then the output will contain "mocked"
    And the AWS mock rule for "dynamodb" was cleaned up

  @happy @sqs
  Scenario: SQS mock intercepts ListQueues
    Given an AWS mock rule for "sqs" operation "list-queues" was configured
    When I list SQS queues
    Then the output will contain "mocked"
    And the AWS mock rule for "sqs" was cleaned up

  @happy @s3
  Scenario: S3 mock intercepts ListBuckets
    Given an AWS mock rule for "s3" operation "list-buckets" was configured
    When I list S3 buckets
    Then the output will contain "mocked"
    And the AWS mock rule for "s3" was cleaned up

  @happy @sns
  Scenario: SNS mock intercepts ListTopics
    Given an AWS mock rule for "sns" operation "list-topics" was configured
    When I list SNS topics
    Then the output will contain "mocked"
    And the AWS mock rule for "sns" was cleaned up

  @happy @stepfunctions
  Scenario: Step Functions mock intercepts ListStateMachines
    Given an AWS mock rule for "stepfunctions" operation "list-state-machines" was configured
    When I list Step Functions state machines
    Then the output will contain "mocked"
    And the AWS mock rule for "stepfunctions" was cleaned up

  @happy @events
  Scenario: EventBridge mock intercepts ListEventBuses
    Given an AWS mock rule for "events" operation "list-event-buses" was configured
    When I list EventBridge event buses
    Then the output will contain "mocked"
    And the AWS mock rule for "events" was cleaned up

  @happy @cognito_idp
  Scenario: Cognito mock intercepts ListUserPools
    Given an AWS mock rule for "cognito-idp" operation "list-user-pools" was configured
    When I list Cognito user pools
    Then the output will contain "mocked"
    And the AWS mock rule for "cognito-idp" was cleaned up

  @happy @ssm
  Scenario: SSM mock intercepts DescribeParameters
    Given an AWS mock rule for "ssm" operation "describe-parameters" was configured
    When I describe SSM parameters
    Then the output will contain "mocked"
    And the AWS mock rule for "ssm" was cleaned up

  @happy @secretsmanager
  Scenario: Secrets Manager mock intercepts ListSecrets
    Given an AWS mock rule for "secretsmanager" operation "list-secrets" was configured
    When I list Secrets Manager secrets
    Then the output will contain "mocked"
    And the AWS mock rule for "secretsmanager" was cleaned up
