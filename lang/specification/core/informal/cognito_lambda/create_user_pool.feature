@cognitolambda @generated
Feature: CognitoLambda - A "Cognito" "User Pool" Is Created

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a "cognito" "user pool" is created
    Given the "cognito" "user pool" did not already exist
    When a "cognito" "user pool" is created
    Then the "cognito" "user pool" will be "ACTIVE" with no pre-signup trigger configured
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @guard @negative @create_user_pool
  Scenario: a "cognito" "user pool" is created fails when the "cognito" "user pool" already existed
    Given the "cognito" "user pool" already existed
    When a "cognito" "user pool" is created
    Then the operation is rejected
