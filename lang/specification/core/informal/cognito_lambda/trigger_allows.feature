@cognitolambda @generated
Feature: CognitoLambda - The Pre-Signup Lambda Allows The Signup

  # Generated from FizzBee spec: cognito_lambda.fizz
  # Safety invariants: InvocationRequiresActiveFunction, InvocationLinkedToPendingUser, PendingSignupHasInProgressInvocation

  Background:
    Given the system is initialized

  @minimal @happy @trigger_allows @internal
  Scenario: the pre-signup Lambda allows the signup
    Given an invocation is "IN_PROGRESS"
    When the pre-signup Lambda allows the signup
    Then the invocation is "SUCCESS" and the user is "CONFIRMED"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "IN_PROGRESS" invocation is for a "PENDING" user
    And every "PENDING" user has a corresponding "IN_PROGRESS" invocation

  @guard @negative @trigger_allows @internal
  Scenario: the pre-signup Lambda allows the signup fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the pre-signup Lambda allows the signup
    Then the operation is rejected
