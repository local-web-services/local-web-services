@stepfunctions @generated
Feature: Stepfunctions - A Running Execution Is Stopped

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @stop_execution
  Scenario: a running execution is stopped
    Given the execution existed
    And the execution was "RUNNING"
    When a running execution is stopped
    Then the execution will be "ABORTED"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @stop_execution
  Scenario: a running execution is stopped fails when the execution did not exist
    Given the execution did not exist
    When a running execution is stopped
    Then the operation is rejected

  @guard @negative @stop_execution @lifecycle
  Scenario: a running execution is stopped fails when the execution was not "RUNNING"
    Given the execution existed
    And the execution was not "RUNNING"
    When a running execution is stopped
    Then the operation is rejected
