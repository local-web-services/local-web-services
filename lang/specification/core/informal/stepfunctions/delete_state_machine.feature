@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "State Machine" Is Deleted

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @delete_state_machine
  Scenario: a "step functions" "state machine" is deleted
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When a "step functions" "state machine" is deleted
    Then the "step functions" "state machine" will be in "DELETING" state
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @delete_state_machine
  Scenario: a "step functions" "state machine" is deleted fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "step functions" "state machine" is deleted
    Then the operation is rejected

  @guard @negative @delete_state_machine @lifecycle
  Scenario: a "step functions" "state machine" is deleted fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "step functions" "state machine" is deleted
    Then the operation is rejected
