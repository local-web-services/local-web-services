@stepfunctions @generated
Feature: Stepfunctions - A Running Execution Is Stopped

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @stop_execution
  Scenario: a running execution is stopped
    Given the execution exists
    And the execution is "RUNNING"
    When a running execution is stopped
    Then the execution is "ABORTED"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @stop_execution
  Scenario: a running execution is stopped fails when the execution does not exist
    Given the execution does not exist
    When a running execution is stopped
    Then the operation is rejected

  @standard @negative @stop_execution @lifecycle
  Scenario: a running execution is stopped fails when the execution is not "RUNNING"
    Given the execution exists
    And the execution is not "RUNNING"
    When a running execution is stopped
    Then the operation is rejected
