@stepfunctionsevents @generated
Feature: StepfunctionsEvents - An Execution Starts And Step Functions Delivers A Started Event To The Eventbridge Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_delivered
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "ACTIVE"
    And an "step functions" "execution" slot is available
    And an event slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the "step functions" "execution" will be "RUNNING" and the "STARTED" event will be "DELIVERED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @start_execution_event_delivered @lifecycle
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the state machine has no EventBridge bus configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has no EventBridge bus configured
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @lifecycle
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the bus was "DELETED"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "DELETED"
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @capacity
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when no execution slot is available
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "ACTIVE"
    And no execution slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @guard @negative @start_execution_event_delivered @capacity
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when no event slot is available
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus was "ACTIVE"
    And an "step functions" "execution" slot is available
    And no event slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected
