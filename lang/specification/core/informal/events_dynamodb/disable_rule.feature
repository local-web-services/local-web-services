@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Rule" Was "Disabled"

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @disable_rule
  Scenario: an "eventbridge" "rule" was "DISABLED"
    Given the rule existed
    And the rule was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    Then the rule will be "DISABLED" and will not match events
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @guard @negative @disable_rule
  Scenario: an "eventbridge" "rule" was "DISABLED" fails when the rule did not exist
    Given the rule did not exist
    When an "eventbridge" "rule" was "DISABLED"
    Then the operation is rejected

  @guard @negative @disable_rule @lifecycle
  Scenario: an "eventbridge" "rule" was "DISABLED" fails when the rule is already "DISABLED"
    Given the rule existed
    And the rule is already "DISABLED"
    When an "eventbridge" "rule" was "DISABLED"
    Then the operation is rejected
