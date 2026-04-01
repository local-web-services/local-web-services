@lambdalambda @generated
Feature: LambdaLambda - The Caller "Lambda" "Function" Is Invoked

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @invoke_caller
  Scenario: the caller "lambda" "function" is invoked
    Given the caller "lambda" "function" existed
    And the caller "lambda" "function" was "ACTIVE"
    And an invocation slot is available
    When the caller "lambda" "function" is invoked
    Then the invocation will be "IN_PROGRESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @invoke_caller
  Scenario: the caller "lambda" "function" is invoked fails when the caller "lambda" "function" did not exist
    Given the caller "lambda" "function" did not exist
    When the caller "lambda" "function" is invoked
    Then the operation is rejected

  @guard @negative @invoke_caller @lifecycle
  Scenario: the caller "lambda" "function" is invoked fails when the caller "lambda" "function" was not "ACTIVE"
    Given the caller "lambda" "function" existed
    And the caller "lambda" "function" was not "ACTIVE"
    When the caller "lambda" "function" is invoked
    Then the operation is rejected

  @guard @negative @invoke_caller @capacity
  Scenario: the caller "lambda" "function" is invoked fails when no invocation slot is available
    Given the caller "lambda" "function" existed
    And the caller "lambda" "function" was "ACTIVE"
    And no invocation slot is available
    When the caller "lambda" "function" is invoked
    Then the operation is rejected
