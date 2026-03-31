@stepfunctionssqs @generated
Feature: StepfunctionsSqs - A Running "Step Functions" "Execution" Reaches The Sqs Task State And Sends A Message To The Queue

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue was "ACTIVE"
    And a message slot is available
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the message will be "AVAILABLE" in the queue and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when the execution's state machine has no "SQS" task configured
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has no "SQS" task configured
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task @lifecycle
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when the target queue was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue was not "ACTIVE"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task @capacity
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when no message slot is available
    Given a "step functions" "execution" was "RUNNING"
    And the execution's state machine has a configured "SQS" task
    And the target queue was "ACTIVE"
    And no message slot is available
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected
