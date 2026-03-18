@eventsdynamodb @generated
Feature: EventsDynamodb - An Eventbridge Rule Is Disabled

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @disable_rule
  Scenario: an EventBridge rule is disabled
    Given the rule exists
    And the rule is "ENABLED"
    When an EventBridge rule is disabled
    Then the rule is "DISABLED" and will not match events
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @standard @negative @disable_rule
  Scenario: an EventBridge rule is disabled fails when the rule does not exist
    Given the rule does not exist
    When an EventBridge rule is disabled
    Then the operation is rejected

  @standard @negative @disable_rule @lifecycle @internal
  Scenario: an EventBridge rule is disabled fails when the rule is already "DISABLED"
    Given the rule exists
    And the rule is already "DISABLED"
    When an EventBridge rule is disabled
    Then the operation is rejected
