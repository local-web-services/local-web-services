@dynamodb @generated
Feature: DynamoDB - The "DynamoDB" "Table" Is Scanned

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @scan_table
  Scenario: the "dynamodb" "table" is scanned and returns items
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" existed
    When the "dynamodb" "table" is scanned
    Then the "dynamodb" "table" scan returns at least one "item"
