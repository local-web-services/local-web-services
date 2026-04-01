@eventsstepfunctions @generated
Feature: EventsStepfunctions - An Eventbridge Event Bus Is Created

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @create_event_bus
  Scenario: an EventBridge event bus is created
    Given the event bus did not already exist
    When an EventBridge event bus is created
    Then the event bus will be "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @create_event_bus
  Scenario: an EventBridge event bus is created fails when the event bus already existed
    Given the event bus already existed
    When an EventBridge event bus is created
    Then the operation is rejected
