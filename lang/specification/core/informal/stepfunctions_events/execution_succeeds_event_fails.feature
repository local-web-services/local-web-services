@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A Running Execution Succeeds But The Succeeded Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds_event_fails
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Given an execution is "RUNNING"
    And the bus is "DELETED"
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the execution is "SUCCEEDED" but no "SUCCEEDED" event is delivered
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @execution_succeeds_event_fails
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @execution_succeeds_event_fails @lifecycle
  Scenario: a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given an execution is "RUNNING"
    And the bus is not "DELETED"
    When a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted
    Then the operation is rejected
