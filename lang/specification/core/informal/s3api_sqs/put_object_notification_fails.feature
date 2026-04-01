@s3apisqs @generated
Feature: S3apiSqs - An Object Is Uploaded But Notification Delivery Fails Because The Queue Has Been Deleted

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target queue was "DELETED"
    And an object slot is available
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the object will exist but no notification message will be delivered
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the bucket was not "ACTIVE"
    Given the bucket was not "ACTIVE"
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the bucket has no notification configuration
    Given the bucket was "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when the target queue was not "DELETED"
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target queue was not "DELETED"
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @capacity
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted fails when no object slot is available
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target queue was "DELETED"
    And no object slot is available
    When an object is uploaded but notification delivery fails because the queue has been deleted
    Then the operation is rejected
