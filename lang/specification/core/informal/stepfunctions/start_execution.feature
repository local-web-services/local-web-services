@stepfunctions @generated
Feature: Stepfunctions - An Execution Is Started On A Standard "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_execution
  Scenario: an execution is started on a standard "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is a "STANDARD" type
    And a "step functions" "execution" "slot" was "available"
    When an execution is started on a standard "step functions" "state machine"
    Then the "step functions" "execution" will be "RUNNING"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @start_execution
  Scenario: an execution is started on a standard "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When an execution is started on a standard "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_execution @lifecycle
  Scenario: an execution is started on a standard "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When an execution is started on a standard "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_execution
  Scenario: an execution is started on a standard "step functions" "state machine" fails when the "step functions" "state machine" is not a "STANDARD" type
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is not a "STANDARD" type
    When an execution is started on a standard "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_execution @capacity
  Scenario: an execution is started on a standard "step functions" "state machine" fails when no "step functions" "execution" "slot" was "available"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is a "STANDARD" type
    And no "step functions" "execution" "slot" was "available"
    When an execution is started on a standard "step functions" "state machine"
    Then the operation is rejected
