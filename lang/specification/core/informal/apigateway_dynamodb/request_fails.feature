@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Request Is Received But The Dynamodb Write Fails Because The "Dynamodb" "Table" Is Being Deleted

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was "DELETING"
    And a "request" "slot" was "available"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the "api gateway" "request" will be "FAILED" and no "dynamodb" "item" will be written
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @request_fails
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when the "api gateway" "api" has no "dynamodb" integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no "dynamodb" integration configured
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @request_fails @lifecycle
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when the target "dynamodb" "table" was not "DELETING"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was not "DELETING"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected

  @guard @negative @request_fails @capacity
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted fails when no "request" "slot" was "available"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was "DELETING"
    And no "request" "slot" was "available"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Then the operation is rejected
