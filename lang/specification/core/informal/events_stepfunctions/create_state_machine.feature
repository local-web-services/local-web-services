@eventsstepfunctions @generated
Feature: EventsStepfunctions - A "Step Functions" "State Machine" Is Created

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a "step functions" "state machine" is created
    Given the "step functions" "state machine" did not already exist
    When a "step functions" "state machine" is created
    Then the "step functions" "state machine" will be "ACTIVE"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @create_state_machine
  Scenario: a "step functions" "state machine" is created fails when the "step functions" "state machine" already existed
    Given the "step functions" "state machine" already existed
    When a "step functions" "state machine" is created
    Then the operation is rejected
