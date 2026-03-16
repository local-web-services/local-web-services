@lambdalambda @generated
Feature: LambdaLambda - The Caller Lambda Function Is Invoked

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @invoke_caller
  Scenario: the caller Lambda function is invoked
    Given the caller exists
    And the caller is "ACTIVE"
    And an invocation slot is available
    When the caller Lambda function is invoked
    Then the invocation is "IN_PROGRESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @standard @negative @invoke_caller
  Scenario: the caller Lambda function is invoked fails when the caller does not exist
    Given the caller does not exist
    When the caller Lambda function is invoked
    Then the operation is rejected

  @standard @negative @invoke_caller @lifecycle
  Scenario: the caller Lambda function is invoked fails when the caller is not "ACTIVE"
    Given the caller exists
    And the caller is not "ACTIVE"
    When the caller Lambda function is invoked
    Then the operation is rejected

  @standard @negative @invoke_caller @capacity
  Scenario: the caller Lambda function is invoked fails when no invocation slot is available
    Given the caller exists
    And the caller is "ACTIVE"
    And no invocation slot is available
    When the caller Lambda function is invoked
    Then the operation is rejected
