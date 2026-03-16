@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - The Step Functions Execution Fails And The Api Returns An Error Response

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @execution_fails @internal
  Scenario: the Step Functions execution fails and the "API" returns an error response
    Given an execution is "RUNNING"
    When the Step Functions execution fails and the "API" returns an error response
    Then the execution is "FAILED" and the request is "FAILED"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @standard @negative @execution_fails @internal
  Scenario: the Step Functions execution fails and the "API" returns an error response fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When the Step Functions execution fails and the "API" returns an error response
    Then the operation is rejected
