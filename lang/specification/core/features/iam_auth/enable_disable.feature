@iam_auth @enable_disable @dataplane
Feature: IAM auth enable and disable

  Enabling IAM auth in enforce mode denies requests from unknown identities.
  Disabling returns to pass-through behaviour.

  @error
  Scenario: Enabling IAM auth in enforce mode denies DynamoDB requests
    Given IAM auth was enabled for "dynamodb" with mode "enforce"
    When I list DynamoDB tables
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "dynamodb"

  @happy
  Scenario: Disabling IAM auth allows DynamoDB requests through
    Given IAM auth was enabled for "dynamodb" with mode "enforce"
    And IAM auth was disabled for "dynamodb"
    When I list DynamoDB tables
    Then the command will succeed
    And IAM auth was cleaned up for "dynamodb"
