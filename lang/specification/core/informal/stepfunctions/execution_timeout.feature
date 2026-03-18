@stepfunctions @generated
Feature: Stepfunctions - A Running Execution Exceeds Its Timeout

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @execution_timeout @internal
  Scenario: a running execution exceeds its timeout
    Given the execution exists
    And the execution is "RUNNING"
    When a running execution exceeds its timeout
    Then the execution is "TIMED_OUT"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @execution_timeout @internal
  Scenario: a running execution exceeds its timeout fails when the execution does not exist
    Given the execution does not exist
    When a running execution exceeds its timeout
    Then the operation is rejected

  @standard @negative @execution_timeout @internal
  Scenario: a running execution exceeds its timeout fails when the execution is not "RUNNING"
    Given the execution exists
    And the execution is not "RUNNING"
    When a running execution exceeds its timeout
    Then the operation is rejected
