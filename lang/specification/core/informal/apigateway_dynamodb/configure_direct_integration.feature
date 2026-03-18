@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Direct Dynamodb Integration Is Configured On The Api

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @configure_direct_integration
  Scenario: a direct DynamoDB integration is configured on the "API"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no DynamoDB integration configured
    And the table exists and is "ACTIVE"
    When a direct DynamoDB integration is configured on the "API"
    Then the "API" will write to the table when requests are received
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @standard @negative @configure_direct_integration
  Scenario: a direct DynamoDB integration is configured on the "API" fails when the "API" does not exist or is not "ACTIVE"
    Given the "API" does not exist or is not "ACTIVE"
    When a direct DynamoDB integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_direct_integration
  Scenario: a direct DynamoDB integration is configured on the "API" fails when the "API" already has a DynamoDB integration configured
    Given the "API" exists and is "ACTIVE"
    And the "API" already has a DynamoDB integration configured
    When a direct DynamoDB integration is configured on the "API"
    Then the operation is rejected

  @standard @negative @configure_direct_integration
  Scenario: a direct DynamoDB integration is configured on the "API" fails when the table does not exist or is not "ACTIVE"
    Given the "API" exists and is "ACTIVE"
    And the "API" has no DynamoDB integration configured
    And the table does not exist or is not "ACTIVE"
    When a direct DynamoDB integration is configured on the "API"
    Then the operation is rejected
