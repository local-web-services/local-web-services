@cognitolambda @generated
Feature: CognitoLambda - The Pre-Signup Lambda Denies The Signup

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @trigger_denies @internal
  Scenario: the pre-signup Lambda denies the signup
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup Lambda denies the signup
    Then the invocation will be "FAILED" and the "cognito" "user" will be rejected
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @trigger_denies @internal
  Scenario: the pre-signup Lambda denies the signup fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the pre-signup Lambda denies the signup
    Then the operation is rejected
