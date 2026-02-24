@aws_fake @add_remove_operation @controlplane
Feature: AWS fake add and remove operations

  @happy
  Scenario: Add an operation to an AWS fake
    Given an AWS fake "e2e-aws-fake-addop" for service "s3" was created
    When I add operation "get-object" to AWS fake "e2e-aws-fake-addop" with status 200 and body "faked"
    Then the command will succeed
    And the AWS fake "e2e-aws-fake-addop" was cleaned up

  @happy
  Scenario: Remove an operation from an AWS fake
    Given an AWS fake "e2e-aws-fake-rmop" for service "dynamodb" was created
    And operation "get-item" was added to AWS fake "e2e-aws-fake-rmop"
    When I remove operation "get-item" from AWS fake "e2e-aws-fake-rmop"
    Then the command will succeed
    And the AWS fake "e2e-aws-fake-rmop" was cleaned up
