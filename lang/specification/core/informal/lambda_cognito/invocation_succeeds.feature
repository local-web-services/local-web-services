@lambdacognito @generated
Feature: LambdaCognito - The "Lambda" "Function" Calls A Cognito Admin Api On An Active Pool And Succeeds

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "cognito" "user pool" was "ACTIVE"
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the invocation will be "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the operation is rejected

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds fails when the "cognito" "user pool" did not exist or was "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "cognito" "user pool" did not exist or was "DELETED"
    When the "lambda" "function" calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the operation is rejected
