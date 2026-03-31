@stepfunctions @generated
Feature: Stepfunctions - An Execution Is Described

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @describe_execution
  Scenario: an execution is described
    Given the execution existed
    When an execution is described
    Then the execution details will be returned
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @describe_execution
  Scenario: an execution is described fails when the execution did not exist
    Given the execution did not exist
    When an execution is described
    Then the operation is rejected
