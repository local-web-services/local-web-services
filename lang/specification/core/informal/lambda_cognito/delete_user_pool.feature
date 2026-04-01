@lambdacognito @generated
Feature: LambdaCognito - A "Cognito" "User Pool" Is Deleted

  # Generated from FizzBee spec: lambda_cognito.fizz
  # Safety invariants: InvocationRequiresActiveFunction, SuccessfulInvocationCalledAPool

  Background:
    Given the system is initialized

  @minimal @happy @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" was "ACTIVE"
    When a "cognito" "user pool" is deleted
    Then the "cognito" "user pool" will be deleted and Lambda calls targeting it will fail
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every successful "lambda" "invocation" recorded which "cognito" "user pool" it called

  @guard @negative @delete_user_pool
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" did not exist
    Given the "cognito" "user pool" did not exist
    When a "cognito" "user pool" is deleted
    Then the operation is rejected

  @guard @negative @delete_user_pool @lifecycle
  Scenario: a "cognito" "user pool" is deleted fails when the "cognito" "user pool" is already "DELETED"
    Given the "cognito" "user pool" existed
    And the "cognito" "user pool" is already "DELETED"
    When a "cognito" "user pool" is deleted
    Then the operation is rejected
