@lambdalambda @generated
Feature: LambdaLambda - The Callee "Lambda" "Function" Is Deleted

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @delete_callee
  Scenario: the callee "lambda" "function" is deleted
    Given the callee "lambda" "function" existed
    And the callee "lambda" "function" was "ACTIVE"
    When the callee "lambda" "function" is deleted
    Then the callee "lambda" "function" will be "DELETED" and invocations targeting it will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @delete_callee
  Scenario: the callee "lambda" "function" is deleted fails when the callee "lambda" "function" did not exist
    Given the callee "lambda" "function" did not exist
    When the callee "lambda" "function" is deleted
    Then the operation is rejected

  @guard @negative @delete_callee @lifecycle
  Scenario: the callee "lambda" "function" is deleted fails when the callee "lambda" "function" was already "DELETED"
    Given the callee "lambda" "function" existed
    And the callee "lambda" "function" was already "DELETED"
    When the callee "lambda" "function" is deleted
    Then the operation is rejected
