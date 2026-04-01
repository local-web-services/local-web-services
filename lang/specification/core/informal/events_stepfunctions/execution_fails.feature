@eventsstepfunctions @generated
Feature: EventsStepfunctions - A Running "Step Functions" "Execution" Fails

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @minimal @happy @execution_fails @internal
  Scenario: a running "step functions" "execution" fails
    Given a "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails
    Then the "step functions" "execution" will be "FAILED"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @guard @negative @execution_fails @internal
  Scenario: a running "step functions" "execution" fails fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" fails
    Then the operation is rejected
