@lambdalambda @generated
Feature: LambdaLambda - A Caller Lambda Function Is Deployed

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @deploy_caller
  Scenario: a caller Lambda function is deployed
    Given the caller function does not already exist
    When a caller Lambda function is deployed
    Then the caller function is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @deploy_caller
  Scenario: a caller Lambda function is deployed fails when the caller function already exists
    Given the caller function already exists
    When a caller Lambda function is deployed
    Then the operation is rejected
