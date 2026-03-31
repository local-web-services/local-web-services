@eventsdynamodb @generated
Feature: EventsDynamodb - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the bus did not already exist
    When an EventBridge event bus is created
    Then the bus will be "ACTIVE"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the bus already existed
    Given the bus already existed
    When an EventBridge event bus is created
    Then the operation is rejected
