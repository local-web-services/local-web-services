@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Rule" Was "Enabled"

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @enable_rule
  Scenario: an "eventbridge" "rule" was "ENABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    Then the "eventbridge" "rule" will be "ENABLED" and will match events
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @enable_rule
  Scenario: an "eventbridge" "rule" was "ENABLED" fails when the "eventbridge" "rule" did not exist
    Given the "eventbridge" "rule" did not exist
    When an "eventbridge" "rule" was "ENABLED"
    Then the operation is rejected

  @guard @negative @enable_rule @lifecycle
  Scenario: an "eventbridge" "rule" was "ENABLED" fails when the "eventbridge" "rule" is already "ENABLED"
    Given the "eventbridge" "rule" existed
    And the "eventbridge" "rule" is already "ENABLED"
    When an "eventbridge" "rule" was "ENABLED"
    Then the operation is rejected
