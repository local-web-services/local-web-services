@sqs @generated
Feature: Sqs - Queue Attributes Are Retrieved

  # Generated from FizzBee spec: sqs.fizz
  # Safety invariants: MessagesReferValidQueues, InFlightMessagesBelongToActiveQueues, ReceiveCountNonNegative

  Background:
    Given the system is initialized

  @minimal @happy @get_queue_attributes
  Scenario: queue attributes are retrieved
    Given the queue exists
    And the queue is "ACTIVE"
    When queue attributes are retrieved
    Then the queue attributes are returned
    And every non-deleted message belongs to an "ACTIVE" queue
    And every in-flight message belongs to an "ACTIVE" queue
    And every message has a non-negative receive count

  @standard @negative @get_queue_attributes
  Scenario: queue attributes are retrieved fails when the queue does not exist
    Given the queue does not exist
    When queue attributes are retrieved
    Then the operation is rejected

  @standard @negative @get_queue_attributes @lifecycle @internal
  Scenario: queue attributes are retrieved fails when the queue is not "ACTIVE"
    Given the queue exists
    And the queue is not "ACTIVE"
    When queue attributes are retrieved
    Then the operation is rejected
