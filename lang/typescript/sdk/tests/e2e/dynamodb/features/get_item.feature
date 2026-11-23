@dynamodb @generated
Feature: DynamoDB - A "DynamoDB" "Item" Is Retrieved From The "DynamoDB" "Table"

  Background:
    Given the dynamodb system is initialized

  @minimal @happy @get_item
  Scenario: a "dynamodb" "item" is retrieved when it exists
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" existed
    When a "dynamodb" "item" is retrieved from the "dynamodb" "table"
    Then the retrieved "dynamodb" "item" is "PRESENT"

  @minimal @negative @get_item
  Scenario: a "dynamodb" "item" is retrieved when it does not exist
    Given the "dynamodb" "table" existed
    And the "dynamodb" "item" did not exist
    When a "dynamodb" "item" is retrieved from the "dynamodb" "table"
    Then the retrieved "dynamodb" "item" is "ABSENT"
