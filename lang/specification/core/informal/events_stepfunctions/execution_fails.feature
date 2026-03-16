@eventsstepfunctions @generated
Feature: EventsStepfunctions - A Running Execution Fails

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @execution_fails @internal
  Scenario: a running execution fails
    Given an execution is "RUNNING"
    When a running execution fails
    Then the execution is "FAILED"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @standard @negative @execution_fails @internal
  Scenario: a running execution fails fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution fails
    Then the operation is rejected
