@aws_fake @fake_header_filter @dataplane
Feature: AWS fake header-based filtering

  Fake rules with header match criteria only activate when
  the request contains the specified headers. The standard CLI
  commands do not send the custom header so the fake should not
  activate.

  @happy @dynamodb
  Scenario: DynamoDB header-filtered fake does not activate without header
    Given an AWS fake rule for "dynamodb" operation "list-tables" with header filter was configured
    When I list DynamoDB tables
    Then the output will not contain "header-filtered-fake"
    And the AWS fake rule for "dynamodb" was cleaned up

  @happy @s3
  Scenario: S3 header-filtered fake does not activate without header
    Given an AWS fake rule for "s3" operation "list-buckets" with header filter was configured
    When I list S3 buckets
    Then the output will not contain "header-filtered-fake"
    And the AWS fake rule for "s3" was cleaned up

  @happy @ssm
  Scenario: SSM header-filtered fake does not activate without header
    Given an AWS fake rule for "ssm" operation "describe-parameters" with header filter was configured
    When I describe SSM parameters
    Then the output will not contain "header-filtered-fake"
    And the AWS fake rule for "ssm" was cleaned up
