@apigatewaydynamodb @generated
Feature: ApigatewayDynamodb - Action Sequences

  # Generated from FizzBee spec: apigateway_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, SuccessfulRequestReferencesExistingAPI

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    Given a DynamoDB table has been created
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    Given a DynamoDB table has been created
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    Given a table deletion has been initiated
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created
    Given tid in table_status
    Given a table deletion has been initiated
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    Given a table deletion has been initiated
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    Given a table deletion has been initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    Given a table deletion has been initiated
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a DynamoDB table is created then a table deletion is initiated
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a DynamoDB table has been created
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a table deletion has been initiated
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a direct DynamoDB integration has been configured on the "API"
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given aid not in api_status
    Given an "API" Gateway "REST" "API" has been created
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an "API" Gateway "REST" "API" is created then a direct DynamoDB integration is configured on the "API"
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given an "API" Gateway "REST" "API" has been created
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a table deletion has been initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a direct DynamoDB integration has been configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given tid not in table_status
    Given a DynamoDB table has been created
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an "API" Gateway "REST" "API" is created then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given tid in table_status
    Given a table deletion has been initiated
    Given an "API" Gateway "REST" "API" has been created
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    Given a table deletion has been initiated
    Given a DynamoDB table has been created
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given tid in table_status
    Given a table deletion has been initiated
    Given a direct DynamoDB integration has been configured on the "API"
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given tid in table_status
    Given a table deletion has been initiated
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API"
    Given tid in table_status
    Given a table deletion has been initiated
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    Given an "API" Gateway "REST" "API" has been created
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a DynamoDB table is created then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    Given a DynamoDB table has been created
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a table deletion is initiated then a DynamoDB table is created
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    Given a table deletion has been initiated
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    Given a direct DynamoDB integration has been configured on the "API"
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then an "API" Gateway "REST" "API" is created then a DynamoDB table is created
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    Given an "API" Gateway "REST" "API" has been created
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created then a table deletion is initiated
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    Given a DynamoDB table has been created
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a table deletion is initiated then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    Given a table deletion has been initiated
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a direct DynamoDB integration is configured on the "API" then a request is received but the DynamoDB write fails because the table is being deleted
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    Given a direct DynamoDB integration has been configured on the "API"
    When a request is received but the DynamoDB write fails because the table is being deleted
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received, the "API" writes to the DynamoDB table, and returns 200 then a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then an "API" Gateway "REST" "API" is created then a table deletion is initiated
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    Given an "API" Gateway "REST" "API" has been created
    When a table deletion is initiated
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then a direct DynamoDB integration is configured on the "API"
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    Given a DynamoDB table has been created
    When a direct DynamoDB integration is configured on the "API"
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then a request is received, the "API" writes to the DynamoDB table, and returns 200
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    Given a table deletion has been initiated
    When a request is received, the "API" writes to the DynamoDB table, and returns 200
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a direct DynamoDB integration is configured on the "API" then an "API" Gateway "REST" "API" is created
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    Given a direct DynamoDB integration has been configured on the "API"
    When an "API" Gateway "REST" "API" is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists

  @exhaustive @sequence
  Scenario: a request is received but the DynamoDB write fails because the table is being deleted then a request is received, the "API" writes to the DynamoDB table, and returns 200 then a DynamoDB table is created
    Given aid in api_status
    Given a request has been received but the DynamoDB write has failed because the table is being deleted
    Given a request has been received, the "API" has written to the DynamoDB table, and returned 200
    When a DynamoDB table is created
    Then every existing item references a table that exists
    And every successful request references an "API" that exists
