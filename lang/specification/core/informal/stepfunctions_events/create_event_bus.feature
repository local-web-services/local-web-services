@stepfunctionsevents @generated
Feature: StepfunctionsEvents - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: stepfunctions_events.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, DeliveredEventReferencesExistingExecution

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the bus does not already exist
    When an EventBridge event bus is created
    Then the bus is "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "DELIVERED" event references an execution that exists

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the bus already exists
    Given the bus already exists
    When an EventBridge event bus is created
    Then the operation is rejected
