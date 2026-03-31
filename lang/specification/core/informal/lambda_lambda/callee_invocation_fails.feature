@lambdalambda @generated
Feature: LambdaLambda - The Caller "Lambda" "Function" Fails To Invoke The Callee "Lambda" "Function" Because The Callee "Lambda" "Function" Has Been Deleted

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given an invocation was "IN_PROGRESS"
    And the callee "lambda" "function" was "DELETED"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the invocation will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted fails when no invocation was "IN_PROGRESS"
    Given no invocation was "IN_PROGRESS"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the operation is rejected

  @guard @negative @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted fails when the callee "lambda" "function" was not "DELETED"
    Given an invocation was "IN_PROGRESS"
    And the callee "lambda" "function" was not "DELETED"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the operation is rejected
