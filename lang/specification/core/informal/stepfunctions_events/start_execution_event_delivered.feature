@stepfunctionsevents @generated
Feature: StepfunctionsEvents - An Execution Starts And Step Functions Delivers A Started Event To The Eventbridge Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_delivered
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "ACTIVE"
    And an execution slot is available
    And an event slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the execution is "RUNNING" and the "STARTED" event is "DELIVERED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @standard @negative @start_execution_event_delivered @lifecycle @internal
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the state machine does not exist or is not "ACTIVE"
    Given the state machine does not exist or is not "ACTIVE"
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @start_execution_event_delivered
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the state machine has no EventBridge bus configured
    Given the state machine exists and is "ACTIVE"
    And the state machine has no EventBridge bus configured
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @start_execution_event_delivered @lifecycle @internal
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when the bus is "DELETED"
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "DELETED"
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @start_execution_event_delivered @capacity @internal
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when no execution slot is available
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "ACTIVE"
    And no execution slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected

  @standard @negative @start_execution_event_delivered @capacity @internal
  Scenario: an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus fails when no event slot is available
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "ACTIVE"
    And an execution slot is available
    And no event slot is available
    When an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus
    Then the operation is rejected
