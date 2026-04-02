@lambdalambda @generated
Feature: LambdaLambda - The Caller "Lambda" "Function" Fails To Invoke The Callee "Lambda" "Function" Because The Callee "Lambda" "Function" Has Been Deleted

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the callee "lambda" "function" was "DELETED"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the "lambda" "invocation" will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function"
    And every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked

  @guard @negative @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the operation is rejected

  @guard @negative @callee_invocation_fails @internal
  Scenario: the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted fails when the callee "lambda" "function" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the callee "lambda" "function" was not "DELETED"
    When the caller "lambda" "function" fails to invoke the callee "lambda" "function" because the callee "lambda" "function" has been deleted
    Then the operation is rejected
