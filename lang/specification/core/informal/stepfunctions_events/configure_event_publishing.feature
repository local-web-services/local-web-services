@stepfunctionsevents @generated
Feature: StepfunctionsEvents - The State Machine Is Configured To Publish Execution Events To The Event Bus

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @configure_event_publishing
  Scenario: the state machine is configured to publish execution events to the event bus
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has no EventBridge bus configured
    And the bus existed and was "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the state machine will send execution state change events to the bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @configure_event_publishing @lifecycle
  Scenario: the state machine is configured to publish execution events to the event bus fails when the "step functions" "state machine" did not exist or was "ACTIVE"
    Given the "step functions" "state machine" did not exist or was "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected

  @guard @negative @configure_event_publishing
  Scenario: the state machine is configured to publish execution events to the event bus fails when the state machine already has an EventBridge bus configured
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine already has an EventBridge bus configured
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected

  @guard @negative @configure_event_publishing @lifecycle
  Scenario: the state machine is configured to publish execution events to the event bus fails when the bus did not exist or was "ACTIVE"
    Given the "step functions" "state machine" existed and was "ACTIVE"
    And the state machine has no EventBridge bus configured
    And the bus did not exist or was "ACTIVE"
    When the state machine is configured to publish execution events to the event bus
    Then the operation is rejected
