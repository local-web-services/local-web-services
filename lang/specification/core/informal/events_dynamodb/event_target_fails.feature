@eventsdynamodb @generated
Feature: EventsDynamodb - An Event Matches An Enabled Rule But The Dynamodb Write Fails Because The Table Is Being Deleted

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_target_fails
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given a rule is "ENABLED"
    And the target table is "DELETING"
    And an event slot is available
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Then the event is "MATCHED" but no item is written
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @standard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted fails when no rule is "ENABLED"
    Given no rule is "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected

  @standard @negative @event_target_fails @lifecycle
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted fails when the target table is not "DELETING"
    Given a rule is "ENABLED"
    And the target table is not "DELETING"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected

  @standard @negative @event_target_fails @capacity
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted fails when no event slot is available
    Given a rule is "ENABLED"
    And the target table is "DELETING"
    And no event slot is available
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected
