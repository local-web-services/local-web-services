@stepfunctions @generated
Feature: Stepfunctions - A Running "Step Functions" "Execution" Transitions To A Terminal State

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @execution_step_transition @internal
  Scenario: a running "step functions" "execution" transitions to a terminal state
    Given the "step functions" "execution" existed
    And the "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" transitions to a terminal state
    Then the "step functions" "execution" will be "SUCCEEDED" or "FAILED"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @execution_step_transition @internal
  Scenario: a running "step functions" "execution" transitions to a terminal state fails when the "step functions" "execution" did not exist
    Given the "step functions" "execution" did not exist
    When a running "step functions" "execution" transitions to a terminal state
    Then the operation is rejected

  @guard @negative @execution_step_transition @internal
  Scenario: a running "step functions" "execution" transitions to a terminal state fails when the "step functions" "execution" was not "RUNNING"
    Given the "step functions" "execution" existed
    And the "step functions" "execution" was not "RUNNING"
    When a running "step functions" "execution" transitions to a terminal state
    Then the operation is rejected
