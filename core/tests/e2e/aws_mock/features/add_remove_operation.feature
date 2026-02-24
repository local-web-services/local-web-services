@aws_mock @add_remove_operation @controlplane
Feature: AWS mock add and remove operations

  @happy
  Scenario: Add an operation to an AWS mock
    Given an AWS mock "e2e-aws-mock-addop" for service "s3" was created
    When I add operation "get-object" to AWS mock "e2e-aws-mock-addop" with status 200 and body "mocked"
    Then the command will succeed
    And the AWS mock "e2e-aws-mock-addop" was cleaned up

  @happy
  Scenario: Remove an operation from an AWS mock
    Given an AWS mock "e2e-aws-mock-rmop" for service "dynamodb" was created
    And operation "get-item" was added to AWS mock "e2e-aws-mock-rmop"
    When I remove operation "get-item" from AWS mock "e2e-aws-mock-rmop"
    Then the command will succeed
    And the AWS mock "e2e-aws-mock-rmop" was cleaned up
