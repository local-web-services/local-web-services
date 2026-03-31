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
    Then the "step functions" "execution" will be "SUCCEEDED" and the request will be "SUCCESS"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @guard @negative @execution_succeeds @internal
  Scenario: the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When the Step Functions execution completes successfully and the "api gateway" "API" returns a successful response
    Then the operation is rejected
