@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - An "Api Gateway" "Api" Is Created

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created
    Given the "api gateway" "API" did not already exist
    When an "api gateway" "api" is created
    Then the "api gateway" "api" will be "ACTIVE" with no DynamoDB integration configured
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @guard @negative @create_rest_a_p_i
  Scenario: an "api gateway" "api" is created fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When an "api gateway" "api" is created
    Then the operation is rejected
