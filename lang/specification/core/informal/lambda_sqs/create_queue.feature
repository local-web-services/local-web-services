@lambdasqs @generated
Feature: LambdaSqs - An Sqs Queue Is Created

  # Generated from FizzBee spec: lambda_sqs.fizz
  # Safety invariants: InvocationRequiresEnabledESM, InvocationRequiresActiveFunction, MessagesReferenceActiveQueues, ESMReferencesActiveQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: an "SQS" queue is created
    Given the queue does not already exist
    When an "SQS" queue is created
    Then the queue is "ACTIVE" with no dead-letter queue configured
    And every in-progress invocation was initiated by an "ENABLED" event source mapping
    And every in-progress invocation references an "ACTIVE" Lambda function
    And every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue
    And every "ENABLED" event source mapping references an "ACTIVE" queue

  @standard @negative @create_queue
  Scenario: an "SQS" queue is created fails when the queue already exists
    Given the queue already exists
    When an "SQS" queue is created
    Then the operation is rejected
