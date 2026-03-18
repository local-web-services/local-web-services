@lambdalambda @generated
Feature: LambdaLambda - The Caller Fails To Invoke The Callee Because The Callee Has Been Deleted

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @callee_invocation_fails @internal
  Scenario: the caller fails to invoke the callee because the callee has been deleted
    Given an invocation is "IN_PROGRESS"
    And the callee is "DELETED"
    When the caller fails to invoke the callee because the callee has been deleted
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @standard @negative @callee_invocation_fails @internal
  Scenario: the caller fails to invoke the callee because the callee has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the caller fails to invoke the callee because the callee has been deleted
    Then the operation is rejected

  @standard @negative @callee_invocation_fails @internal
  Scenario: the caller fails to invoke the callee because the callee has been deleted fails when the callee is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the callee is not "DELETED"
    When the caller fails to invoke the callee because the callee has been deleted
    Then the operation is rejected
