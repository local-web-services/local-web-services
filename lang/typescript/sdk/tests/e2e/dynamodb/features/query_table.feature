@dynamodb @generated
Feature: DynamoDB - The "DynamoDB" "Table" Is Queried By Key

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @query_table
  Scenario: the "dynamodb" "table" is queried by pk and returns the item
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" existed
    When the "dynamodb" "table" is queried by "pk"
    Then the "dynamodb" query returns the "item"
