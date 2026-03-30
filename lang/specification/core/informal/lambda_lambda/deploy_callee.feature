@lambdalambda @generated
Feature: LambdaLambda - A Callee Lambda Function Is Deployed

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @deploy_callee
  Scenario: a callee Lambda function is deployed
    Given the callee function does not already exist
    When a callee Lambda function is deployed
    Then the callee function is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" caller function
    And every successful invocation recorded which callee was invoked

  @guard @negative @deploy_callee
  Scenario: a callee Lambda function is deployed fails when the callee function already exists
    Given the callee function already exists
    When a callee Lambda function is deployed
    Then the operation is rejected
