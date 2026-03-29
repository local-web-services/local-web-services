@stepfunctions @generated
Feature: Stepfunctions - Action Sequences

  # Generated from FizzBee spec: stepfunctions.fizz
  # Safety invariants: StateMachineStatusValid, ExecutionStatusValid, StateMachineTypeValid, SyncExecutionOnlyForExpress, ExecutionBelongsToKnownStateMachine

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine is deleted
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine deletion is finalized
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine definition is updated
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine is described
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then all state machines are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then versions of a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine definition is validated
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags are added to a state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags are removed from a state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags for a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution is started on a standard state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a synchronous execution is started on an express state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution is stopped
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution is described
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then executions for a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the event history of an execution is retrieved
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution transitions to a terminal state
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution exceeds its timeout
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine has been deleted
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine has been deleted
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine definition is updated
    Given arn in sm_status
    Given a state machine has been deleted
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine is described
    Given arn in sm_status
    Given a state machine has been deleted
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then all state machines are listed
    Given arn in sm_status
    Given a state machine has been deleted
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine definition is validated
    Given arn in sm_status
    Given a state machine has been deleted
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags are added to a state machine
    Given arn in sm_status
    Given a state machine has been deleted
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine has been deleted
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine has been deleted
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine has been deleted
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution is stopped
    Given arn in sm_status
    Given a state machine has been deleted
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then an execution is described
    Given arn in sm_status
    Given a state machine has been deleted
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine has been deleted
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine has been deleted
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine has been deleted
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine is deleted
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine definition is updated
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine is described
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then all state machines are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine definition is validated
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags are added to a state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution is stopped
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then an execution is described
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine definition has been updated
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine is deleted
    Given arn in sm_status
    Given a state machine definition has been updated
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine definition has been updated
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine is described
    Given arn in sm_status
    Given a state machine definition has been updated
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then all state machines are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine definition is validated
    Given arn in sm_status
    Given a state machine definition has been updated
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags are added to a state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution is stopped
    Given arn in sm_status
    Given a state machine definition has been updated
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then an execution is described
    Given arn in sm_status
    Given a state machine definition has been updated
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine definition has been updated
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine definition has been updated
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine definition has been updated
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine has been described
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine is deleted
    Given arn in sm_status
    Given a state machine has been described
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine has been described
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine definition is updated
    Given arn in sm_status
    Given a state machine has been described
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then all state machines are listed
    Given arn in sm_status
    Given a state machine has been described
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine definition is validated
    Given arn in sm_status
    Given a state machine has been described
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags are added to a state machine
    Given arn in sm_status
    Given a state machine has been described
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine has been described
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine has been described
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine has been described
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution is stopped
    Given arn in sm_status
    Given a state machine has been described
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then an execution is described
    Given arn in sm_status
    Given a state machine has been described
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine has been described
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine has been described
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine has been described
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a Step Functions state machine is created
    Given all state machines have been listed
    Given arn not in sm_status
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine is deleted
    Given all state machines have been listed
    Given arn in sm_status
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine deletion is finalized
    Given all state machines have been listed
    Given arn in sm_status
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine definition is updated
    Given all state machines have been listed
    Given arn in sm_status
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine is described
    Given all state machines have been listed
    Given arn in sm_status
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then versions of a state machine are listed
    Given all state machines have been listed
    Given arn in sm_status
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine definition is validated
    Given all state machines have been listed
    Given arn in sm_status
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags are added to a state machine
    Given all state machines have been listed
    Given arn in sm_status
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags are removed from a state machine
    Given all state machines have been listed
    Given arn in sm_status
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags for a state machine are listed
    Given all state machines have been listed
    Given arn in sm_status
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then an execution is started on a standard state machine
    Given all state machines have been listed
    Given arn in sm_status
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a synchronous execution is started on an express state machine
    Given all state machines have been listed
    Given arn in sm_status
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution is stopped
    Given all state machines have been listed
    Given eid in exec_status
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then an execution is described
    Given all state machines have been listed
    Given eid in exec_status
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then executions for a state machine are listed
    Given all state machines have been listed
    Given arn in sm_status
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then the event history of an execution is retrieved
    Given all state machines have been listed
    Given eid in exec_status
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution transitions to a terminal state
    Given all state machines have been listed
    Given eid in exec_status
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution exceeds its timeout
    Given all state machines have been listed
    Given eid in exec_status
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine deletion is finalized
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine definition is updated
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine is described
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then all state machines are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine definition is validated
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags are removed from a state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags for a state machine are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then an execution is started on a standard state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution is stopped
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then an execution is described
    Given arn in sm_status
    Given versions of a state machine have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then executions for a state machine are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then the event history of an execution is retrieved
    Given arn in sm_status
    Given versions of a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine definition has been validated
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine is deleted
    Given arn in sm_status
    Given a state machine definition has been validated
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine definition has been validated
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine definition is updated
    Given arn in sm_status
    Given a state machine definition has been validated
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine is described
    Given arn in sm_status
    Given a state machine definition has been validated
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then all state machines are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags are added to a state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution is stopped
    Given arn in sm_status
    Given a state machine definition has been validated
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then an execution is described
    Given arn in sm_status
    Given a state machine definition has been validated
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine definition has been validated
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine definition has been validated
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine definition has been validated
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given tags have been added to a state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine is deleted
    Given arn in sm_status
    Given tags have been added to a state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given tags have been added to a state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine definition is updated
    Given arn in sm_status
    Given tags have been added to a state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine is described
    Given arn in sm_status
    Given tags have been added to a state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then all state machines are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then versions of a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine definition is validated
    Given arn in sm_status
    Given tags have been added to a state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then tags are removed from a state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then tags for a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution is stopped
    Given arn in sm_status
    Given tags have been added to a state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then an execution is described
    Given arn in sm_status
    Given tags have been added to a state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then executions for a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags have been added to a state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags have been added to a state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags have been added to a state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine is deleted
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine definition is updated
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine is described
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then all state machines are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then versions of a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine definition is validated
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then tags are added to a state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then tags for a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution is stopped
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then an execution is described
    Given arn in sm_status
    Given tags have been removed from a state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then executions for a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags have been removed from a state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags have been removed from a state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine deletion is finalized
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine definition is updated
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine is described
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then all state machines are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then versions of a state machine are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine definition is validated
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then tags are removed from a state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution is stopped
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then an execution is described
    Given arn in sm_status
    Given tags for a state machine have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then executions for a state machine are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags for a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags for a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine is deleted
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine definition is updated
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine is described
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then all state machines are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then versions of a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine definition is validated
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags are added to a state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags are removed from a state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags for a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution is stopped
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then an execution is described
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then executions for a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine is deleted
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine definition is updated
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine is described
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then all state machines are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then versions of a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine definition is validated
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags are added to a state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags are removed from a state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags for a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then an execution is started on a standard state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution is stopped
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then an execution is described
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then executions for a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has been stopped
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine is deleted
    Given eid in exec_status
    Given a running execution has been stopped
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has been stopped
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has been stopped
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine is described
    Given eid in exec_status
    Given a running execution has been stopped
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then all state machines are listed
    Given eid in exec_status
    Given a running execution has been stopped
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has been stopped
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has been stopped
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has been stopped
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has been stopped
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has been stopped
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then an execution is described
    Given eid in exec_status
    Given a running execution has been stopped
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has been stopped
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a running execution transitions to a terminal state
    Given eid in exec_status
    Given a running execution has been stopped
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a running execution exceeds its timeout
    Given eid in exec_status
    Given a running execution has been stopped
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a Step Functions state machine is created
    Given eid in exec_status
    Given an execution has been described
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine is deleted
    Given eid in exec_status
    Given an execution has been described
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine deletion is finalized
    Given eid in exec_status
    Given an execution has been described
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine definition is updated
    Given eid in exec_status
    Given an execution has been described
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine is described
    Given eid in exec_status
    Given an execution has been described
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then all state machines are listed
    Given eid in exec_status
    Given an execution has been described
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then versions of a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine definition is validated
    Given eid in exec_status
    Given an execution has been described
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags are added to a state machine
    Given eid in exec_status
    Given an execution has been described
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags are removed from a state machine
    Given eid in exec_status
    Given an execution has been described
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags for a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then an execution is started on a standard state machine
    Given eid in exec_status
    Given an execution has been described
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given an execution has been described
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution is stopped
    Given eid in exec_status
    Given an execution has been described
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then executions for a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then the event history of an execution is retrieved
    Given eid in exec_status
    Given an execution has been described
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution transitions to a terminal state
    Given eid in exec_status
    Given an execution has been described
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution exceeds its timeout
    Given eid in exec_status
    Given an execution has been described
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine deletion is finalized
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine definition is updated
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine is described
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then all state machines are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then versions of a state machine are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine definition is validated
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags are removed from a state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags for a state machine are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then an execution is started on a standard state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution is stopped
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then an execution is described
    Given arn in sm_status
    Given executions for a state machine have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then the event history of an execution is retrieved
    Given arn in sm_status
    Given executions for a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a Step Functions state machine is created
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine is deleted
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine deletion is finalized
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine definition is updated
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine is described
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then all state machines are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then versions of a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine definition is validated
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags are added to a state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags are removed from a state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags for a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then an execution is started on a standard state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution is stopped
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then an execution is described
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then executions for a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution transitions to a terminal state
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution exceeds its timeout
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine is deleted
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine is described
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then all state machines are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a running execution is stopped
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then an execution is described
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a running execution exceeds its timeout
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine is deleted
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine is described
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then all state machines are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a running execution is stopped
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then an execution is described
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a running execution transitions to a terminal state
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine is deleted then a state machine deletion is finalized
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a state machine has been deleted
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine deletion is finalized then a state machine definition is updated
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a state machine deletion has been finalized
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine definition is updated then a state machine is described
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a state machine definition has been updated
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine is described then all state machines are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a state machine has been described
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then all state machines are listed then versions of a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given all state machines have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then versions of a state machine are listed then a state machine definition is validated
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given versions of a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a state machine definition is validated then tags are added to a state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a state machine definition has been validated
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags are added to a state machine then tags are removed from a state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given tags have been added to a state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags are removed from a state machine then tags for a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given tags have been removed from a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then tags for a state machine are listed then an execution is started on a standard state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given tags for a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution is started on a standard state machine then a synchronous execution is started on an express state machine
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given an execution has been started on a standard state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a synchronous execution is started on an express state machine then a running execution is stopped
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a synchronous execution has been started on an express state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution is stopped then an execution is described
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has been stopped
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution is described then executions for a state machine are listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given an execution has been described
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then executions for a state machine are listed then the event history of an execution is retrieved
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given executions for a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the event history of an execution is retrieved then a running execution transitions to a terminal state
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given the event history of an execution has been retrieved
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution transitions to a terminal state then a running execution exceeds its timeout
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has transitioned to a terminal state
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution exceeds its timeout then a state machine is deleted
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has exceeded its timeout
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a Step Functions state machine is created then a state machine definition is updated
    Given arn in sm_status
    Given a state machine has been deleted
    Given a Step Functions state machine has been created
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine deletion is finalized then a state machine is described
    Given arn in sm_status
    Given a state machine has been deleted
    Given a state machine deletion has been finalized
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine definition is updated then all state machines are listed
    Given arn in sm_status
    Given a state machine has been deleted
    Given a state machine definition has been updated
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine is described then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    Given a state machine has been described
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then all state machines are listed then a state machine definition is validated
    Given arn in sm_status
    Given a state machine has been deleted
    Given all state machines have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then versions of a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given a state machine has been deleted
    Given versions of a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a state machine definition is validated then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine has been deleted
    Given a state machine definition has been validated
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags are added to a state machine then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    Given tags have been added to a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags are removed from a state machine then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine has been deleted
    Given tags have been removed from a state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then tags for a state machine are listed then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine has been deleted
    Given tags for a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then an execution is started on a standard state machine then a running execution is stopped
    Given arn in sm_status
    Given a state machine has been deleted
    Given an execution has been started on a standard state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a synchronous execution is started on an express state machine then an execution is described
    Given arn in sm_status
    Given a state machine has been deleted
    Given a synchronous execution has been started on an express state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution is stopped then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine has been deleted
    Given a running execution has been stopped
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then an execution is described then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine has been deleted
    Given an execution has been described
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then executions for a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine has been deleted
    Given executions for a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then the event history of an execution is retrieved then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine has been deleted
    Given the event history of an execution has been retrieved
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution transitions to a terminal state then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine has been deleted
    Given a running execution has transitioned to a terminal state
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is deleted then a running execution exceeds its timeout then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine has been deleted
    Given a running execution has exceeded its timeout
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a Step Functions state machine is created then a state machine is described
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a Step Functions state machine has been created
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine is deleted then all state machines are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a state machine has been deleted
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine definition is updated then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a state machine definition has been updated
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine is described then a state machine definition is validated
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a state machine has been described
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then all state machines are listed then tags are added to a state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given all state machines have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then versions of a state machine are listed then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given versions of a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a state machine definition is validated then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a state machine definition has been validated
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags are added to a state machine then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given tags have been added to a state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags are removed from a state machine then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given tags have been removed from a state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then tags for a state machine are listed then a running execution is stopped
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given tags for a state machine have been listed
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then an execution is started on a standard state machine then an execution is described
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given an execution has been started on a standard state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a synchronous execution is started on an express state machine then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a synchronous execution has been started on an express state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution is stopped then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a running execution has been stopped
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then an execution is described then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given an execution has been described
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then executions for a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given executions for a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then the event history of an execution is retrieved then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given the event history of an execution has been retrieved
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution transitions to a terminal state then a state machine is deleted
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a running execution has transitioned to a terminal state
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine deletion is finalized then a running execution exceeds its timeout then a state machine definition is updated
    Given arn in sm_status
    Given a state machine deletion has been finalized
    Given a running execution has exceeded its timeout
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a Step Functions state machine is created then all state machines are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a Step Functions state machine has been created
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine is deleted then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a state machine has been deleted
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine deletion is finalized then a state machine definition is validated
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a state machine deletion has been finalized
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine is described then tags are added to a state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a state machine has been described
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then all state machines are listed then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    Given all state machines have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then versions of a state machine are listed then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    Given versions of a state machine have been listed
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a state machine definition is validated then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a state machine definition has been validated
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags are added to a state machine then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine definition has been updated
    Given tags have been added to a state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags are removed from a state machine then a running execution is stopped
    Given arn in sm_status
    Given a state machine definition has been updated
    Given tags have been removed from a state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then tags for a state machine are listed then an execution is described
    Given arn in sm_status
    Given a state machine definition has been updated
    Given tags for a state machine have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then an execution is started on a standard state machine then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been updated
    Given an execution has been started on a standard state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a synchronous execution is started on an express state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a synchronous execution has been started on an express state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution is stopped then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a running execution has been stopped
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then an execution is described then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine definition has been updated
    Given an execution has been described
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then executions for a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine definition has been updated
    Given executions for a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then the event history of an execution is retrieved then a state machine is deleted
    Given arn in sm_status
    Given a state machine definition has been updated
    Given the event history of an execution has been retrieved
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution transitions to a terminal state then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a running execution has transitioned to a terminal state
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is updated then a running execution exceeds its timeout then a state machine is described
    Given arn in sm_status
    Given a state machine definition has been updated
    Given a running execution has exceeded its timeout
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a Step Functions state machine is created then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    Given a Step Functions state machine has been created
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine is deleted then a state machine definition is validated
    Given arn in sm_status
    Given a state machine has been described
    Given a state machine has been deleted
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine deletion is finalized then tags are added to a state machine
    Given arn in sm_status
    Given a state machine has been described
    Given a state machine deletion has been finalized
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine definition is updated then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine has been described
    Given a state machine definition has been updated
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then all state machines are listed then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    Given all state machines have been listed
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then versions of a state machine are listed then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine has been described
    Given versions of a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a state machine definition is validated then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine has been described
    Given a state machine definition has been validated
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags are added to a state machine then a running execution is stopped
    Given arn in sm_status
    Given a state machine has been described
    Given tags have been added to a state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags are removed from a state machine then an execution is described
    Given arn in sm_status
    Given a state machine has been described
    Given tags have been removed from a state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then tags for a state machine are listed then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine has been described
    Given tags for a state machine have been listed
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then an execution is started on a standard state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine has been described
    Given an execution has been started on a standard state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a synchronous execution is started on an express state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine has been described
    Given a synchronous execution has been started on an express state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution is stopped then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine has been described
    Given a running execution has been stopped
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then an execution is described then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine has been described
    Given an execution has been described
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then executions for a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given a state machine has been described
    Given executions for a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then the event history of an execution is retrieved then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine has been described
    Given the event history of an execution has been retrieved
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution transitions to a terminal state then a state machine definition is updated
    Given arn in sm_status
    Given a state machine has been described
    Given a running execution has transitioned to a terminal state
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine is described then a running execution exceeds its timeout then all state machines are listed
    Given arn in sm_status
    Given a state machine has been described
    Given a running execution has exceeded its timeout
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a Step Functions state machine is created then a state machine definition is validated
    Given all state machines have been listed
    Given arn not in sm_status
    Given a Step Functions state machine has been created
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine is deleted then tags are added to a state machine
    Given all state machines have been listed
    Given arn in sm_status
    Given a state machine has been deleted
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine deletion is finalized then tags are removed from a state machine
    Given all state machines have been listed
    Given arn in sm_status
    Given a state machine deletion has been finalized
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine definition is updated then tags for a state machine are listed
    Given all state machines have been listed
    Given arn in sm_status
    Given a state machine definition has been updated
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine is described then an execution is started on a standard state machine
    Given all state machines have been listed
    Given arn in sm_status
    Given a state machine has been described
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then versions of a state machine are listed then a synchronous execution is started on an express state machine
    Given all state machines have been listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a state machine definition is validated then a running execution is stopped
    Given all state machines have been listed
    Given arn in sm_status
    Given a state machine definition has been validated
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags are added to a state machine then an execution is described
    Given all state machines have been listed
    Given arn in sm_status
    Given tags have been added to a state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags are removed from a state machine then executions for a state machine are listed
    Given all state machines have been listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then tags for a state machine are listed then the event history of an execution is retrieved
    Given all state machines have been listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then an execution is started on a standard state machine then a running execution transitions to a terminal state
    Given all state machines have been listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a synchronous execution is started on an express state machine then a running execution exceeds its timeout
    Given all state machines have been listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution is stopped then a Step Functions state machine is created
    Given all state machines have been listed
    Given eid in exec_status
    Given a running execution has been stopped
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then an execution is described then a state machine is deleted
    Given all state machines have been listed
    Given eid in exec_status
    Given an execution has been described
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then executions for a state machine are listed then a state machine deletion is finalized
    Given all state machines have been listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then the event history of an execution is retrieved then a state machine definition is updated
    Given all state machines have been listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution transitions to a terminal state then a state machine is described
    Given all state machines have been listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: all state machines are listed then a running execution exceeds its timeout then versions of a state machine are listed
    Given all state machines have been listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a Step Functions state machine is created then tags are added to a state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a Step Functions state machine has been created
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine is deleted then tags are removed from a state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a state machine has been deleted
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine deletion is finalized then tags for a state machine are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a state machine deletion has been finalized
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine definition is updated then an execution is started on a standard state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a state machine definition has been updated
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine is described then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a state machine has been described
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then all state machines are listed then a running execution is stopped
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given all state machines have been listed
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a state machine definition is validated then an execution is described
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a state machine definition has been validated
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags are added to a state machine then executions for a state machine are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given tags have been added to a state machine
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags are removed from a state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given tags have been removed from a state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then tags for a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given tags for a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then an execution is started on a standard state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given an execution has been started on a standard state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a synchronous execution is started on an express state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a synchronous execution has been started on an express state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution is stopped then a state machine is deleted
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a running execution has been stopped
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then an execution is described then a state machine deletion is finalized
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given an execution has been described
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then executions for a state machine are listed then a state machine definition is updated
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given executions for a state machine have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then the event history of an execution is retrieved then a state machine is described
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given the event history of an execution has been retrieved
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution transitions to a terminal state then all state machines are listed
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a running execution has transitioned to a terminal state
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: versions of a state machine are listed then a running execution exceeds its timeout then a state machine definition is validated
    Given arn in sm_status
    Given versions of a state machine have been listed
    Given a running execution has exceeded its timeout
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a Step Functions state machine is created then tags are removed from a state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a Step Functions state machine has been created
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine is deleted then tags for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a state machine has been deleted
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine deletion is finalized then an execution is started on a standard state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a state machine deletion has been finalized
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine definition is updated then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a state machine definition has been updated
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a state machine is described then a running execution is stopped
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a state machine has been described
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then all state machines are listed then an execution is described
    Given arn in sm_status
    Given a state machine definition has been validated
    Given all state machines have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then versions of a state machine are listed then executions for a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    Given versions of a state machine have been listed
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags are added to a state machine then the event history of an execution is retrieved
    Given arn in sm_status
    Given a state machine definition has been validated
    Given tags have been added to a state machine
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags are removed from a state machine then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a state machine definition has been validated
    Given tags have been removed from a state machine
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then tags for a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given a state machine definition has been validated
    Given tags for a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then an execution is started on a standard state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given a state machine definition has been validated
    Given an execution has been started on a standard state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a synchronous execution is started on an express state machine then a state machine is deleted
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a synchronous execution has been started on an express state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution is stopped then a state machine deletion is finalized
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a running execution has been stopped
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then an execution is described then a state machine definition is updated
    Given arn in sm_status
    Given a state machine definition has been validated
    Given an execution has been described
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then executions for a state machine are listed then a state machine is described
    Given arn in sm_status
    Given a state machine definition has been validated
    Given executions for a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then the event history of an execution is retrieved then all state machines are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    Given the event history of an execution has been retrieved
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution transitions to a terminal state then versions of a state machine are listed
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a running execution has transitioned to a terminal state
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a state machine definition is validated then a running execution exceeds its timeout then tags are added to a state machine
    Given arn in sm_status
    Given a state machine definition has been validated
    Given a running execution has exceeded its timeout
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a Step Functions state machine is created then tags for a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a Step Functions state machine has been created
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine is deleted then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a state machine has been deleted
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine deletion is finalized then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a state machine deletion has been finalized
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine definition is updated then a running execution is stopped
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a state machine definition has been updated
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine is described then an execution is described
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a state machine has been described
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then all state machines are listed then executions for a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    Given all state machines have been listed
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then versions of a state machine are listed then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags have been added to a state machine
    Given versions of a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a state machine definition is validated then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a state machine definition has been validated
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then tags are removed from a state machine then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags have been added to a state machine
    Given tags have been removed from a state machine
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then tags for a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given tags have been added to a state machine
    Given tags for a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then an execution is started on a standard state machine then a state machine is deleted
    Given arn in sm_status
    Given tags have been added to a state machine
    Given an execution has been started on a standard state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a synchronous execution is started on an express state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a synchronous execution has been started on an express state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution is stopped then a state machine definition is updated
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a running execution has been stopped
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then an execution is described then a state machine is described
    Given arn in sm_status
    Given tags have been added to a state machine
    Given an execution has been described
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then executions for a state machine are listed then all state machines are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    Given executions for a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then the event history of an execution is retrieved then versions of a state machine are listed
    Given arn in sm_status
    Given tags have been added to a state machine
    Given the event history of an execution has been retrieved
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution transitions to a terminal state then a state machine definition is validated
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a running execution has transitioned to a terminal state
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are added to a state machine then a running execution exceeds its timeout then tags are removed from a state machine
    Given arn in sm_status
    Given tags have been added to a state machine
    Given a running execution has exceeded its timeout
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a Step Functions state machine is created then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a Step Functions state machine has been created
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine is deleted then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a state machine has been deleted
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine deletion is finalized then a running execution is stopped
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a state machine deletion has been finalized
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine definition is updated then an execution is described
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a state machine definition has been updated
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine is described then executions for a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a state machine has been described
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then all state machines are listed then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given all state machines have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then versions of a state machine are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given versions of a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a state machine definition is validated then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a state machine definition has been validated
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then tags are added to a state machine then a Step Functions state machine is created
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given tags have been added to a state machine
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then tags for a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given tags for a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then an execution is started on a standard state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given an execution has been started on a standard state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a synchronous execution is started on an express state machine then a state machine definition is updated
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a synchronous execution has been started on an express state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution is stopped then a state machine is described
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a running execution has been stopped
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then an execution is described then all state machines are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given an execution has been described
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then executions for a state machine are listed then versions of a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given executions for a state machine have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then the event history of an execution is retrieved then a state machine definition is validated
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given the event history of an execution has been retrieved
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution transitions to a terminal state then tags are added to a state machine
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a running execution has transitioned to a terminal state
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags are removed from a state machine then a running execution exceeds its timeout then tags for a state machine are listed
    Given arn in sm_status
    Given tags have been removed from a state machine
    Given a running execution has exceeded its timeout
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a Step Functions state machine is created then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a Step Functions state machine has been created
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine is deleted then a running execution is stopped
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a state machine has been deleted
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine deletion is finalized then an execution is described
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a state machine deletion has been finalized
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine definition is updated then executions for a state machine are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a state machine definition has been updated
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine is described then the event history of an execution is retrieved
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a state machine has been described
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then all state machines are listed then a running execution transitions to a terminal state
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given all state machines have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then versions of a state machine are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given versions of a state machine have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a state machine definition is validated then a Step Functions state machine is created
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a state machine definition has been validated
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then tags are added to a state machine then a state machine is deleted
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given tags have been added to a state machine
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then tags are removed from a state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given tags have been removed from a state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then an execution is started on a standard state machine then a state machine definition is updated
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given an execution has been started on a standard state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a synchronous execution is started on an express state machine then a state machine is described
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a synchronous execution has been started on an express state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution is stopped then all state machines are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a running execution has been stopped
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then an execution is described then versions of a state machine are listed
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given an execution has been described
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then executions for a state machine are listed then a state machine definition is validated
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given executions for a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then the event history of an execution is retrieved then tags are added to a state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given the event history of an execution has been retrieved
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution transitions to a terminal state then tags are removed from a state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a running execution has transitioned to a terminal state
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: tags for a state machine are listed then a running execution exceeds its timeout then an execution is started on a standard state machine
    Given arn in sm_status
    Given tags for a state machine have been listed
    Given a running execution has exceeded its timeout
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a Step Functions state machine is created then a running execution is stopped
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a Step Functions state machine has been created
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine is deleted then an execution is described
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a state machine has been deleted
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine deletion is finalized then executions for a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a state machine deletion has been finalized
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine definition is updated then the event history of an execution is retrieved
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a state machine definition has been updated
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine is described then a running execution transitions to a terminal state
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a state machine has been described
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then all state machines are listed then a running execution exceeds its timeout
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given all state machines have been listed
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then versions of a state machine are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given versions of a state machine have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a state machine definition is validated then a state machine is deleted
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a state machine definition has been validated
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags are added to a state machine then a state machine deletion is finalized
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given tags have been added to a state machine
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags are removed from a state machine then a state machine definition is updated
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given tags have been removed from a state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then tags for a state machine are listed then a state machine is described
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given tags for a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a synchronous execution is started on an express state machine then all state machines are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a synchronous execution has been started on an express state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution is stopped then versions of a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a running execution has been stopped
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then an execution is described then a state machine definition is validated
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given an execution has been described
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then executions for a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given executions for a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then the event history of an execution is retrieved then tags are removed from a state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given the event history of an execution has been retrieved
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution transitions to a terminal state then tags for a state machine are listed
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a running execution has transitioned to a terminal state
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is started on a standard state machine then a running execution exceeds its timeout then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given an execution has been started on a standard state machine
    Given a running execution has exceeded its timeout
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a Step Functions state machine is created then an execution is described
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a Step Functions state machine has been created
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine is deleted then executions for a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a state machine has been deleted
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine deletion is finalized then the event history of an execution is retrieved
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a state machine deletion has been finalized
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine definition is updated then a running execution transitions to a terminal state
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a state machine definition has been updated
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine is described then a running execution exceeds its timeout
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a state machine has been described
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then all state machines are listed then a Step Functions state machine is created
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given all state machines have been listed
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then versions of a state machine are listed then a state machine is deleted
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given versions of a state machine have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a state machine definition is validated then a state machine deletion is finalized
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a state machine definition has been validated
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags are added to a state machine then a state machine definition is updated
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given tags have been added to a state machine
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags are removed from a state machine then a state machine is described
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given tags have been removed from a state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then tags for a state machine are listed then all state machines are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given tags for a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then an execution is started on a standard state machine then versions of a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given an execution has been started on a standard state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution is stopped then a state machine definition is validated
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a running execution has been stopped
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then an execution is described then tags are added to a state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given an execution has been described
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then executions for a state machine are listed then tags are removed from a state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given executions for a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then the event history of an execution is retrieved then tags for a state machine are listed
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given the event history of an execution has been retrieved
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution transitions to a terminal state then an execution is started on a standard state machine
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a running execution has transitioned to a terminal state
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a synchronous execution is started on an express state machine then a running execution exceeds its timeout then a running execution is stopped
    Given arn in sm_status
    Given a synchronous execution has been started on an express state machine
    Given a running execution has exceeded its timeout
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a Step Functions state machine is created then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    Given a Step Functions state machine has been created
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine is deleted then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has been stopped
    Given a state machine has been deleted
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine deletion is finalized then a running execution transitions to a terminal state
    Given eid in exec_status
    Given a running execution has been stopped
    Given a state machine deletion has been finalized
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine definition is updated then a running execution exceeds its timeout
    Given eid in exec_status
    Given a running execution has been stopped
    Given a state machine definition has been updated
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine is described then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has been stopped
    Given a state machine has been described
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then all state machines are listed then a state machine is deleted
    Given eid in exec_status
    Given a running execution has been stopped
    Given all state machines have been listed
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then versions of a state machine are listed then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has been stopped
    Given versions of a state machine have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a state machine definition is validated then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has been stopped
    Given a state machine definition has been validated
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags are added to a state machine then a state machine is described
    Given eid in exec_status
    Given a running execution has been stopped
    Given tags have been added to a state machine
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags are removed from a state machine then all state machines are listed
    Given eid in exec_status
    Given a running execution has been stopped
    Given tags have been removed from a state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then tags for a state machine are listed then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    Given tags for a state machine have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then an execution is started on a standard state machine then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has been stopped
    Given an execution has been started on a standard state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a synchronous execution is started on an express state machine then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has been stopped
    Given a synchronous execution has been started on an express state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then an execution is described then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has been stopped
    Given an execution has been described
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then executions for a state machine are listed then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has been stopped
    Given executions for a state machine have been listed
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then the event history of an execution is retrieved then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has been stopped
    Given the event history of an execution has been retrieved
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a running execution transitions to a terminal state then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has been stopped
    Given a running execution has transitioned to a terminal state
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution is stopped then a running execution exceeds its timeout then an execution is described
    Given eid in exec_status
    Given a running execution has been stopped
    Given a running execution has exceeded its timeout
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a Step Functions state machine is created then the event history of an execution is retrieved
    Given eid in exec_status
    Given an execution has been described
    Given a Step Functions state machine has been created
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine is deleted then a running execution transitions to a terminal state
    Given eid in exec_status
    Given an execution has been described
    Given a state machine has been deleted
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine deletion is finalized then a running execution exceeds its timeout
    Given eid in exec_status
    Given an execution has been described
    Given a state machine deletion has been finalized
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine definition is updated then a Step Functions state machine is created
    Given eid in exec_status
    Given an execution has been described
    Given a state machine definition has been updated
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine is described then a state machine is deleted
    Given eid in exec_status
    Given an execution has been described
    Given a state machine has been described
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then all state machines are listed then a state machine deletion is finalized
    Given eid in exec_status
    Given an execution has been described
    Given all state machines have been listed
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then versions of a state machine are listed then a state machine definition is updated
    Given eid in exec_status
    Given an execution has been described
    Given versions of a state machine have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a state machine definition is validated then a state machine is described
    Given eid in exec_status
    Given an execution has been described
    Given a state machine definition has been validated
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags are added to a state machine then all state machines are listed
    Given eid in exec_status
    Given an execution has been described
    Given tags have been added to a state machine
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags are removed from a state machine then versions of a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    Given tags have been removed from a state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then tags for a state machine are listed then a state machine definition is validated
    Given eid in exec_status
    Given an execution has been described
    Given tags for a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then an execution is started on a standard state machine then tags are added to a state machine
    Given eid in exec_status
    Given an execution has been described
    Given an execution has been started on a standard state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a synchronous execution is started on an express state machine then tags are removed from a state machine
    Given eid in exec_status
    Given an execution has been described
    Given a synchronous execution has been started on an express state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution is stopped then tags for a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    Given a running execution has been stopped
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then executions for a state machine are listed then an execution is started on a standard state machine
    Given eid in exec_status
    Given an execution has been described
    Given executions for a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then the event history of an execution is retrieved then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given an execution has been described
    Given the event history of an execution has been retrieved
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution transitions to a terminal state then a running execution is stopped
    Given eid in exec_status
    Given an execution has been described
    Given a running execution has transitioned to a terminal state
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: an execution is described then a running execution exceeds its timeout then executions for a state machine are listed
    Given eid in exec_status
    Given an execution has been described
    Given a running execution has exceeded its timeout
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a Step Functions state machine is created then a running execution transitions to a terminal state
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a Step Functions state machine has been created
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine is deleted then a running execution exceeds its timeout
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a state machine has been deleted
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine deletion is finalized then a Step Functions state machine is created
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a state machine deletion has been finalized
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine definition is updated then a state machine is deleted
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a state machine definition has been updated
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine is described then a state machine deletion is finalized
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a state machine has been described
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then all state machines are listed then a state machine definition is updated
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given all state machines have been listed
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then versions of a state machine are listed then a state machine is described
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given versions of a state machine have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a state machine definition is validated then all state machines are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a state machine definition has been validated
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags are added to a state machine then versions of a state machine are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given tags have been added to a state machine
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags are removed from a state machine then a state machine definition is validated
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given tags have been removed from a state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then tags for a state machine are listed then tags are added to a state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given tags for a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then an execution is started on a standard state machine then tags are removed from a state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given an execution has been started on a standard state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a synchronous execution is started on an express state machine then tags for a state machine are listed
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a synchronous execution has been started on an express state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution is stopped then an execution is started on a standard state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a running execution has been stopped
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then an execution is described then a synchronous execution is started on an express state machine
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given an execution has been described
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then the event history of an execution is retrieved then a running execution is stopped
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given the event history of an execution has been retrieved
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution transitions to a terminal state then an execution is described
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a running execution has transitioned to a terminal state
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: executions for a state machine are listed then a running execution exceeds its timeout then the event history of an execution is retrieved
    Given arn in sm_status
    Given executions for a state machine have been listed
    Given a running execution has exceeded its timeout
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a Step Functions state machine is created then a running execution exceeds its timeout
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a Step Functions state machine has been created
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine is deleted then a Step Functions state machine is created
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a state machine has been deleted
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine deletion is finalized then a state machine is deleted
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a state machine deletion has been finalized
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine definition is updated then a state machine deletion is finalized
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a state machine definition has been updated
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine is described then a state machine definition is updated
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a state machine has been described
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then all state machines are listed then a state machine is described
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given all state machines have been listed
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then versions of a state machine are listed then all state machines are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given versions of a state machine have been listed
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a state machine definition is validated then versions of a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a state machine definition has been validated
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags are added to a state machine then a state machine definition is validated
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given tags have been added to a state machine
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags are removed from a state machine then tags are added to a state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given tags have been removed from a state machine
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then tags for a state machine are listed then tags are removed from a state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given tags for a state machine have been listed
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then an execution is started on a standard state machine then tags for a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given an execution has been started on a standard state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a synchronous execution is started on an express state machine then an execution is started on a standard state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a synchronous execution has been started on an express state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution is stopped then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a running execution has been stopped
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then an execution is described then a running execution is stopped
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given an execution has been described
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then executions for a state machine are listed then an execution is described
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given executions for a state machine have been listed
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution transitions to a terminal state then executions for a state machine are listed
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a running execution has transitioned to a terminal state
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: the event history of an execution is retrieved then a running execution exceeds its timeout then a running execution transitions to a terminal state
    Given eid in exec_status
    Given the event history of an execution has been retrieved
    Given a running execution has exceeded its timeout
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a Step Functions state machine is created then a state machine is deleted
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a Step Functions state machine has been created
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine is deleted then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a state machine has been deleted
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine deletion is finalized then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a state machine deletion has been finalized
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine definition is updated then a state machine is described
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a state machine definition has been updated
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine is described then all state machines are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a state machine has been described
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then all state machines are listed then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given all state machines have been listed
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then versions of a state machine are listed then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given versions of a state machine have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a state machine definition is validated then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a state machine definition has been validated
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags are added to a state machine then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given tags have been added to a state machine
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags are removed from a state machine then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given tags have been removed from a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then tags for a state machine are listed then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given tags for a state machine have been listed
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then an execution is started on a standard state machine then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given an execution has been started on a standard state machine
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a synchronous execution is started on an express state machine then a running execution is stopped
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a synchronous execution has been started on an express state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a running execution is stopped then an execution is described
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a running execution has been stopped
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then an execution is described then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given an execution has been described
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then executions for a state machine are listed then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given executions for a state machine have been listed
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then the event history of an execution is retrieved then a running execution exceeds its timeout
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given the event history of an execution has been retrieved
    When a running execution exceeds its timeout
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution transitions to a terminal state then a running execution exceeds its timeout then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has transitioned to a terminal state
    Given a running execution has exceeded its timeout
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a Step Functions state machine is created then a state machine deletion is finalized
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a Step Functions state machine has been created
    When a state machine deletion is finalized
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine is deleted then a state machine definition is updated
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a state machine has been deleted
    When a state machine definition is updated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine deletion is finalized then a state machine is described
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a state machine deletion has been finalized
    When a state machine is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine definition is updated then all state machines are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a state machine definition has been updated
    When all state machines are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine is described then versions of a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a state machine has been described
    When versions of a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then all state machines are listed then a state machine definition is validated
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given all state machines have been listed
    When a state machine definition is validated
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then versions of a state machine are listed then tags are added to a state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given versions of a state machine have been listed
    When tags are added to a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a state machine definition is validated then tags are removed from a state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a state machine definition has been validated
    When tags are removed from a state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags are added to a state machine then tags for a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given tags have been added to a state machine
    When tags for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags are removed from a state machine then an execution is started on a standard state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given tags have been removed from a state machine
    When an execution is started on a standard state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then tags for a state machine are listed then a synchronous execution is started on an express state machine
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given tags for a state machine have been listed
    When a synchronous execution is started on an express state machine
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then an execution is started on a standard state machine then a running execution is stopped
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given an execution has been started on a standard state machine
    When a running execution is stopped
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a synchronous execution is started on an express state machine then an execution is described
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a synchronous execution has been started on an express state machine
    When an execution is described
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a running execution is stopped then executions for a state machine are listed
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a running execution has been stopped
    When executions for a state machine are listed
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then an execution is described then the event history of an execution is retrieved
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given an execution has been described
    When the event history of an execution is retrieved
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then executions for a state machine are listed then a running execution transitions to a terminal state
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given executions for a state machine have been listed
    When a running execution transitions to a terminal state
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then the event history of an execution is retrieved then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given the event history of an execution has been retrieved
    When a Step Functions state machine is created
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine

  @exhaustive @sequence
  Scenario: a running execution exceeds its timeout then a running execution transitions to a terminal state then a state machine is deleted
    Given eid in exec_status
    Given a running execution has exceeded its timeout
    Given a running execution has transitioned to a terminal state
    When a state machine is deleted
    Then every state machine has a valid status ("ACTIVE", "DELETING", or "DELETED")
    And every execution has a valid status ("RUNNING", "SUCCEEDED", "FAILED", "TIMED_OUT", or "ABORTED")
    And every state machine has a valid type ("STANDARD" or "EXPRESS")
    And synchronous executions only run on express state machines
    And every execution belongs to a known state machine
