@dynamodb @generated
Feature: DynamoDB - A "DynamoDB" "Item" Is Deleted From The "DynamoDB" "Table"

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @delete_item
  Scenario: a "dynamodb" "item" is deleted from the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" existed
    When a "dynamodb" "item" is deleted from the "dynamodb" "table"
    Then the "dynamodb" "item" will be "ABSENT" from the "dynamodb" "table"
