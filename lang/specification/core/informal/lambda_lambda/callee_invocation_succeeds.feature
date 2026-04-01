@lambdalambda @generated
Feature: LambdaLambda - The Caller "Lambda" "Function" Invokes The Active Callee And The Call Succeeds

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @callee_invocation_succeeds @internal
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the callee "lambda" "function" was "ACTIVE"
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Then the "lambda" "invocation" will be "SUCCESS"
    And every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function"
    And every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked

  @guard @negative @callee_invocation_succeeds @internal
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Then the operation is rejected

  @guard @negative @callee_invocation_succeeds @internal
  Scenario: the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds fails when the callee "lambda" "function" did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the callee "lambda" "function" did not exist or was "DELETED"
    When the caller "lambda" "function" invokes the "ACTIVE" callee and the call succeeds
    Then the operation is rejected
