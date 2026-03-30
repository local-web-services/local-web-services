@lambdalambda @generated
Feature: LambdaLambda - The Caller Lambda Function Invokes The Active Callee And The Call Succeeds

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @callee_invocation_succeeds @internal
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Given an invocation is "IN_PROGRESS"
    And the callee is "ACTIVE"
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @callee_invocation_succeeds @internal
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then the operation is rejected

  @guard @negative @callee_invocation_succeeds @internal
  Scenario: the caller Lambda function invokes the "ACTIVE" callee and the call succeeds fails when the callee does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the callee does not exist or is "DELETED"
    When the caller Lambda function invokes the "ACTIVE" callee and the call succeeds
    Then the operation is rejected
