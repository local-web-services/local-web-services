@stepfunctions @generated
Feature: Stepfunctions - Versions Of A State Machine Are Listed

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @list_state_machine_versions
  Scenario: versions of a state machine are listed
    Given the state machine exists
    And the state machine is "ACTIVE"
    When versions of a state machine are listed
    Then the list of state machine versions is returned
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @list_state_machine_versions
  Scenario: versions of a state machine are listed fails when the state machine does not exist
    Given the state machine does not exist
    When versions of a state machine are listed
    Then the operation is rejected

  @standard @negative @list_state_machine_versions @lifecycle @internal
  Scenario: versions of a state machine are listed fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When versions of a state machine are listed
    Then the operation is rejected
