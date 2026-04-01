@apigatewaystepfunctions @generated
Feature: ApigatewayStepfunctions - A "Step Functions" "Express Workflow State Machine" Is Created

  # Generated from FizzBee spec: apigateway_stepfunctions.fizz
  # Safety invariants: RequestRequiresActiveApi, ExecutionRequiresActiveStateMachine, ExecutionLinkedToRequest

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a "step functions" "Express Workflow state machine" is created
    Given the "step functions" "state machine" did not already exist
    When a "step functions" "Express Workflow state machine" is created
    Then the "step functions" "state machine" will be "ACTIVE"
    And every "IN_PROGRESS" "api gateway" "request" references an "ACTIVE" "api gateway" "API"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" has a corresponding "IN_PROGRESS" "api gateway" "request"

  @guard @negative @create_state_machine
  Scenario: a "step functions" "Express Workflow state machine" is created fails when the "step functions" "state machine" already existed
    Given the "step functions" "state machine" already existed
    When a "step functions" "Express Workflow state machine" is created
    Then the operation is rejected
