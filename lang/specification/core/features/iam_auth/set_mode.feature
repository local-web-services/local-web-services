@iam_auth @set_mode @dataplane
Feature: IAM auth mode setting

  The mode can be changed between enforce, audit, and disabled at runtime.

  @error
  Scenario: Enforce mode denies SSM requests from unknown identities
    Given IAM auth was set for "ssm" with mode "enforce"
    When I describe SSM parameters
    Then the output will contain an IAM access denied error
    And IAM auth was cleaned up for "ssm"

  @happy
  Scenario: Audit mode allows requests through despite unknown identity
    Given IAM auth was set for "dynamodb" with mode "audit"
    When I list DynamoDB tables
    Then the command will succeed
    And IAM auth was cleaned up for "dynamodb"
