@eventsdynamodb @generated
Feature: EventsDynamodb - A "Dynamodb" "Table" Is Created

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a "dynamodb" "table" is created
    Given the "dynamodb" "table" did not already exist
    When a "dynamodb" "table" is created
    Then the "dynamodb" "table" will be "ACTIVE"
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @create_table
  Scenario: a "dynamodb" "table" is created fails when the "dynamodb" "table" already existed
    Given the "dynamodb" "table" already existed
    When a "dynamodb" "table" is created
    Then the operation is rejected
