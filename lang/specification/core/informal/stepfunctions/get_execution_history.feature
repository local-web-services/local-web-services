@stepfunctions @generated
Feature: Stepfunctions - The Event History Of A "Step Functions" "Execution" Is Retrieved

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @get_execution_history
  Scenario: the event history of a "step functions" "execution" is retrieved
    Given the "step functions" "execution" existed
    When the event history of a "step functions" "execution" is retrieved
    Then the "step functions" "execution" history will be returned
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @get_execution_history
  Scenario: the event history of a "step functions" "execution" is retrieved fails when the "step functions" "execution" did not exist
    Given the "step functions" "execution" did not exist
    When the event history of a "step functions" "execution" is retrieved
    Then the operation is rejected
