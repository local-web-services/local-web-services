@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "State Machine" Deletion Is Finalized

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @finalize_delete_state_machine @internal
  Scenario: a "step functions" "state machine" deletion is finalized
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "DELETING"
    When a "step functions" "state machine" deletion is finalized
    Then the "step functions" "state machine" will be "DELETED"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @finalize_delete_state_machine @internal
  Scenario: a "step functions" "state machine" deletion is finalized fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "step functions" "state machine" deletion is finalized
    Then the operation is rejected

  @guard @negative @finalize_delete_state_machine @internal
  Scenario: a "step functions" "state machine" deletion is finalized fails when the "step functions" "state machine" was not "DELETING"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "DELETING"
    When a "step functions" "state machine" deletion is finalized
    Then the operation is rejected
