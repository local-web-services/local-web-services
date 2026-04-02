@lambdalambda @generated
Feature: LambdaLambda - A Callee "Lambda" "Function" Is Deployed

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @deploy_callee
  Scenario: a callee "lambda" "function" is deployed
    Given the callee "lambda" "function" did not already exist
    When a callee "lambda" "function" is deployed
    Then the callee "lambda" "function" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function"
    And every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked

  @guard @negative @deploy_callee
  Scenario: a callee "lambda" "function" is deployed fails when the callee "lambda" "function" already existed
    Given the callee "lambda" "function" already existed
    When a callee "lambda" "function" is deployed
    Then the operation is rejected
