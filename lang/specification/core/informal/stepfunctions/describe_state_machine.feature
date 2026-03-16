@stepfunctions @generated
Feature: Stepfunctions - A State Machine Is Described

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @describe_state_machine
  Scenario: a state machine is described
    Given the state machine exists
    And the state machine is "ACTIVE"
    When a state machine is described
    Then the state machine details are returned
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @describe_state_machine
  Scenario: a state machine is described fails when the state machine does not exist
    Given the state machine does not exist
    When a state machine is described
    Then the operation is rejected

  @standard @negative @describe_state_machine @lifecycle
  Scenario: a state machine is described fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When a state machine is described
    Then the operation is rejected
