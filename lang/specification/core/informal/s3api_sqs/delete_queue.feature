@s3apisqs @generated
Feature: S3apiSqs - The Sqs Queue Is Deleted

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @delete_queue
  Scenario: the "SQS" queue is deleted
    Given the queue exists
    And the queue is "ACTIVE"
    When the "SQS" queue is deleted
    Then the queue is "DELETED" and notification delivery to it will fail
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @guard @negative @delete_queue
  Scenario: the "SQS" queue is deleted fails when the queue does not exist
    Given the queue does not exist
    When the "SQS" queue is deleted
    Then the operation is rejected

  @guard @negative @delete_queue @lifecycle
  Scenario: the "SQS" queue is deleted fails when the queue is already "DELETED"
    Given the queue exists
    And the queue is already "DELETED"
    When the "SQS" queue is deleted
    Then the operation is rejected
