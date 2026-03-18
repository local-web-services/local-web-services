@stepfunctions @generated
Feature: Stepfunctions - A Step Functions State Machine Is Created

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a Step Functions state machine is created
    Given the state machine does not already exist
    When a Step Functions state machine is created
    Then the state machine is "ACTIVE"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @create_state_machine
  Scenario: a Step Functions state machine is created fails when the state machine already exists
    Given the state machine already exists
    When a Step Functions state machine is created
    Then the operation is rejected
