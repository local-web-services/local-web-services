@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "State Machine" Definition Is Updated

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @update_state_machine
  Scenario: a "step functions" "state machine" definition is updated
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When a "step functions" "state machine" definition is updated
    Then the "step functions" "state machine" version will be incremented
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @update_state_machine
  Scenario: a "step functions" "state machine" definition is updated fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "step functions" "state machine" definition is updated
    Then the operation is rejected

  @guard @negative @update_state_machine @lifecycle
  Scenario: a "step functions" "state machine" definition is updated fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "step functions" "state machine" definition is updated
    Then the operation is rejected
