@s3apisqs @generated
Feature: S3apiSqs - An Object Is Uploaded But Notification Delivery Fails Because The Queue Has Been Deleted

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "DELETED"
    And an object slot is available
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the object "EXISTS" but no notification message is delivered
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @standard @negative @put_object_notification_fails @lifecycle @internal
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the bucket is not "ACTIVE"
    Given the bucket is not "ACTIVE"
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the bucket has no notification configuration
    Given the bucket is "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails @lifecycle @internal
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the target queue is not "DELETED"
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is not "DELETED"
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails @capacity @internal
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when no object slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target queue is "DELETED"
    And no object slot is available
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected
