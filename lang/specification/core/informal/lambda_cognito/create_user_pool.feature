@lambdacognito @generated
Feature: LambdaCognito - A Cognito User Pool Is Created

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a Cognito user pool is created
    Given the pool does not already exist
    When a Cognito user pool is created
    Then the pool is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @standard @negative @create_user_pool
  Scenario: a Cognito user pool is created fails when the pool already exists
    Given the pool already exists
    When a Cognito user pool is created
    Then the operation is rejected
