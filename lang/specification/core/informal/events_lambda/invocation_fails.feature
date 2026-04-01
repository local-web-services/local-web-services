@eventslambda @generated
Feature: EventsLambda - The "Lambda" "Function" Invocation Fails

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails
    Given a "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the "lambda" "invocation" will be "FAILED"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @guard @negative @invocation_fails @internal
  Scenario: the "lambda" "function" invocation fails fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" invocation fails
    Then the operation is rejected
