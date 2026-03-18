@stepfunctionsevents @generated
Feature: StepfunctionsEvents - An Execution Starts But The Started Event Delivery Fails Because The Bus Is Deleted

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @start_execution_event_fails
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "DELETED"
    And an execution slot is available
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the execution is "RUNNING" but no "STARTED" event is delivered
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @standard @negative @start_execution_event_fails @lifecycle @internal
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the state machine does not exist or is not "ACTIVE"
    Given the state machine does not exist or is not "ACTIVE"
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @start_execution_event_fails
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the state machine has no EventBridge bus configured
    Given the state machine exists and is "ACTIVE"
    And the state machine has no EventBridge bus configured
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @start_execution_event_fails @lifecycle @internal
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when the bus is not "DELETED"
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is not "DELETED"
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected

  @standard @negative @start_execution_event_fails @capacity @internal
  Scenario: an execution starts but the "STARTED" event delivery fails because the bus is deleted fails when no execution slot is available
    Given the state machine exists and is "ACTIVE"
    And the state machine has an EventBridge bus configured
    And the bus is "DELETED"
    And no execution slot is available
    When an execution starts but the "STARTED" event delivery fails because the bus is deleted
    Then the operation is rejected
