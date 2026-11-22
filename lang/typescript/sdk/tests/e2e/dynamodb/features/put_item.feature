@dynamodb @generated
Feature: DynamoDB - A "DynamoDB" "Item" Is Put Into The "DynamoDB" "Table"

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @put_item
  Scenario: a "dynamodb" "item" is put into the "dynamodb" "table"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" did not exist
    When a "dynamodb" "item" is put into the "dynamodb" "table"
    Then the "dynamodb" "item" will be "PRESENT" in the "dynamodb" "table"

  @guard @negative @put_item
  Scenario: a "dynamodb" "item" is put into the "dynamodb" "table" fails when the "dynamodb" "table" did not exist
    When a "dynamodb" "item" is put into a non-existent "dynamodb" "table"
    Then the dynamodb operation is rejected
