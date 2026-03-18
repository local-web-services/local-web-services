@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - A Request Is Received But The Dynamodb Write Fails Because The Table Is Being Deleted

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @minimal @happy @request_fails
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is "DELETING"
    And a request slot is available
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then the request is "FAILED" and no item is written
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @standard @negative @request_fails @lifecycle @internal
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted fails when the "API" is not "ACTIVE"
    Given the "API" is not "ACTIVE"
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected

  @standard @negative @request_fails
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted fails when the "API" has no DynamoDB integration configured
    Given the "API" is "ACTIVE"
    And the "API" has no DynamoDB integration configured
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected

  @standard @negative @request_fails @lifecycle @internal
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted fails when the target table is not "DELETING"
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is not "DELETING"
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected

  @standard @negative @request_fails @capacity @internal
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted fails when no request slot is available
    Given the "API" is "ACTIVE"
    And the "API" has a DynamoDB integration configured
    And the target table is "DELETING"
    And no request slot is available
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then the operation is rejected
