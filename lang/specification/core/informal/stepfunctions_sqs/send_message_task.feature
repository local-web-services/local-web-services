@stepfunctionssqs @generated
Feature: StepfunctionsSqs - A Running Execution Reaches The Sqs Task State And Sends A Message To The Queue

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @send_message_task
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue
    Given an execution is "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue is "ACTIVE"
    And a message slot is available
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then the message is "AVAILABLE" in the queue and the execution is "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @send_message_task
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue fails when no execution is "RUNNING"
    Given no execution is "RUNNING"
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @standard @negative @send_message_task
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue fails when the execution's state machine has no "SQS" task configured
    Given an execution is "RUNNING"
    And the execution's state machine has no "SQS" task configured
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @standard @negative @send_message_task @lifecycle
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue fails when the target queue is not "ACTIVE"
    Given an execution is "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue is not "ACTIVE"
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @standard @negative @send_message_task @capacity
  Scenario: a running execution reaches the "SQS" task state and sends a message to the queue fails when no message slot is available
    Given an execution is "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue is "ACTIVE"
    And no message slot is available
    When a running execution reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected
