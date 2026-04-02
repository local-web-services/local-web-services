@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - The Step Functions Execution Completes Successfully And The "Api Gateway" "Api" Returns A Successful Response

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds @internal
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Given a "step functions" "execution" was "RUNNING"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Then the "step functions" "execution" will be "SUCCEEDED" and the "api gateway" "request" will be "SUCCESS"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @execution_succeeds @internal
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Then the operation is rejected
