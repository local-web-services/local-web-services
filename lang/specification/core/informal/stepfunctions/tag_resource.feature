@stepfunctions @generated
Feature: Stepfunctions - Tags Are Added To A State Machine

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: tags are added to a state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    When tags are added to a state machine
    Then the tags are associated with the state machine
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @tag_resource
  Scenario: tags are added to a state machine fails when the state machine does not exist
    Given the state machine does not exist
    When tags are added to a state machine
    Then the operation is rejected

  @standard @negative @tag_resource @lifecycle @internal
  Scenario: tags are added to a state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When tags are added to a state machine
    Then the operation is rejected
