@stepfunctions @generated
Feature: Stepfunctions - An Execution Is Started On A Standard State Machine

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_execution
  Scenario: an execution is started on a standard state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is a "STANDARD" type
    And the execution slot is available
    When an execution is started on a standard state machine
    Then the execution is "RUNNING"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @start_execution
  Scenario: an execution is started on a standard state machine fails when the state machine does not exist
    Given the state machine does not exist
    When an execution is started on a standard state machine
    Then the operation is rejected

  @standard @negative @start_execution @lifecycle
  Scenario: an execution is started on a standard state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When an execution is started on a standard state machine
    Then the operation is rejected

  @standard @negative @start_execution
  Scenario: an execution is started on a standard state machine fails when the state machine is not a "STANDARD" type
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is not a "STANDARD" type
    When an execution is started on a standard state machine
    Then the operation is rejected

  @standard @negative @internal @start_execution @capacity
  Scenario: an execution is started on a standard state machine fails when the execution slot is not available
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is a "STANDARD" type
    And the execution slot is not available
    When an execution is started on a standard state machine
    Then the operation is rejected
