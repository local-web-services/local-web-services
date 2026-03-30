@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Dynamodb Table Is Created

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_table
  Scenario: a DynamoDB table is created
    Given the table does not already exist
    When a DynamoDB table is created
    Then the table is "ACTIVE"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @guard @negative @create_table
  Scenario: a DynamoDB table is created fails when the table already exists
    Given the table already exists
    When a DynamoDB table is created
    Then the operation is rejected
