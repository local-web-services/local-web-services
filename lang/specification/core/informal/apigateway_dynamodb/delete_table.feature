@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A "Dynamodb" "Table" Deletion Is Initiated

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a "dynamodb" "table" deletion is initiated
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" was "ACTIVE"
    When a "dynamodb" "table" deletion is initiated
    Then the "dynamodb" "table" will be "DELETING" and "API" requests targeting it will fail
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @delete_table
  Scenario: a "dynamodb" "table" deletion is initiated fails when the "dynamodb" "table" did not exist
    Given the "dynamodb" "table" did not exist
    When a "dynamodb" "table" deletion is initiated
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a "dynamodb" "table" deletion is initiated fails when the "dynamodb" "table" is already "DELETING"
    Given the "dynamodb" "table" existed
    And the "dynamodb" "table" is already "DELETING"
    When a "dynamodb" "table" deletion is initiated
    Then the operation is rejected
