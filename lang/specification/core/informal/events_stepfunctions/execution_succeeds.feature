@eventsstepfunctions @generated
Feature: EventsStepfunctions - A Running "Step Functions" "Execution" Completes Successfully

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @execution_succeeds @internal
  Scenario: a running "step functions" "execution" completes successfully
    Given a "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" completes successfully
    Then the "step functions" "execution" will be "SUCCEEDED"
    And every "ENABLED" rule references an "ACTIVE" event bus
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "RUNNING" execution was started by an "ENABLED" rule

  @guard @negative @execution_succeeds @internal
  Scenario: a running "step functions" "execution" completes successfully fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" completes successfully
    Then the operation is rejected
