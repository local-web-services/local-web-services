@dynamodb @generated
Feature: DynamoDB - A "DynamoDB" "Item" Is Updated In The "DynamoDB" "Table"

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @update_item
  Scenario: a "dynamodb" "item" is updated in the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" existed
    When a "dynamodb" "item" is updated in the "dynamodb" "table"
    Then the "dynamodb" "item" data attribute will be "updated"
