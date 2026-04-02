@lambdalambda @generated
Feature: LambdaLambda - A Caller "Lambda" "Function" Is Deployed

  # Generated from FizzBee spec: lambda_lambda.fizz
  # Safety invariants: InvocationRequiresActiveCaller, SuccessfulInvocationInvokedACallee

  Background:
    Given the system is initialized

  @minimal @happy @deploy_caller
  Scenario: a caller "lambda" "function" is deployed
    Given the caller "lambda" "function" did not already exist
    When a caller "lambda" "function" is deployed
    Then the caller "lambda" "function" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "invocation" references an "ACTIVE" caller "lambda" "function"
    And every successful "lambda" "invocation" recorded which callee "lambda" "function" was invoked

  @guard @negative @deploy_caller
  Scenario: a caller "lambda" "function" is deployed fails when the caller "lambda" "function" already existed
    Given the caller "lambda" "function" already existed
    When a caller "lambda" "function" is deployed
    Then the operation is rejected
