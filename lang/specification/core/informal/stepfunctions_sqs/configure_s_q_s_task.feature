@stepfunctionssqs @generated
Feature: StepfunctionsSqs - A Sqs Send-Message Task Is Configured On The State Machine

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_s_q_s_task
  Scenario: a "SQS" send-message task is configured on the state machine
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SQS" task configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When a "SQS" send-message task is configured on the state machine
    Then the state machine will enqueue a message when it reaches the task state
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @configure_s_q_s_task
  Scenario: a "SQS" send-message task is configured on the state machine fails when the "step functions" "state machine" did not exist
    Given the "step functions" "state machine" did not exist
    When a "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: a "SQS" send-message task is configured on the state machine fails when the "step functions" "state machine" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was not "ACTIVE"
    When a "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: a "SQS" send-message task is configured on the state machine fails when the state machine already has a "SQS" task configured
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine already has a "SQS" task configured
    When a "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task
  Scenario: a "SQS" send-message task is configured on the state machine fails when the "sqs" "queue" did not exist
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SQS" task configured
    And the "sqs" "queue" did not exist
    When a "SQS" send-message task is configured on the state machine
    Then the operation is rejected

  @guard @negative @configure_s_q_s_task @lifecycle
  Scenario: a "SQS" send-message task is configured on the state machine fails when the "sqs" "queue" was not "ACTIVE"
    Given the "step functions" "state machine" existed
    And the "step functions" "state machine" was "ACTIVE"
    And the state machine has no "SQS" task configured
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When a "SQS" send-message task is configured on the state machine
    Then the operation is rejected
