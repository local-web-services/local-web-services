@stepfunctions @generated
Feature: Stepfunctions - A Running "Step Functions" "Execution" Is Stopped

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @stop_execution
  Scenario: a running "step functions" "execution" is stopped
    Given the "step functions" "execution" existed
    And the "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" is stopped
    Then the "step functions" "execution" will be "ABORTED"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @stop_execution
  Scenario: a running "step functions" "execution" is stopped fails when the "step functions" "execution" did not exist
    Given the "step functions" "execution" did not exist
    When a running "step functions" "execution" is stopped
    Then the operation is rejected

  @guard @negative @stop_execution @lifecycle
  Scenario: a running "step functions" "execution" is stopped fails when the "step functions" "execution" was not "RUNNING"
    Given the "step functions" "execution" existed
    And the "step functions" "execution" was not "RUNNING"
    When a running "step functions" "execution" is stopped
    Then the operation is rejected
