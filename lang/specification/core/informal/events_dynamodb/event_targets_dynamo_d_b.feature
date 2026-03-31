@eventsdynamodb @generated
Feature: EventsDynamodb - An Event Matches An Enabled Rule And Eventbridge Writes An Item To The Dynamodb Target

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @event_targets_dynamo_d_b
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And an event slot is available
    And an item slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the item will exist in the "dynamodb" "table" and the event will be recorded as "MATCHED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @guard @negative @event_targets_dynamo_d_b @lifecycle
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no rule was "ENABLED"
    Given no rule was "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @lifecycle
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when the target "dynamodb" "table" was not "ACTIVE"
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was not "ACTIVE"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @capacity
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no event slot is available
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And no event slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected

  @guard @negative @event_targets_dynamo_d_b @capacity
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target fails when no item slot is available
    Given a rule was "ENABLED"
    And the target "dynamodb" "table" was "ACTIVE"
    And an event slot is available
    And no item slot is available
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Then the operation is rejected
