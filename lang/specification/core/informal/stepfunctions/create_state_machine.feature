@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "State Machine" Is Created

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @create_state_machine
  Scenario: a "step functions" "state machine" is created
    Given the "step functions" "state machine" did not already exist
    When a "step functions" "state machine" is created
    Then the "step functions" "state machine" will be "ACTIVE"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @create_state_machine
  Scenario: a "step functions" "state machine" is created fails when the "step functions" "state machine" already existed
    Given the "step functions" "state machine" already existed
    When a "step functions" "state machine" is created
    Then the operation is rejected
