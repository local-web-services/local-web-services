@sqs @generated
Feature: Sqs - A Queue Is Created

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @create_queue
  Scenario: a queue is created
    Given the queue does not already exist
    When a queue is created
    Then the queue is "ACTIVE"
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @guard @negative @create_queue
  Scenario: a queue is created fails when the queue already exists
    Given the queue already exists
    When a queue is created
    Then the operation is rejected
