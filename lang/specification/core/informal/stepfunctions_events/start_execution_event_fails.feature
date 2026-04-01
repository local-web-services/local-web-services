@stepfunctionsevents @generated
Feature: StepfunctionsEvents - An Execution Starts But The Started Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_fails
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "DELETED"
    And an "step functions" "execution" slot is available
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the "step functions" "execution" will be "RUNNING" but no "STARTED" event will be delivered
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @start_execution_event_fails @lifecycle
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the state machine has no EventBridge bus configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has no EventBridge bus configured
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails @lifecycle
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the bus was not "DELETED"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was not "DELETED"
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @guard @negative @start_execution_event_fails @capacity
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when no execution slot is available
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "DELETED"
    And no execution slot is available
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected
