@s3apisns @generated
Feature: S3apiSns - An Object Is Uploaded But Notification Delivery Fails Because The Topic Has Been Deleted

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "DELETED"
    And an object slot is available
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then the object "EXISTS" but no notification is published
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @put_object_notification_fails @lifecycle
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted fails when the bucket is not "ACTIVE"
    Given the bucket is not "ACTIVE"
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted fails when the bucket has no notification configuration
    Given the bucket is "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails @lifecycle
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted fails when the target topic is not "DELETED"
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is not "DELETED"
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then the operation is rejected

  @standard @negative @put_object_notification_fails @capacity
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted fails when no object slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "DELETED"
    And no object slot is available
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then the operation is rejected
