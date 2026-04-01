@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - A Step Functions Direct Integration Is Configured On The "Api Gateway" "Api"

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @configure_integration
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the "api gateway" "API" will synchronously start and await an Express Workflow execution per request
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @guard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" fails when the "api gateway" "API" did not exist
    Given the "api gateway" "API" did not exist
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" fails when the "api gateway" "api" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was not "ACTIVE"
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" fails when the "api gateway" "API" already had an "api gateway" "integration" configured
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" already had an "api gateway" "integration" configured
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" fails when the "step functions" "state machine" did not exist
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "step functions" "state machine" did not exist
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the operation is rejected

  @guard @negative @configure_integration @lifecycle
  Scenario: a Step Functions direct integration is configured on the "api gateway" "api" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "api gateway" "API" existed
    And the "api gateway" "api" was "ACTIVE"
    And the "api gateway" "API" had no integration configured
    And the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a Step Functions direct integration is configured on the "api gateway" "api"
    Then the operation is rejected
