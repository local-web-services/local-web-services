@eventsdynamodb @generated
Feature: EventsDynamodb - An "Eventbridge" "Rule" Is Created Targeting A "Dynamodb" "Table"

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given the bus existed and was "ACTIVE"
    And the rule did not already exist
    And the "dynamodb" "table" existed and was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the rule will be "DISABLED" on the bus with the DynamoDB target configured
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the bus did not exist or was "ACTIVE"
    Given the bus did not exist or was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the rule already existed
    Given the bus existed and was "ACTIVE"
    And the rule already existed
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" fails when the "dynamodb" "table" did not exist or was "ACTIVE"
    Given the bus existed and was "ACTIVE"
    And the rule did not already exist
    And the "dynamodb" "table" did not exist or was "ACTIVE"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Then the operation is rejected
