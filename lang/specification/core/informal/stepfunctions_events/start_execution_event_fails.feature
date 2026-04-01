@stepfunctionsevents @generated
Feature: StepfunctionsEvents - A "Step Functions" "Execution" Starts But The "Started" "Eventbridge" "Event" Delivery Fails Because The "Eventbridge" "Bus" Is Deleted

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_fails
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "DELETED"
    And an "step functions" "execution" slot is available
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the "step functions" "execution" will be "RUNNING" but no "STARTED" event will be delivered
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "DELIVERED" "eventbridge" "event" references a "step functions" "execution" that exists

  @guard @negative @start_execution_event_fails @lifecycle
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when the "step functions" "state machine" has no "eventbridge" "bus" configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has no "eventbridge" "bus" configured
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails @lifecycle
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when the "eventbridge" "bus" was not "DELETED"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was not "DELETED"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails @capacity
  Scenario: a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted fails when no "step functions" "execution" "slot" was "available"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the "step functions" "state machine" has an "eventbridge" "bus" configured
    And the "eventbridge" "bus" was "DELETED"
    And no "step functions" "execution" "slot" was "available"
    When a "step functions" "execution" starts but the "STARTED" "eventbridge" "event" delivery fails because the "eventbridge" "bus" is deleted
    Then the operation is rejected
