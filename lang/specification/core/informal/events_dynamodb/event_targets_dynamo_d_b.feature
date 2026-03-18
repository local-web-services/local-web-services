@eventsdynamodb @generated
Feature: EventsDynamodb - An Event Matches An Enabled Rule And Eventbridge Writes An Item To The Dynamodb Target

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_targets_dynamo_d_b
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given a rule is "ENABLED"
    And the target table is "ACTIVE"
    And an event slot is available
    And an item slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the item "EXISTS" in the table and the event is recorded as "MATCHED"
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @standard @negative @event_targets_dynamo_d_b @lifecycle @internal
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no rule is "ENABLED"
    Given no rule is "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @standard @negative @event_targets_dynamo_d_b @lifecycle @internal
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when the target table is not "ACTIVE"
    Given a rule is "ENABLED"
    And the target table is not "ACTIVE"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @standard @negative @event_targets_dynamo_d_b @capacity @internal
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no event slot is available
    Given a rule is "ENABLED"
    And the target table is "ACTIVE"
    And no event slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @standard @negative @event_targets_dynamo_d_b @capacity @internal
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no item slot is available
    Given a rule is "ENABLED"
    And the target table is "ACTIVE"
    And an event slot is available
    And no item slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected
