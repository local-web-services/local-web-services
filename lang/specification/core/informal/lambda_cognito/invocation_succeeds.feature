@lambdacognito @generated
Feature: LambdaCognito - The Lambda Function Calls A Cognito Admin Api On An Active Pool And Succeeds

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Given an invocation is "IN_PROGRESS"
    And the pool is "ACTIVE"
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the invocation is "SUCCESS"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the operation is rejected

  @standard @negative @invocation_succeeds @internal
  Scenario: the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds fails when the pool does not exist or is "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the pool does not exist or is "DELETED"
    When the Lambda function calls a Cognito admin "API" on an "ACTIVE" pool and succeeds
    Then the operation is rejected
