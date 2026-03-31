@lambdasqsproducer @generated
Feature: LambdaSqsProducer - The "Lambda" "Function" Sends A Message To The "Sqs" "Queue" During Invocation

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @send_message
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And a message slot is available
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Then the message will be "AVAILABLE" in the queue
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @send_message @lifecycle
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation fails when no "lambda" "invocation" was "IN_PROGRESS"
    Given no "lambda" "invocation" was "IN_PROGRESS"
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Then the operation is rejected

  @guard @negative @send_message
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation fails when the "sqs" "queue" did not exist
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sqs" "queue" did not exist
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Then the operation is rejected

  @guard @negative @send_message @lifecycle
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation fails when the "sqs" "queue" was not "ACTIVE"
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was not "ACTIVE"
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Then the operation is rejected

  @guard @negative @send_message @capacity
  Scenario: the "lambda" "function" sends a message to the "sqs" "queue" during invocation fails when no message slot is available
    Given a "lambda" "invocation" was "IN_PROGRESS"
    And the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    And no message slot is available
    When the "lambda" "function" sends a message to the "sqs" "queue" during invocation
    Then the operation is rejected
