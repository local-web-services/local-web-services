@lambdacognito @generated
Feature: LambdaCognito - The Lambda Function Fails To Call Cognito Because The Pool Has Been Deleted

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_pool_deleted
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted
    Given an invocation is "IN_PROGRESS"
    And the pool is "DELETED"
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then the invocation is "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @standard @negative @invocation_fails_pool_deleted @lifecycle @internal
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then the operation is rejected

  @standard @negative @invocation_fails_pool_deleted @lifecycle @internal
  Scenario: the Lambda function fails to call Cognito because the pool has been deleted fails when the pool is not "DELETED"
    Given an invocation is "IN_PROGRESS"
    And the pool is not "DELETED"
    When the Lambda function fails to call Cognito because the pool has been deleted
    Then the operation is rejected
