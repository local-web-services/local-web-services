@stepfunctions @generated
Feature: Stepfunctions - Tags Are Added To A "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: tags are added to a "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    When tags are added to a "step functions" "state machine"
    Then the tags are associated with the "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @guard @negative @tag_resource
  Scenario: tags are added to a "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When tags are added to a "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: tags are added to a "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When tags are added to a "step functions" "state machine"
    Then the operation is rejected
