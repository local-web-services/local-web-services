@stepfunctions @generated
Feature: Stepfunctions - Executions For A "Step Functions" "State Machine" Are Listed

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @list_executions
  Scenario: executions for a "step functions" "state machine" are listed
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When executions for a "step functions" "state machine" are listed
    Then the list of executions will be returned
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @list_executions
  Scenario: executions for a "step functions" "state machine" are listed fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When executions for a "step functions" "state machine" are listed
    Then the operation is rejected

  @guard @negative @list_executions @lifecycle
  Scenario: executions for a "step functions" "state machine" are listed fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When executions for a "step functions" "state machine" are listed
    Then the operation is rejected
