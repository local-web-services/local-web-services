@stepfunctionsevents @generated
Feature: StepfunctionsEvents - The State Machine Is Configured To Publish Execution Events To The Event Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_event_publishing
  Scenario: the state machine is configured to publish execution events to the event bus
    Given the state machine exists and is "ACTIVE"
    And the state machine has no EventBridge bus configured
    And the bus exists and is "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the state machine will send execution state change events to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @standard @negative @configure_event_publishing @lifecycle @internal
  Scenario: the state machine is configured to publish execution events to the event bus fails when the state machine does not exist or is not "ACTIVE"
    Given the state machine does not exist or is not "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected

  @standard @negative @configure_event_publishing
  Scenario: the state machine is configured to publish execution events to the event bus fails when the state machine already has an EventBridge bus configured
    Given the state machine exists and is "ACTIVE"
    And the state machine already has an EventBridge bus configured
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected

  @standard @negative @configure_event_publishing @lifecycle @internal
  Scenario: the state machine is configured to publish execution events to the event bus fails when the bus does not exist or is not "ACTIVE"
    Given the state machine exists and is "ACTIVE"
    And the state machine has no EventBridge bus configured
    And the bus does not exist or is not "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected
