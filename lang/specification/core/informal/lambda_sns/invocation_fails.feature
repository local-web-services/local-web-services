@lambdasns @generated
Feature: LambdaSns - The Lambda Invocation Fails

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the Lambda invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the invocation will be "FAILED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And publishing requires an "ACTIVE" topic to be present

  @guard @negative @invocation_fails @internal
  Scenario: the Lambda invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the Lambda invocation fails
    Then the operation is rejected
