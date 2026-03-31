@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Direct "Dynamodb" Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_direct_integration
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no "dynamodb" integration configured
    And the "dynamodb" "table" existed and was "ACTIVE"
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    Then the "api gateway" "api" will write to the "dynamodb" "table" when requests are received
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @configure_direct_integration
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" fails when the "api gateway" "API" did not exist or was "ACTIVE"
    Given the "api gateway" "API" did not exist or was "ACTIVE"
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_direct_integration
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" fails when the "api gateway" "API" already has a DynamoDB integration configured
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "API" already has a DynamoDB integration configured
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    Then the operation is rejected

  @guard @negative @configure_direct_integration
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" fails when the "dynamodb" "table" did not exist or was "ACTIVE"
    Given the "api gateway" "API" existed and was "ACTIVE"
    And the "api gateway" "api" has no "dynamodb" integration configured
    And the "dynamodb" "table" did not exist or was "ACTIVE"
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    Then the operation is rejected
