@iam_auth @enforce_mode @dataplane
Feature: IAM auth enforce mode denies unauthorized requests

  When enforce mode is active, requests from unknown identities receive
  an AccessDeniedException with status 403.

  @error
  Scenario: DynamoDB returns JSON access denied error when enforce mode is active
    Given IAM auth was enabled for "dynamodb" with mode "enforce"
    When I list DynamoDB tables
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "dynamodb"

  @error
  Scenario: SSM returns JSON access denied error when enforce mode is active
    Given IAM auth was enabled for "ssm" with mode "enforce"
    When I describe SSM parameters
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "ssm"

  @error
  Scenario: Secrets Manager returns JSON access denied error when enforce mode is active
    Given IAM auth was enabled for "secretsmanager" with mode "enforce"
    When I list Secrets Manager secrets
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "secretsmanager"
