@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A "Step Functions" "Execution" Starts And "Step Functions" Delivers A "Started" Event To The "Eventbridge" "Bus"

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_delivered
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "ACTIVE"
    And an "step functions" "execution" slot is available
    And an "eventbridge" "event" "slot" was "available"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the "step functions" "execution" will be "RUNNING" and the "STARTED" event will be "DELIVERED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @guard @negative @start_execution_event_delivered @lifecycle
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" fails when the "step functions" "state machine" has no "eventbridge" "bus" configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has no "eventbridge" "bus" configured
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @lifecycle
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" fails when the "eventbridge" "bus" was "DELETED"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "DELETED"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @capacity
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" fails when no "step functions" "execution" "slot" was "available"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "ACTIVE"
    And no "step functions" "execution" "slot" was "available"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @capacity
  Scenario: a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus" fails when no "eventbridge" "event" "slot" was "available"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "ACTIVE"
    And an "step functions" "execution" slot is available
    And no "eventbridge" "event" "slot" was "available"
    When a "step functions" "execution" starts and "step functions" delivers a "STARTED" event to the "eventbridge" "bus"
    Then the operation is rejected
