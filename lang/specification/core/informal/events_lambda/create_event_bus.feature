@eventslambda @generated
Feature: EventsLambda - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: events_lambda.fizz
  # Safety invariants: InvocationRequiresEnabledRule, InvocationRequiresActiveFunction, RuleReferencesActiveBus

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the event bus does not already exist
    When an EventBridge event bus is created
    Then the event bus is "ACTIVE"
    And every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "ENABLED" rule references an "ACTIVE" event bus

  @standard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the event bus already exists
    Given the event bus already exists
    When an EventBridge event bus is created
    Then the operation is rejected
