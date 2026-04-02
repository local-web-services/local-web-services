@lambdasns @generated
Feature: LambdaSns - The "Lambda" "Function" Invocation Fails

  # Generated from FizzBee spec: lambda_sns.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the "lambda" "invocation" will be "FAILED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And "sns" publishing requires an "ACTIVE" "sns" "topic" to be present

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the operation is rejected
