@lambdasqsproducer @generated
Feature: LambdaSqsProducer - The Lambda Function Sends A Message To The Sqs Queue During Invocation

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @send_message
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation
    Given an invocation is "IN_PROGRESS"
    And the queue exists
    And the queue is "ACTIVE"
    And a message slot is available
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then the message is "AVAILABLE" in the queue
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @send_message @lifecycle
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation fails when no invocation is "IN_PROGRESS"
    Given no invocation is "IN_PROGRESS"
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then the operation is rejected

  @standard @negative @send_message
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation fails when the queue does not exist
    Given an invocation is "IN_PROGRESS"
    And the queue does not exist
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then the operation is rejected

  @standard @negative @send_message @lifecycle
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation fails when the queue is not "ACTIVE"
    Given an invocation is "IN_PROGRESS"
    And the queue exists
    And the queue is not "ACTIVE"
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then the operation is rejected

  @standard @negative @send_message @capacity
  Scenario: the Lambda function sends a message to the "SQS" queue during invocation fails when no message slot is available
    Given an invocation is "IN_PROGRESS"
    And the queue exists
    And the queue is "ACTIVE"
    And no message slot is available
    When the Lambda function sends a message to the "SQS" queue during invocation
    Then the operation is rejected
