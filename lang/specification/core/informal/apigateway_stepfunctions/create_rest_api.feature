@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - A Rest Api Is Created

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @create_rest_api
  Scenario: a "REST" "API" is created
    Given the "API" does not already exist
    When a "REST" "API" is created
    Then the "API" is "ACTIVE" with no Step Functions integration configured
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @standard @negative @create_rest_api
  Scenario: a "REST" "API" is created fails when the "API" already exists
    Given the "API" already exists
    When a "REST" "API" is created
    Then the operation is rejected
