@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A Running "Step Functions" "Execution" Succeeds And Step Functions Delivers A Succeeded Event To The Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds_event_delivered
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Given a "step functions" "execution" was "RUNNING"
    And the "eventbridge" "bus" was "ACTIVE"
    And an "eventbridge" "event" "slot" was "available"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the "step functions" "execution" will be "SUCCEEDED" and the "SUCCEEDED" event will be "DELIVERED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @guard @negative @execution_succeeds_event_delivered
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected

  @guard @negative @execution_succeeds_event_delivered @lifecycle
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when the "eventbridge" "bus" was "DELETED"
    Given a "step functions" "execution" was "RUNNING"
    And the "eventbridge" "bus" was "DELETED"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected

  @guard @negative @execution_succeeds_event_delivered @capacity
  Scenario: a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus fails when no "eventbridge" "event" "slot" was "available"
    Given a "step functions" "execution" was "RUNNING"
    And the "eventbridge" "bus" was "ACTIVE"
    And no "eventbridge" "event" "slot" was "available"
    When a running "step functions" "execution" succeeds and Step Functions delivers a "SUCCEEDED" event to the bus
    Then the operation is rejected
