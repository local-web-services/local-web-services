@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - An "Api Gateway" "Api" Is Created

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: an "api gateway" "api" is created
    Given the "api gateway" "API" did not already exist
    When an "api gateway" "api" is created
    Then the "api gateway" "api" will be "ACTIVE" with no Step Functions integration configured
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @guard @negative @create_rest_api
  Scenario: an "api gateway" "api" is created fails when the "api gateway" "API" already existed
    Given the "api gateway" "API" already existed
    When an "api gateway" "api" is created
    Then the operation is rejected
