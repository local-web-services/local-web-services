@eventsdynamodb @generated
Feature: EventsDynamodb - An Event Matches An Enabled Rule But The Dynamodb Write Fails Because The "Dynamodb" "Table" Is Being Deleted

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_target_fails
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was "DELETING"
    And an "eventbridge" "event" "slot" was "available"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the "eventbridge" "event" will be "MATCHED" but no "dynamodb" "item" will be written
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when no "eventbridge" "rule" was "ENABLED"
    Given no "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when the target "dynamodb" "table" was not "DELETING"
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was not "DELETING"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @event_target_fails @capacity
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when no "eventbridge" "event" "slot" was "available"
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was "DELETING"
    And no "eventbridge" "event" "slot" was "available"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected
