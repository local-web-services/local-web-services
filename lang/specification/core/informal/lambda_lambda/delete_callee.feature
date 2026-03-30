@lambdalambda @generated
Feature: LambdaLambda - The Callee Lambda Function Is Deleted

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @delete_callee
  Scenario: the callee Lambda function is deleted
    Given the callee exists
    And the callee is "ACTIVE"
    When the callee Lambda function is deleted
    Then the callee is "DELETED" and invocations targeting it will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @delete_callee
  Scenario: the callee Lambda function is deleted fails when the callee does not exist
    Given the callee does not exist
    When the callee Lambda function is deleted
    Then the operation is rejected

  @guard @negative @delete_callee @lifecycle
  Scenario: the callee Lambda function is deleted fails when the callee is already "DELETED"
    Given the callee exists
    And the callee is already "DELETED"
    When the callee Lambda function is deleted
    Then the operation is rejected
