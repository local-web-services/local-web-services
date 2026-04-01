@s3apisqs @generated
Feature: S3apiSqs - An Object Is Uploaded To The Bucket And S3 Delivers A Notification To The "Sqs" "Queue"

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_notification
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And a "sqs" "message" "slot" was "available"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the "s3" "object" will exist and a "sqs" notification "message" will be "QUEUED"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_object_with_notification
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" fails when the "s3" "bucket" has no notification configuration
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" fails when the target "sqs" "queue" was "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "DELETED"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" fails when no "sqs" "message" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sqs" "queue" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And no "sqs" "message" "slot" was "available"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Then the operation is rejected
