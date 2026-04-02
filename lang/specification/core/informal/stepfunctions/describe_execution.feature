@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "Execution" Is Described

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @describe_execution
  Scenario: a "step functions" "execution" is described
    Given the "step functions" "execution" existed
    When a "step functions" "execution" is described
    Then the "step functions" "execution" details will be returned
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @describe_execution
  Scenario: a "step functions" "execution" is described fails when the "step functions" "execution" did not exist
    Given the "step functions" "execution" did not exist
    When a "step functions" "execution" is described
    Then the operation is rejected
