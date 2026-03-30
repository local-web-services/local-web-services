@stepfunctionssqs @generated
Feature: StepfunctionsSqs - An Sqs Send-Message Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_q_s_task
  Scenario: an "SQS" send-message task is configured on the state machine
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SQS" task configured
    And the queue exists
    And the queue is "ACTIVE"
    When an "SQS" send-message task is configured on the state machine
    Then the state machine will enqueue a message when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @configure_s_q_s_task
  Scenario: an "SQS" send-message task is configured on the state machine fails when the state machine does not exist
    Given the state machine does not exist
    When an "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: an "SQS" send-message task is configured on the state machine fails when the state machine is not "ACTIVE"
    Given the state machine exists
    And the state machine is not "ACTIVE"
    When an "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: an "SQS" send-message task is configured on the state machine fails when the state machine already has an "SQS" task configured
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine already has an "SQS" task configured
    When an "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: an "SQS" send-message task is configured on the state machine fails when the queue does not exist
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SQS" task configured
    And the queue does not exist
    When an "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: an "SQS" send-message task is configured on the state machine fails when the queue is not "ACTIVE"
    Given the state machine exists
    And the state machine is "ACTIVE"
    And the state machine has no "SQS" task configured
    And the queue exists
    And the queue is not "ACTIVE"
    When an "SQS" send-message task is configured on the state machine
    Then the operation is rejected
