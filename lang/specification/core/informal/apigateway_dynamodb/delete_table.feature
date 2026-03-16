@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Table Deletion Is Initiated

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a table deletion is initiated
    Given the table exists
    And the table is "ACTIVE"
    When a table deletion is initiated
    Then the table is "DELETING" and "API" requests targeting it will fail
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @standard @negative @delete_table
  Scenario: a table deletion is initiated fails when the table does not exist
    Given the table does not exist
    When a table deletion is initiated
    Then the operation is rejected

  @standard @negative @delete_table @lifecycle
  Scenario: a table deletion is initiated fails when the table is already "DELETING"
    Given the table exists
    And the table is already "DELETING"
    When a table deletion is initiated
    Then the operation is rejected
