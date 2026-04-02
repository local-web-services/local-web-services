@stepfunctionssqs @generated
Feature: StepfunctionsSqs - A Running "Step Functions" "Execution" Reaches The Sqs Task State And Sends A Message To The Queue

  # Generated from FizzBee spec: stepfunctions_sqs.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "sqs" task
    And the target "sqs" "queue" was "ACTIVE"
    And a "sqs" "message" "slot" was "available"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the "sqs" "message" will be "AVAILABLE" in the "sqs" "queue" and the "step functions" "execution" will be "SUCCEEDED"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "AVAILABLE" "sqs" "message" belongs to an "ACTIVE" "sqs" "queue"

  @guard @negative @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when no "step functions" "execution" was "RUNNING"
    Given no "step functions" "execution" was "RUNNING"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when the "step functions" "execution"'s state machine has no "sqs" task configured
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has no "sqs" task configured
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task @lifecycle
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when the target "sqs" "queue" was not "ACTIVE"
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "sqs" task
    And the target "sqs" "queue" was not "ACTIVE"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected

  @guard @negative @send_message_task @capacity
  Scenario: a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue fails when no "sqs" "message" "slot" was "available"
    Given a "step functions" "execution" was "RUNNING"
    And the "step functions" "execution"'s state machine has a configured "sqs" task
    And the target "sqs" "queue" was "ACTIVE"
    And no "sqs" "message" "slot" was "available"
    When a running "step functions" "execution" reaches the "SQS" task state and sends a message to the queue
    Then the operation is rejected
