@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Request Is Received, The "Api Gateway" "Api" Writes To The "Dynamodb" "Table", And Returns 200

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_succeeds
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was "ACTIVE"
    And a "request" "slot" was "available"
    And an "item" "slot" was "available"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the "dynamodb" "item" will exist and the "api gateway" "request" will be "SUCCESS"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "api" was not "ACTIVE"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 fails when the "api gateway" "api" has no "dynamodb" integration configured
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has no "dynamodb" integration configured
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @lifecycle
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 fails when the target "dynamodb" "table" was not "ACTIVE"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was not "ACTIVE"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @capacity
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 fails when no "request" "slot" was "available"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was "ACTIVE"
    And no "request" "slot" was "available"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the operation is rejected

  @guard @negative @request_succeeds @capacity
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 fails when no "item" "slot" was "available"
    Given the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "api" has a "dynamodb" integration configured
    And the target "dynamodb" "table" was "ACTIVE"
    And a "request" "slot" was "available"
    And no "item" "slot" was "available"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Then the operation is rejected
