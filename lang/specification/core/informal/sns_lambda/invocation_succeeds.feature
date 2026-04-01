@snslambda @generated
Feature: SnsLambda - The "Lambda" "Function" Invocation Completes Successfully

  # Generated from FizzBee spec: sns_lambda.fizz
  # Safety invariants: SubscriptionReferencesActiveTopic, InvocationRequiresActiveFunction, InvocationRequiresConfirmedSubscription

  Background:
    Given the system is initialized

  @minimal @happy @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the "lambda" "invocation" will be "SUCCESS"
    And every "CONFIRMED" "sns" "subscription" references an "ACTIVE" "sns" "topic"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by a "CONFIRMED" "sns" "subscription"

  @guard @negative @invocation_succeeds @internal
  Scenario: the "lambda" "function" invocation completes successfully fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation completes successfully
    Then the operation is rejected
