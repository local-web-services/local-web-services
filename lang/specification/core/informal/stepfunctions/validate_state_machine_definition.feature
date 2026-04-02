@stepfunctions @generated
Feature: Stepfunctions - A "Step Functions" "State Machine" Definition Is Validated

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @validate_state_machine_definition
  Scenario: a "step functions" "state machine" definition is validated
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When a "step functions" "state machine" definition is validated
    Then the "step functions" "state machine" definition will be valid or invalid
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @validate_state_machine_definition
  Scenario: a "step functions" "state machine" definition is validated fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "step functions" "state machine" definition is validated
    Then the operation is rejected

  @guard @negative @validate_state_machine_definition @lifecycle
  Scenario: a "step functions" "state machine" definition is validated fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "step functions" "state machine" definition is validated
    Then the operation is rejected
