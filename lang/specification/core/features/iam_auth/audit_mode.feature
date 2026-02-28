@iam_auth @audit_mode @dataplane
Feature: IAM auth audit mode logs but allows requests

  When audit mode is active, requests from unknown identities are logged
  but allowed to proceed.

  @happy
  Scenario: DynamoDB allows requests through in audit mode
    Given IAM auth was set for "dynamodb" with mode "audit"
    When I list DynamoDB tables
    Then the command will succeed
    And IAM auth was cleaned up for "dynamodb"

  @happy
  Scenario: SSM allows requests through in audit mode
    Given IAM auth was set for "ssm" with mode "audit"
    When I describe SSM parameters
    Then the command will succeed
    And IAM auth was cleaned up for "ssm"
