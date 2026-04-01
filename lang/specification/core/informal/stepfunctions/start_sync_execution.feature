@stepfunctions @generated
Feature: Stepfunctions - A Synchronous Execution Is Started On An Express "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @start_sync_execution
  Scenario: a synchronous execution is started on an express "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is an "EXPRESS" type
    And a "step functions" "execution" "slot" was "available"
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the "step functions" "execution" will be "SUCCEEDED" or "FAILED"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @start_sync_execution
  Scenario: a synchronous execution is started on an express "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_sync_execution @lifecycle
  Scenario: a synchronous execution is started on an express "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_sync_execution
  Scenario: a synchronous execution is started on an express "step functions" "state machine" fails when the "step functions" "state machine" is not an "EXPRESS" type
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is not an "EXPRESS" type
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @start_sync_execution @capacity
  Scenario: a synchronous execution is started on an express "step functions" "state machine" fails when no "step functions" "execution" "slot" was "available"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the "step functions" "state machine" is an "EXPRESS" type
    And no "step functions" "execution" "slot" was "available"
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the operation is rejected
