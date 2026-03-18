@stepfunctions @generated
Feature: Stepfunctions - A Synchronous Execution Is Started On An Express State Machine

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_sync_execution
  Scenario: a synchronous execution is started on an express state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is an "EXPRESS" type
    And the execution slot is available
    When a synchronous execution is started on an express state machine
    Then the execution is "SUCCEEDED" or "FAILED"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @start_sync_execution
  Scenario: a synchronous execution is started on an express state machine fails when the state machine does not exist
    Given the state machine does not exist
    When a synchronous execution is started on an express state machine
    Then the operation is rejected

  @standard @negative @start_sync_execution @lifecycle @internal
  Scenario: a synchronous execution is started on an express state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When a synchronous execution is started on an express state machine
    Then the operation is rejected

  @standard @negative @start_sync_execution
  Scenario: a synchronous execution is started on an express state machine fails when the state machine is not an "EXPRESS" type
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is not an "EXPRESS" type
    When a synchronous execution is started on an express state machine
    Then the operation is rejected

  @standard @negative @start_sync_execution @capacity @internal
  Scenario: a synchronous execution is started on an express state machine fails when the execution slot is not available
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine is an "EXPRESS" type
    And the execution slot is not available
    When a synchronous execution is started on an express state machine
    Then the operation is rejected
