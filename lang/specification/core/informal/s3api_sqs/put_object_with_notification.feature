@s3apisqs @generated
Feature: S3apiSqs - An Object Is Uploaded To The Bucket And S3 Delivers A Notification To The Sqs Queue

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_notification
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "ACTIVE"
    And an object slot is available
    And a message slot is available
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the object "EXISTS" and a notification message is "QUEUED"
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @standard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue fails when the bucket is not "ACTIVE"
    Given the bucket is not "ACTIVE"
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_object_with_notification
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue fails when the bucket has no notification configuration
    Given the bucket is "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the operation is rejected

  @standard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue fails when the target queue is "DELETED"
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "DELETED"
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the operation is rejected

  @standard @negative @internal @put_object_with_notification @capacity
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue fails when no object slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "ACTIVE"
    And no object slot is available
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the operation is rejected

  @standard @negative @internal @put_object_with_notification @capacity
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue fails when no message slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "ACTIVE"
    And an object slot is available
    And no message slot is available
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Then the operation is rejected
