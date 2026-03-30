@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - An Api Gateway Rest Api Is Created

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_a_p_i
  Scenario: an "API" Gateway "REST" "API" is created
    Given the "API" does not already exist
    When an "API" Gateway "REST" "API" is created
    Then the "API" is "ACTIVE" with no DynamoDB integration configured
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @guard @negative @create_rest_a_p_i
  Scenario: an "API" Gateway "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When an "API" Gateway "REST" "API" is created
    Then the operation is rejected
