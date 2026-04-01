@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Event" Matches An "Enabled" "Eventbridge" "Rule" And Writes An "Item" To The "Dynamodb" Target

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_targets_dynamo_d_b
  Scenario: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    And a "dynamodb" "item" "slot" was "available"
    When an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Then the "dynamodb" "item" will exist in the "dynamodb" "table" and the "eventbridge" "event" will be "MATCHED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @event_targets_dynamo_d_b @lifecycle
  Scenario: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target fails when no "eventbridge" "rule" was "ENABLED"
    Given no "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @lifecycle
  Scenario: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target fails when the target "dynamodb" "table" was not "ACTIVE"
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was not "ACTIVE"
    When an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @capacity
  Scenario: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target fails when no "eventbridge" "event" "slot" was "available"
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @capacity
  Scenario: an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target fails when no "dynamodb" "item" "slot" was "available"
    Given a "eventbridge" "rule" was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    And no "dynamodb" "item" "slot" was "available"
    When an "eventbridge" "event" matches an "ENABLED" "eventbridge" "rule" and writes an "item" to the "dynamodb" target
    Then the operation is rejected
