@stepfunctions @generated
Feature: Stepfunctions - A State Machine Definition Is Validated

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @validate_state_machine_definition
  Scenario: a state machine definition is validated
    Given the state machine exists
    And the state machine is "ACTIVE"
    When a state machine definition is validated
    Then the definition is valid or invalid
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @validate_state_machine_definition
  Scenario: a state machine definition is validated fails when the state machine does not exist
    Given the state machine does not exist
    When a state machine definition is validated
    Then the operation is rejected

  @guard @negative @validate_state_machine_definition @lifecycle
  Scenario: a state machine definition is validated fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When a state machine definition is validated
    Then the operation is rejected
