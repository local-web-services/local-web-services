@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A Running "Step Functions" "Execution" Succeeds But The Succeeded Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds_event_fails
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given a "step functions" "execution" was "RUNNING"
    And the bus was "DELETED"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the "step functions" "execution" will be "SUCCEEDED" but no "SUCCEEDED" event will be delivered
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @execution_succeeds_event_fails
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @execution_succeeds_event_fails @lifecycle
  Scenario: a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the bus was not "DELETED"
    When a running "step functions" "execution" succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the operation is rejected
