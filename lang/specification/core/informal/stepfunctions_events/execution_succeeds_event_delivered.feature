@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A Running Execution Succeeds And Step Functions Delivers A Succeeded Event To The Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds_event_delivered
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given an execution is "RUNNING"
    And the bus is "ACTIVE"
    And an event slot is available
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the execution is "SUCCEEDED" and the "SUCCEEDED" event is "DELIVERED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @standard @negative @execution_succeeds_event_delivered
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected

  @standard @negative @execution_succeeds_event_delivered @lifecycle
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when the bus is "DELETED"
    Given an execution is "RUNNING"
    And the bus is "DELETED"
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected

  @standard @negative @execution_succeeds_event_delivered @capacity
  Scenario: a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when no event slot is available
    Given an execution is "RUNNING"
    And the bus is "ACTIVE"
    And no event slot is available
    When a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected
