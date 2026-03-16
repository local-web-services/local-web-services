@lambdasqsproducer @generated
Feature: LambdaSqsProducer - An Sqs Queue Is Created

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: an "SQS" queue is created
    Given the queue does not already exist
    When an "SQS" queue is created
    Then the queue is "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @standard @negative @create_queue
  Scenario: an "SQS" queue is created fails when the queue already exists
    Given the queue already exists
    When an "SQS" queue is created
    Then the operation is rejected
