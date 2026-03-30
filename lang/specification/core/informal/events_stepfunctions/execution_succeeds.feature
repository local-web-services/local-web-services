@eventsstepfunctions @generated
Feature: EventsStepfunctions - A Running Execution Completes Successfully

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds @internal
  Scenario: a running execution completes successfully
    Given an execution is "RUNNING"
    When a running execution completes successfully
    Then the execution is "SUCCEEDED"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @execution_succeeds @internal
  Scenario: a running execution completes successfully fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution completes successfully
    Then the operation is rejected
