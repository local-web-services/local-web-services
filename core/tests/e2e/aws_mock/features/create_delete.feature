@aws_mock @create_delete @controlplane
Feature: AWS mock create and delete

  @happy
  Scenario: Create an AWS mock for S3
    When I create an AWS mock "e2e-aws-mock-s3" for service "s3"
    Then the command will succeed
    And the output will contain "e2e-aws-mock-s3"
    And the AWS mock "e2e-aws-mock-s3" was cleaned up

  @happy
  Scenario: Create and delete an AWS mock
    Given an AWS mock "e2e-aws-mock-delete" for service "dynamodb" was created
    When I delete the AWS mock "e2e-aws-mock-delete"
    Then the command will succeed

  @happy
  Scenario: List AWS mocks
    Given an AWS mock "e2e-aws-mock-list" for service "sqs" was created
    When I list AWS mocks
    Then the command will succeed
    And the output will contain "e2e-aws-mock-list"
    And the AWS mock "e2e-aws-mock-list" was cleaned up
