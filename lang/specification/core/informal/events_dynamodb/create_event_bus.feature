@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Bus" Is Created

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an "eventbridge" "bus" is created
    Given the "eventbridge" "bus" did not already exist
    When an "eventbridge" "bus" is created
    Then the "eventbridge" "bus" will be "ACTIVE"
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @create_event_bus
  Scenario: an "eventbridge" "bus" is created fails when the "eventbridge" "bus" already existed
    Given the "eventbridge" "bus" already existed
    When an "eventbridge" "bus" is created
    Then the operation is rejected
