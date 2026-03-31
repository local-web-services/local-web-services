@s3apisqs @generated
Feature: S3apiSqs - The "Sqs" "Queue" Is Deleted

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @delete_queue
  Scenario: the "sqs" "queue" is deleted
    Given the "sqs" "queue" existed
    And the "sqs" "queue" was "ACTIVE"
    When the "sqs" "queue" is deleted
    Then the "sqs" "queue" will be deleted and notification delivery to it will fail
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @guard @negative @delete_queue
  Scenario: the "sqs" "queue" is deleted fails when the "sqs" "queue" did not exist
    Given the "sqs" "queue" did not exist
    When the "sqs" "queue" is deleted
    Then the operation is rejected

  @guard @negative @delete_queue @lifecycle
  Scenario: the "sqs" "queue" is deleted fails when the queue is already "DELETED"
    Given the "sqs" "queue" existed
    And the queue is already "DELETED"
    When the "sqs" "queue" is deleted
    Then the operation is rejected
