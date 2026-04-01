@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Rule" Is Created Targeting A "Dynamodb" "Table"

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given the "eventbridge" "bus" existed and was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    And the "dynamodb" "table" existed and was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the "eventbridge" "rule" will be "DISABLED" on the "eventbridge" "bus" with the "dynamodb" "table" target configured
    And every existing item references a "dynamodb" "table" that exists
    And every matched "eventbridge" "event" references an "eventbridge" "rule" that exists

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the "eventbridge" "bus" did not exist or was "ACTIVE"
    Given the "eventbridge" "bus" did not exist or was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the "eventbridge" "rule" already existed
    Given the "eventbridge" "bus" existed and was "ACTIVE"
    And the "eventbridge" "rule" already existed
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the "dynamodb" "table" did not exist or was "ACTIVE"
    Given the "eventbridge" "bus" existed and was "ACTIVE"
    And the "eventbridge" "rule" did not already exist
    And the "dynamodb" "table" did not exist or was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected
