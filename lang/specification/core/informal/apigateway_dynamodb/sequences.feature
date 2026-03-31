@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - Action Sequences

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "api gateway" "api" is created then a "dynamodb" "table" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "dynamodb" "table" deletion is initiated
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "api gateway" "api" is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "api gateway" "api" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a "dynamodb" "table" is created
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a "dynamodb" "table" deletion is initiated then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a "dynamodb" "table" deletion is initiated
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: an "api gateway" "api" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created
    Given aid not in api_status
    When an "api gateway" "api" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "api gateway" "api" is created then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "api gateway" "api" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then an "api gateway" "api" is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "api gateway" "api" is created then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "api gateway" "api" is created
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a direct "dynamodb" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a "dynamodb" "table" is created then an "api gateway" "api" is created
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a "dynamodb" "table" is created
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid in api_status
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then an "api gateway" "api" is created then a "dynamodb" "table" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When an "api gateway" "api" is created
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" deletion is initiated then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" deletion is initiated
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a direct "dynamodb" integration is configured on the "api gateway" "API" then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "api gateway" "api" is created then a "dynamodb" "table" deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "api gateway" "api" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created then a direct "dynamodb" integration is configured on the "api gateway" "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a direct "dynamodb" integration is configured on the "api gateway" "API" then an "api gateway" "api" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a direct "dynamodb" integration is configured on the "api gateway" "API"
    When an "api gateway" "api" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists

  @sequence
  Scenario: a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200 then a "dynamodb" "table" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a request is received, the "api gateway" "API" writes to the "dynamodb" "table", and returns 200
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every successful request references an "api gateway" "API" that exists
