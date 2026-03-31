@lambdasqsproducer @generated
Feature: LambdaSqsProducer - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: lambda_sqs_producer.fizz
  # Safety invariants: InvocationRequiresActiveFunction, MessageRequiresActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the queue did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" message belongs to an "ACTIVE" queue

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the queue already existed
    Given the queue already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
