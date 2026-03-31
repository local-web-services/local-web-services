@eventsdynamodb @generated
Feature: EventsDynamodb - An Event Matches An Enabled Rule But The Dynamodb Write Fails Because The "Dynamodb" "Table" Is Being Deleted

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_target_fails
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was "DELETING"
    And an event slot is available
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the event will be "MATCHED" but no item will be written
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @guard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when no rule was "ENABLED"
    Given no rule was "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when the target "dynamodb" "table" was not "DELETING"
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was not "DELETING"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @event_target_fails @capacity
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when no event slot is available
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was "DELETING"
    And no event slot is available
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected
