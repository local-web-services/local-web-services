@stepfunctions @generated
Feature: Stepfunctions - Action Sequences

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is deleted
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" deletion is finalized
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" definition is updated
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is described
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then all state machines are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then versions of a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" definition is validated
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags are added to a "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags are removed from a "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags for a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution is started on a standard "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a synchronous execution is started on an express "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution is stopped
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution is described
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then executions for a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then the event history of an execution is retrieved
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution transitions to a terminal state
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution exceeds its timeout
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is created
    When all state machines are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is deleted
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" deletion is finalized
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" definition is updated
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is described
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then versions of a "step functions" "state machine" are listed
    When all state machines are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" definition is validated
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags are added to a "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags are removed from a "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags for a "step functions" "state machine" are listed
    When all state machines are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then an execution is started on a standard "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a synchronous execution is started on an express "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution is stopped
    When all state machines are listed
    Given eid in exec_status
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then an execution is described
    When all state machines are listed
    Given eid in exec_status
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then executions for a "step functions" "state machine" are listed
    When all state machines are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then the event history of an execution is retrieved
    When all state machines are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution transitions to a terminal state
    When all state machines are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution exceeds its timeout
    When all state machines are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then all state machines are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution is stopped
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then an execution is described
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then all state machines are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then all state machines are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then all state machines are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution is stopped
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then an execution is described
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then all state machines are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then all state machines are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then all state machines are listed
    Given eid in exec_status
    When a running execution is stopped
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then an execution is described
    Given eid in exec_status
    When a running execution is stopped
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution is stopped
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a running execution transitions to a terminal state
    Given eid in exec_status
    When a running execution is stopped
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a running execution exceeds its timeout
    Given eid in exec_status
    When a running execution is stopped
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is created
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is described
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then all state machines are listed
    Given eid in exec_status
    When an execution is described
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution is stopped
    Given eid in exec_status
    When an execution is described
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then the event history of an execution is retrieved
    Given eid in exec_status
    When an execution is described
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution transitions to a terminal state
    Given eid in exec_status
    When an execution is described
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution exceeds its timeout
    Given eid in exec_status
    When an execution is described
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then all state machines are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution is stopped
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then an execution is described
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is created
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is described
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then all state machines are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution is stopped
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then an execution is described
    Given eid in exec_status
    When the event history of an execution is retrieved
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution transitions to a terminal state
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution exceeds its timeout
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then all state machines are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a running execution is stopped
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then an execution is described
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a running execution exceeds its timeout
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then all state machines are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a running execution is stopped
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then an execution is described
    Given eid in exec_status
    When a running execution exceeds its timeout
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution exceeds its timeout
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a running execution transitions to a terminal state
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is deleted then a "step functions" "state machine" deletion is finalized
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is updated
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" definition is updated then a "step functions" "state machine" is described
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" is described then all state machines are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is described
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then all state machines are listed then versions of a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When all state machines are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a "step functions" "state machine" definition is validated then tags are added to a "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is validated
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags are added to a "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags are added to a "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags are removed from a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags are removed from a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then tags for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When tags for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution is started on a standard "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When an execution is started on a standard "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a synchronous execution is started on an express "step functions" "state machine" then a running execution is stopped
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution is stopped then an execution is described
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution is stopped
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then an execution is described then executions for a "step functions" "state machine" are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When an execution is described
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then executions for a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When executions for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then the event history of an execution is retrieved then a running execution transitions to a terminal state
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When the event history of an execution is retrieved
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution transitions to a terminal state then a running execution exceeds its timeout
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution transitions to a terminal state
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is created then a running execution exceeds its timeout then a "step functions" "state machine" is deleted
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is created then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is updated then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is updated
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" is described then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is described
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then all state machines are listed then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When all state machines are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then versions of a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When versions of a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is validated then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is validated
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags are added to a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags are added to a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags are removed from a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags are removed from a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then tags for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then an execution is started on a standard "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When an execution is started on a standard "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a synchronous execution is started on an express "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution is stopped then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution is stopped
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then an execution is described then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When an execution is described
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then executions for a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When executions for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then the event history of an execution is retrieved then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When the event history of an execution is retrieved
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution transitions to a terminal state then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is deleted then a running execution exceeds its timeout then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When a running execution exceeds its timeout
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is created then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is deleted then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is deleted
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is updated then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is updated
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is described then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then all state machines are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When all state machines are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then versions of a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When versions of a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is validated then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is validated
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags are added to a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags are added to a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags are removed from a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags are removed from a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then tags for a "step functions" "state machine" are listed then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags for a "step functions" "state machine" are listed
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then an execution is started on a standard "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When an execution is started on a standard "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a synchronous execution is started on an express "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a synchronous execution is started on an express "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution is stopped then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution is stopped
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then an execution is described then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When an execution is described
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then executions for a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When executions for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then the event history of an execution is retrieved then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution transitions to a terminal state then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" deletion is finalized then a running execution exceeds its timeout then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is created then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is created
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is deleted then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is deleted
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" is described then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is described
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then all state machines are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When all state machines are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then versions of a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When versions of a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a "step functions" "state machine" definition is validated then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" definition is validated
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags are added to a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags are added to a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags are removed from a "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags are removed from a "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then tags for a "step functions" "state machine" are listed then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags for a "step functions" "state machine" are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then an execution is started on a standard "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When an execution is started on a standard "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a synchronous execution is started on an express "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a synchronous execution is started on an express "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution is stopped then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution is stopped
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then an execution is described then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When an execution is described
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then the event history of an execution is retrieved then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution transitions to a terminal state then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is updated then a running execution exceeds its timeout then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" is created then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is created
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" deletion is finalized then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" deletion is finalized
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" definition is updated then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is updated
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then all state machines are listed then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When all state machines are listed
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then versions of a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When versions of a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a "step functions" "state machine" definition is validated then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is validated
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags are added to a "step functions" "state machine" then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags are added to a "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags are removed from a "step functions" "state machine" then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags are removed from a "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then tags for a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When tags for a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then an execution is started on a standard "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When an execution is started on a standard "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a synchronous execution is started on an express "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution is stopped then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution is stopped
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then an execution is described then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When an execution is described
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then the event history of an execution is retrieved then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When the event history of an execution is retrieved
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution transitions to a terminal state then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" is described then a running execution exceeds its timeout then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When a running execution exceeds its timeout
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is created then a "step functions" "state machine" definition is validated
    When all state machines are listed
    Given arn not in sm_status
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is deleted then tags are added to a "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is deleted
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" deletion is finalized then tags are removed from a "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" deletion is finalized
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" definition is updated then tags for a "step functions" "state machine" are listed
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is updated
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" is described then an execution is started on a standard "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" is described
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then versions of a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    When all state machines are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a "step functions" "state machine" definition is validated then a running execution is stopped
    When all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags are added to a "step functions" "state machine" then an execution is described
    When all state machines are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags are removed from a "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    When all state machines are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then tags for a "step functions" "state machine" are listed then the event history of an execution is retrieved
    When all state machines are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then an execution is started on a standard "step functions" "state machine" then a running execution transitions to a terminal state
    When all state machines are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a synchronous execution is started on an express "step functions" "state machine" then a running execution exceeds its timeout
    When all state machines are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution is stopped then a "step functions" "state machine" is created
    When all state machines are listed
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then an execution is described then a "step functions" "state machine" is deleted
    When all state machines are listed
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized
    When all state machines are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then the event history of an execution is retrieved then a "step functions" "state machine" definition is updated
    When all state machines are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution transitions to a terminal state then a "step functions" "state machine" is described
    When all state machines are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: all state machines are listed then a running execution exceeds its timeout then versions of a "step functions" "state machine" are listed
    When all state machines are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is created then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is described then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then all state machines are listed then a running execution is stopped
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When all state machines are listed
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated then an execution is described
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine" then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution is stopped then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution is stopped
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then an execution is described then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When an execution is described
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then the event history of an execution is retrieved then a "step functions" "state machine" is described
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution transitions to a terminal state then all state machines are listed
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: versions of a "step functions" "state machine" are listed then a running execution exceeds its timeout then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When versions of a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is created then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is created
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is deleted then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is deleted
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" deletion is finalized then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" deletion is finalized
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" definition is updated then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" definition is updated
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a "step functions" "state machine" is described then a running execution is stopped
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is described
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then all state machines are listed then an execution is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When all state machines are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then versions of a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When versions of a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags are added to a "step functions" "state machine" then the event history of an execution is retrieved
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags are added to a "step functions" "state machine"
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags are removed from a "step functions" "state machine" then a running execution transitions to a terminal state
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags are removed from a "step functions" "state machine"
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then tags for a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When tags for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution is stopped then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution is stopped
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then an execution is described then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When an execution is described
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then the event history of an execution is retrieved then all state machines are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When the event history of an execution is retrieved
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution transitions to a terminal state then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution transitions to a terminal state
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a "step functions" "state machine" definition is validated then a running execution exceeds its timeout then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a "step functions" "state machine" definition is validated
    When a running execution exceeds its timeout
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is created then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is created
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is deleted then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is updated then a running execution is stopped
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" is described then an execution is described
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is described
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then all state machines are listed then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When all state machines are listed
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then versions of a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is validated then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then tags are removed from a "step functions" "state machine" then a running execution exceeds its timeout
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution is stopped then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution is stopped
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then an execution is described then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When an execution is described
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then executions for a "step functions" "state machine" are listed then all state machines are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then the event history of an execution is retrieved then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When the event history of an execution is retrieved
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution transitions to a terminal state then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are added to a "step functions" "state machine" then a running execution exceeds its timeout then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When tags are added to a "step functions" "state machine"
    When a running execution exceeds its timeout
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is created then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is created
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is deleted then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized then a running execution is stopped
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is updated then an execution is described
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is described then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is described
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then all state machines are listed then the event history of an execution is retrieved
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When all state machines are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then versions of a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is validated then a running execution exceeds its timeout
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then tags are added to a "step functions" "state machine" then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution is stopped then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution is stopped
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then an execution is described then all state machines are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When an execution is described
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then executions for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then the event history of an execution is retrieved then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution transitions to a terminal state then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution transitions to a terminal state
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags are removed from a "step functions" "state machine" then a running execution exceeds its timeout then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags are removed from a "step functions" "state machine"
    When a running execution exceeds its timeout
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is created then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted then a running execution is stopped
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized then an execution is described
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is described then the event history of an execution is retrieved
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then all state machines are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When all state machines are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated then a "step functions" "state machine" is created
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine" then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution is stopped then all state machines are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution is stopped
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then an execution is described then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When an execution is described
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then the event history of an execution is retrieved then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution transitions to a terminal state then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: tags for a "step functions" "state machine" are listed then a running execution exceeds its timeout then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When tags for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is created then a running execution is stopped
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is created
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is deleted then an execution is described
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" deletion is finalized then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is updated then the event history of an execution is retrieved
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" is described then a running execution transitions to a terminal state
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" is described
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then all state machines are listed then a running execution exceeds its timeout
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When all state machines are listed
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is validated then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags are added to a "step functions" "state machine" then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then tags for a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine" then all state machines are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution is stopped then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution is stopped
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then an execution is described then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When an execution is described
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then executions for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then the event history of an execution is retrieved then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When the event history of an execution is retrieved
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution transitions to a terminal state then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution transitions to a terminal state
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is started on a standard "step functions" "state machine" then a running execution exceeds its timeout then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When an execution is started on a standard "step functions" "state machine"
    When a running execution exceeds its timeout
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is created then an execution is described
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is created
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is deleted then executions for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is deleted
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" deletion is finalized then the event history of an execution is retrieved
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" deletion is finalized
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" definition is updated then a running execution transitions to a terminal state
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" is described then a running execution exceeds its timeout
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" is described
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then all state machines are listed then a "step functions" "state machine" is created
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When all state machines are listed
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a "step functions" "state machine" definition is validated then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags are removed from a "step functions" "state machine" then a "step functions" "state machine" is described
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then tags for a "step functions" "state machine" are listed then all state machines are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then an execution is started on a standard "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution is stopped then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution is stopped
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then an execution is described then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is described
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then executions for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When executions for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then the event history of an execution is retrieved then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When the event history of an execution is retrieved
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution transitions to a terminal state then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution transitions to a terminal state
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a synchronous execution is started on an express "step functions" "state machine" then a running execution exceeds its timeout then a running execution is stopped
    Given arn in sm_status
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution exceeds its timeout
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is created then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is created
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is deleted then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is deleted
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" deletion is finalized then a running execution transitions to a terminal state
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" deletion is finalized
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" definition is updated then a running execution exceeds its timeout
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" definition is updated
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" is described then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then all state machines are listed then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution is stopped
    When all state machines are listed
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution is stopped
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a "step functions" "state machine" definition is validated then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution is stopped
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags are added to a "step functions" "state machine" then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution is stopped
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags are removed from a "step functions" "state machine" then all state machines are listed
    Given eid in exec_status
    When a running execution is stopped
    When tags are removed from a "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then tags for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When tags for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then an execution is started on a standard "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution is stopped
    When an execution is started on a standard "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a synchronous execution is started on an express "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then an execution is described then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When an execution is described
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then executions for a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution is stopped
    When executions for a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then the event history of an execution is retrieved then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When the event history of an execution is retrieved
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a running execution transitions to a terminal state then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution is stopped
    When a running execution transitions to a terminal state
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution is stopped then a running execution exceeds its timeout then an execution is described
    Given eid in exec_status
    When a running execution is stopped
    When a running execution exceeds its timeout
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is created then the event history of an execution is retrieved
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is created
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is deleted then a running execution transitions to a terminal state
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is deleted
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" deletion is finalized then a running execution exceeds its timeout
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" deletion is finalized
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" definition is updated then a "step functions" "state machine" is created
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" is described then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then all state machines are listed then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When an execution is described
    When all state machines are listed
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When an execution is described
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a "step functions" "state machine" definition is validated then a "step functions" "state machine" is described
    Given eid in exec_status
    When an execution is described
    When a "step functions" "state machine" definition is validated
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags are added to a "step functions" "state machine" then all state machines are listed
    Given eid in exec_status
    When an execution is described
    When tags are added to a "step functions" "state machine"
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags are removed from a "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When tags are removed from a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then tags for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When an execution is described
    When tags for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then an execution is started on a standard "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When an execution is started on a standard "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a synchronous execution is started on an express "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution is stopped then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When a running execution is stopped
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then executions for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When executions for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then the event history of an execution is retrieved then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When an execution is described
    When the event history of an execution is retrieved
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution transitions to a terminal state then a running execution is stopped
    Given eid in exec_status
    When an execution is described
    When a running execution transitions to a terminal state
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: an execution is described then a running execution exceeds its timeout then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When an execution is described
    When a running execution exceeds its timeout
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is created then a running execution transitions to a terminal state
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is created
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is deleted then a running execution exceeds its timeout
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is deleted
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is created
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is updated then a "step functions" "state machine" is deleted
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" is described then a "step functions" "state machine" deletion is finalized
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then all state machines are listed then a "step functions" "state machine" definition is updated
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When all state machines are listed
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" is described
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated then all state machines are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine" then versions of a "step functions" "state machine" are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then tags for a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When tags for a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution is stopped then an execution is started on a standard "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution is stopped
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then an execution is described then a synchronous execution is started on an express "step functions" "state machine"
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When an execution is described
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then the event history of an execution is retrieved then a running execution is stopped
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution transitions to a terminal state then an execution is described
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: executions for a "step functions" "state machine" are listed then a running execution exceeds its timeout then the event history of an execution is retrieved
    Given arn in sm_status
    When executions for a "step functions" "state machine" are listed
    When a running execution exceeds its timeout
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is created then a running execution exceeds its timeout
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is created
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is deleted then a "step functions" "state machine" is created
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" definition is updated then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" is described then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is described
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then all state machines are listed then a "step functions" "state machine" is described
    Given eid in exec_status
    When the event history of an execution is retrieved
    When all state machines are listed
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then versions of a "step functions" "state machine" are listed then all state machines are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When versions of a "step functions" "state machine" are listed
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a "step functions" "state machine" definition is validated then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a "step functions" "state machine" definition is validated
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags are added to a "step functions" "state machine" then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags are added to a "step functions" "state machine"
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags are removed from a "step functions" "state machine" then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags are removed from a "step functions" "state machine"
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then tags for a "step functions" "state machine" are listed then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When tags for a "step functions" "state machine" are listed
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then an execution is started on a standard "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When an execution is started on a standard "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a synchronous execution is started on an express "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution is stopped then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution is stopped
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then an execution is described then a running execution is stopped
    Given eid in exec_status
    When the event history of an execution is retrieved
    When an execution is described
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then executions for a "step functions" "state machine" are listed then an execution is described
    Given eid in exec_status
    When the event history of an execution is retrieved
    When executions for a "step functions" "state machine" are listed
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution transitions to a terminal state then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution transitions to a terminal state
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: the event history of an execution is retrieved then a running execution exceeds its timeout then a running execution transitions to a terminal state
    Given eid in exec_status
    When the event history of an execution is retrieved
    When a running execution exceeds its timeout
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is created then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is deleted then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" definition is updated then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is updated
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" is described then all state machines are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is described
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then all state machines are listed then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When all state machines are listed
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then versions of a "step functions" "state machine" are listed then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When versions of a "step functions" "state machine" are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a "step functions" "state machine" definition is validated then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" definition is validated
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags are added to a "step functions" "state machine" then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags are added to a "step functions" "state machine"
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags are removed from a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags are removed from a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then tags for a "step functions" "state machine" are listed then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When tags for a "step functions" "state machine" are listed
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then an execution is started on a standard "step functions" "state machine" then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When an execution is started on a standard "step functions" "state machine"
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a synchronous execution is started on an express "step functions" "state machine" then a running execution is stopped
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a synchronous execution is started on an express "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a running execution is stopped then an execution is described
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a running execution is stopped
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then an execution is described then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When an execution is described
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then executions for a "step functions" "state machine" are listed then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When executions for a "step functions" "state machine" are listed
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then the event history of an execution is retrieved then a running execution exceeds its timeout
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When the event history of an execution is retrieved
    When a running execution exceeds its timeout
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution transitions to a terminal state then a running execution exceeds its timeout then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution transitions to a terminal state
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is created then a "step functions" "state machine" deletion is finalized
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is created
    When a "step functions" "state machine" deletion is finalized
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is deleted then a "step functions" "state machine" definition is updated
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is deleted
    When a "step functions" "state machine" definition is updated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" deletion is finalized then a "step functions" "state machine" is described
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" deletion is finalized
    When a "step functions" "state machine" is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" definition is updated then all state machines are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is updated
    When all state machines are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" is described then versions of a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" is described
    When versions of a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then all state machines are listed then a "step functions" "state machine" definition is validated
    Given eid in exec_status
    When a running execution exceeds its timeout
    When all state machines are listed
    When a "step functions" "state machine" definition is validated
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then versions of a "step functions" "state machine" are listed then tags are added to a "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When versions of a "step functions" "state machine" are listed
    When tags are added to a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a "step functions" "state machine" definition is validated then tags are removed from a "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a "step functions" "state machine" definition is validated
    When tags are removed from a "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags are added to a "step functions" "state machine" then tags for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags are added to a "step functions" "state machine"
    When tags for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags are removed from a "step functions" "state machine" then an execution is started on a standard "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags are removed from a "step functions" "state machine"
    When an execution is started on a standard "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then tags for a "step functions" "state machine" are listed then a synchronous execution is started on an express "step functions" "state machine"
    Given eid in exec_status
    When a running execution exceeds its timeout
    When tags for a "step functions" "state machine" are listed
    When a synchronous execution is started on an express "step functions" "state machine"
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then an execution is started on a standard "step functions" "state machine" then a running execution is stopped
    Given eid in exec_status
    When a running execution exceeds its timeout
    When an execution is started on a standard "step functions" "state machine"
    When a running execution is stopped
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a synchronous execution is started on an express "step functions" "state machine" then an execution is described
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a synchronous execution is started on an express "step functions" "state machine"
    When an execution is described
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a running execution is stopped then executions for a "step functions" "state machine" are listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a running execution is stopped
    When executions for a "step functions" "state machine" are listed
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then an execution is described then the event history of an execution is retrieved
    Given eid in exec_status
    When a running execution exceeds its timeout
    When an execution is described
    When the event history of an execution is retrieved
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then executions for a "step functions" "state machine" are listed then a running execution transitions to a terminal state
    Given eid in exec_status
    When a running execution exceeds its timeout
    When executions for a "step functions" "state machine" are listed
    When a running execution transitions to a terminal state
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then the event history of an execution is retrieved then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running execution exceeds its timeout
    When the event history of an execution is retrieved
    When a "step functions" "state machine" is created
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @sequence
  Scenario: a running execution exceeds its timeout then a running execution transitions to a terminal state then a "step functions" "state machine" is deleted
    Given eid in exec_status
    When a running execution exceeds its timeout
    When a running execution transitions to a terminal state
    When a "step functions" "state machine" is deleted
    And every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine
