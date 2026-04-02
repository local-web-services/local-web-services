@eventslambda @generated
Feature: EventsLambda - An "Eventbridge" "Bus" Is Created

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an "eventbridge" "bus" is created
    Given the "eventbridge" "bus" did not already exist
    When an "eventbridge" "bus" is created
    Then the "eventbridge" "bus" will be "ACTIVE"
    And every "IN_PROGRESS" "lambda" "invocation" was triggered by an "ENABLED" "eventbridge" "rule"
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"

  @guard @negative @create_event_bus
  Scenario: an "eventbridge" "bus" is created fails when the "eventbridge" "bus" already existed
    Given the "eventbridge" "bus" already existed
    When an "eventbridge" "bus" is created
    Then the operation is rejected
