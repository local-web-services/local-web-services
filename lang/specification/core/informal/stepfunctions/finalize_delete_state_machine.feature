@stepfunctions @generated
Feature: Stepfunctions - A State Machine Deletion Is Finalized

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @finalize_delete_state_machine @internal
  Scenario: a state machine deletion is finalized
    Given the state machine exists
    And the state machine is "DELETING"
    When a state machine deletion is finalized
    Then the state machine is "DELETED"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @finalize_delete_state_machine @internal
  Scenario: a state machine deletion is finalized fails when the state machine does not exist
    Given the state machine does not exist
    When a state machine deletion is finalized
    Then the operation is rejected

  @guard @negative @finalize_delete_state_machine @internal
  Scenario: a state machine deletion is finalized fails when the state machine is not "DELETING"
    Given the state machine exists
    And the state machine is not "DELETING"
    When a state machine deletion is finalized
    Then the operation is rejected
