@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - Action Sequences

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created then a table deletion is initiated
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated then a DynamoDB table is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created then a table deletion is initiated
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated then a DynamoDB table is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created then a table deletion is initiated
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated then a DynamoDB table is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then a table deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then a DynamoDB table is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When an "API" Gateway "REST" "API" is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a table deletion is initiated
    And every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    When a request is received but the DynamoDB write fails because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    When a direct DynamoDB integration is configured on the "API"
    And every existing item references a table that exists
    And every successful request references an "API" that exists
