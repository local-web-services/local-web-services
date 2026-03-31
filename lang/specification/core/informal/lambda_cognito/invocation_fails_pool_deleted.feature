@lambdacognito @generated
Feature: LambdaCognito - The "Lambda" "Function" Fails To Call Cognito Because The "Cognito" "User Pool" Has Been Deleted

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails_pool_deleted
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "cognito" "user pool" was "DELETED"
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Then the invocation will be "FAILED" with a ResourceNotFoundException
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every successful invocation recorded which pool it called

  @guard @negative @invocation_fails_pool_deleted @lifecycle
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Then the operation is rejected

  @guard @negative @invocation_fails_pool_deleted @lifecycle
  Scenario: the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted fails when the "cognito" "user pool" was not "DELETED"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "cognito" "user pool" was not "DELETED"
    When the "lambda" "function" fails to call Cognito because the "cognito" "user pool" has been deleted
    Then the operation is rejected
