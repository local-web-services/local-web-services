@eventsdynamodb @generated
Feature: EventsDynamodb - A Dynamodb Table Is Created

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a DynamoDB table is created
    Given the table does not already exist
    When a DynamoDB table is created
    Then the table is "ACTIVE"
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @guard @negative @create_table
  Scenario: a DynamoDB table is created fails when the table already exists
    Given the table already exists
    When a DynamoDB table is created
    Then the operation is rejected
