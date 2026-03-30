@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - A Step Functions Express Workflow State Machine Is Created

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a Step Functions Express Workflow state machine is created
    Given the state machine does not already exist
    When a Step Functions Express Workflow state machine is created
    Then the state machine is "ACTIVE"
    And every "IN_PROGRESS" request references an "ACTIVE" "API"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution has a corresponding "IN_PROGRESS" request

  @guard @negative @create_state_machine
  Scenario: a Step Functions Express Workflow state machine is created fails when the state machine already exists
    Given the state machine already exists
    When a Step Functions Express Workflow state machine is created
    Then the operation is rejected
