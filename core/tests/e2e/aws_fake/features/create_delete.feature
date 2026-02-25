@aws_fake @create_delete @controlplane
Feature: AWS fake create and delete

  @happy
  Scenario: Create an AWS fake for S3
    When I create an AWS fake "e2e-aws-fake-s3" for service "s3"
    Then the command will succeed
    And the output will contain "e2e-aws-fake-s3"
    And the AWS fake "e2e-aws-fake-s3" was cleaned up

  @happy
  Scenario: Create and delete an AWS fake
    Given an AWS fake "e2e-aws-fake-delete" for service "dynamodb" was created
    When I delete the AWS fake "e2e-aws-fake-delete"
    Then the command will succeed

  @happy
  Scenario: List AWS fakes
    Given an AWS fake "e2e-aws-fake-list" for service "sqs" was created
    When I list AWS fakes
    Then the command will succeed
    And the output will contain "e2e-aws-fake-list"
    And the AWS fake "e2e-aws-fake-list" was cleaned up
