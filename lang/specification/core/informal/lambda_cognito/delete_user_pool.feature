@lambdacognito @generated
Feature: LambdaCognito - A Cognito User Pool Is Deleted

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a Cognito user pool is deleted
    Given the pool exists
    And the pool is "ACTIVE"
    When a Cognito user pool is deleted
    Then the pool is "DELETED" and Lambda calls targeting it will fail
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @standard @negative @delete_user_pool
  Scenario: a Cognito user pool is deleted fails when the pool does not exist
    Given the pool does not exist
    When a Cognito user pool is deleted
    Then the operation is rejected

  @standard @negative @delete_user_pool @lifecycle @internal
  Scenario: a Cognito user pool is deleted fails when the pool is already "DELETED"
    Given the pool exists
    And the pool is already "DELETED"
    When a Cognito user pool is deleted
    Then the operation is rejected
