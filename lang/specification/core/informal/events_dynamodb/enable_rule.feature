@eventsdynamodb @generated
Feature: EventsDynamodb - An Eventbridge Rule Is Enabled

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @enable_rule
  Scenario: an EventBridge rule is enabled
    Given the rule exists
    And the rule is "DISABLED"
    When an EventBridge rule is enabled
    Then the rule is "ENABLED" and will match events
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @guard @negative @enable_rule
  Scenario: an EventBridge rule is enabled fails when the rule does not exist
    Given the rule does not exist
    When an EventBridge rule is enabled
    Then the operation is rejected

  @guard @negative @enable_rule @lifecycle
  Scenario: an EventBridge rule is enabled fails when the rule is already "ENABLED"
    Given the rule exists
    And the rule is already "ENABLED"
    When an EventBridge rule is enabled
    Then the operation is rejected
