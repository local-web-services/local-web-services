@cognitolambda @generated
Feature: CognitoLambda - The Pre-Signup "Lambda" "Function" Allows The Signup

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @trigger_allows @internal
  Scenario: the pre-signup "lambda" "function" allows the signup
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup "lambda" "function" allows the signup
    Then the invocation will be "SUCCESS" and the "cognito" "user" will be "CONFIRMED"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @guard @negative @trigger_allows @internal
  Scenario: the pre-signup "lambda" "function" allows the signup fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup "lambda" "function" allows the signup
    Then the operation is rejected
