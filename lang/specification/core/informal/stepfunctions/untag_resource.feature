@stepfunctions @generated
Feature: Stepfunctions - Tags Are Removed From A State Machine

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: tags are removed from a state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the tag is associated with the state machine
    And the tag association is active
    When tags are removed from a state machine
    Then the tags are disassociated from the state machine
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @standard @negative @untag_resource
  Scenario: tags are removed from a state machine fails when the state machine does not exist
    Given the state machine does not exist
    When tags are removed from a state machine
    Then the operation is rejected

  @standard @negative @untag_resource @lifecycle
  Scenario: tags are removed from a state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When tags are removed from a state machine
    Then the operation is rejected

  @standard @negative @untag_resource
  Scenario: tags are removed from a state machine fails when the tag is not associated with the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the tag is not associated with the state machine
    When tags are removed from a state machine
    Then the operation is rejected

  @standard @negative @untag_resource
  Scenario: tags are removed from a state machine fails when the tag association is not active
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the tag is associated with the state machine
    And the tag association is not active
    When tags are removed from a state machine
    Then the operation is rejected
