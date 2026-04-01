@lambdasqs @generated
Feature: LambdaSqs - A "Sqs" "Queue" Is Created

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a "sqs" "queue" is created
    Given the queue did not already exist
    When a "sqs" "queue" is created
    Then the "sqs" "queue" will be "ACTIVE" with no dead-letter queue configured
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @guard @negative @create_queue
  Scenario: a "sqs" "queue" is created fails when the queue already existed
    Given the queue already existed
    When a "sqs" "queue" is created
    Then the operation is rejected
