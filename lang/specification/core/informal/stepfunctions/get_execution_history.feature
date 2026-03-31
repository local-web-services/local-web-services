@stepfunctions @generated
Feature: Stepfunctions - The Event History Of An Execution Is Retrieved

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @get_execution_history
  Scenario: the event history of an execution is retrieved
    Given the execution existed
    When the event history of an execution is retrieved
    Then the execution history will be returned
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @get_execution_history
  Scenario: the event history of an execution is retrieved fails when the execution did not exist
    Given the execution did not exist
    When the event history of an execution is retrieved
    Then the operation is rejected
