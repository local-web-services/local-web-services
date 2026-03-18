@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Request Is Received, The Api Writes To The Dynamodb Table, And Returns 200

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_succeeds
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is "ACTIVE"
    And a request slot is available
    And an item slot is available
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the item "EXISTS" and the request is "SUCCESS"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @standard @negative @request_succeeds @lifecycle @internal
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the operation is rejected

  @standard @negative @request_succeeds
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 fails when the "API" has no DynamoDB integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no DynamoDB integration configured
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the operation is rejected

  @standard @negative @request_succeeds @lifecycle @internal
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 fails when the target table is not "ACTIVE"
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is not "ACTIVE"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the operation is rejected

  @standard @negative @request_succeeds @capacity @internal
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is "ACTIVE"
    And no request slot is available
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the operation is rejected

  @standard @negative @request_succeeds @capacity @internal
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 fails when no item slot is available
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is "ACTIVE"
    And a request slot is available
    And no item slot is available
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then the operation is rejected
