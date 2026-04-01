@eventssns @generated
Feature: EventsSns - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: events_sns.fizz
  # Safety invariants: RuleReferencesActiveBus, MessageRequiresActiveTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the event bus did not already exist
    When an EventBridge event bus is created
    Then the event bus will be "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "AVAILABLE" message belongs to an "ACTIVE" topic

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the event bus already existed
    Given the event bus already existed
    When an EventBridge event bus is created
    Then the operation is rejected
