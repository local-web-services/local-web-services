@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - The Step Functions Execution Fails And The "Api Gateway" "Api" Returns An Error Response

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @execution_fails @internal
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response
    Given a "step functions" "execution" was "RUNNING"
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    Then the "step functions" "execution" will be "FAILED" and the "api gateway" "request" will be "FAILED"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @execution_fails @internal
  Scenario: the Step Functions execution fails and the "api gateway" "API" returns an error response fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When the Step Functions execution fails and the "api gateway" "API" returns an error response
    Then the operation is rejected
