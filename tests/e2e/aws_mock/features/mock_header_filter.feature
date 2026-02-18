@aws_mock @mock_header_filter @dataplane
Feature: AWS mock header-based filtering

  Mock rules with header match criteria only activate when
  the request contains the specified headers. The standard CLI
  commands do not send the custom header so the mock should not
  activate.

  @happy @dynamodb
  Scenario: DynamoDB header-filtered mock does not activate without header
    Given an AWS mock rule for "dynamodb" operation "list-tables" with header filter was configured
    When I list DynamoDB tables
    Then the output will not contain "header-filtered-mock"
    And the AWS mock rule for "dynamodb" was cleaned up

  @happy @s3
  Scenario: S3 header-filtered mock does not activate without header
    Given an AWS mock rule for "s3" operation "list-buckets" with header filter was configured
    When I list S3 buckets
    Then the output will not contain "header-filtered-mock"
    And the AWS mock rule for "s3" was cleaned up

  @happy @ssm
  Scenario: SSM header-filtered mock does not activate without header
    Given an AWS mock rule for "ssm" operation "describe-parameters" with header filter was configured
    When I describe SSM parameters
    Then the output will not contain "header-filtered-mock"
    And the AWS mock rule for "ssm" was cleaned up
