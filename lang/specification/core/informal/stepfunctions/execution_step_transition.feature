@stepfunctions @generated
Feature: Stepfunctions - A Running Execution Transitions To A Terminal State

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @execution_step_transition @internal
  Scenario: a running execution transitions to a terminal state
    Given the execution existed
    And the execution was "RUNNING"
    When a running execution transitions to a terminal state
    Then the execution will be "SUCCEEDED" or "FAILED"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @execution_step_transition @internal
  Scenario: a running execution transitions to a terminal state fails when the execution did not exist
    Given the execution did not exist
    When a running execution transitions to a terminal state
    Then the operation is rejected

  @guard @negative @execution_step_transition @internal
  Scenario: a running execution transitions to a terminal state fails when the execution was not "RUNNING"
    Given the execution existed
    And the execution was not "RUNNING"
    When a running execution transitions to a terminal state
    Then the operation is rejected
