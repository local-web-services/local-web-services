@s3apisqs @generated
Feature: S3apiSqs - An "S3" "Object" Is Uploaded But "Sqs" Notification Delivery Fails Because The "Sqs" "Queue" Has Been Deleted

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @put_object_notification_fails
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "DELETED"
    And a "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Then the "s3" "object" will exist but no "sqs" notification "message" will be delivered
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted fails when the "s3" "bucket" has no notification configuration
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted fails when the target "sqs" "queue" was not "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was not "DELETED"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @capacity
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "DELETED"
    And no "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Then the operation is rejected
