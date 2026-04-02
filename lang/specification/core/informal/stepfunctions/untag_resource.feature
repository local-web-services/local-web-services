@stepfunctions @generated
Feature: Stepfunctions - Tags Are Removed From A "Step Functions" "State Machine"

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: tags are removed from a "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the tag was associated with the "step functions" "state machine"
    And the "step functions" "state machine" tag association was "ACTIVE"
    When tags are removed from a "step functions" "state machine"
    Then the tags are disassociated from the "step functions" "state machine"
    And every "step functions" "state machine" has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every "step functions" "execution" has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every "step functions" "state machine" has a valid type ("STANDARD" or "EXPRESS")
    And synchronous "step functions" "execution"s only run on express "step functions" "state machine"s
    And every "step functions" "execution" belongs to a known "step functions" "state machine"

  @guard @negative @untag_resource
  Scenario: tags are removed from a "step functions" "state machine" fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When tags are removed from a "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @untag_resource @lifecycle
  Scenario: tags are removed from a "step functions" "state machine" fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When tags are removed from a "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: tags are removed from a "step functions" "state machine" fails when the tag was not associated with the "step functions" "state machine"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the tag was not associated with the "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: tags are removed from a "step functions" "state machine" fails when the "step functions" "state machine" tag association was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the tag was associated with the "step functions" "state machine"
    And the "step functions" "state machine" tag association was not "ACTIVE"
    When tags are removed from a "step functions" "state machine"
    Then the operation is rejected
