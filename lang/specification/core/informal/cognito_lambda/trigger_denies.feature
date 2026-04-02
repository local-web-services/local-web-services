@cognitolambda @generated
Feature: CognitoLambda - The Pre-Signup "Lambda" "Function" Denies The Signup

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @trigger_denies @internal
  Scenario: the pre-signup "lambda" "function" denies the signup
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup "lambda" "function" denies the signup
    Then the invocation will be "FAILED" and the "cognito" "user" will be rejected
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" is for a "PENDING" "cognito" "user"
    And every "PENDING" "cognito" "user" has a corresponding "IN_PROGRESS" "lambda" "invocation"

  @guard @negative @trigger_denies @internal
  Scenario: the pre-signup "lambda" "function" denies the signup fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup "lambda" "function" denies the signup
    Then the operation is rejected
