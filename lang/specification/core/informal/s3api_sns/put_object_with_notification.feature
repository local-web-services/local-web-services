@s3apisns @generated
Feature: S3apiSns - An Object Is Uploaded And S3 Publishes A Notification To The Sns Topic

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "ACTIVE"
    And an object slot is available
    And a message slot is available
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the object "EXISTS" and a notification is "PUBLISHED" to the topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic fails when the bucket is not "ACTIVE"
    Given the bucket is not "ACTIVE"
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the operation is rejected

  @standard @negative @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic fails when the bucket has no notification configuration
    Given the bucket is "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the operation is rejected

  @standard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic fails when the target topic is "DELETED"
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "DELETED"
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the operation is rejected

  @standard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic fails when no object slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "ACTIVE"
    And no object slot is available
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the operation is rejected

  @standard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic fails when no message slot is available
    Given the bucket is "ACTIVE"
    And the bucket has a notification configuration
    And the target topic is "ACTIVE"
    And an object slot is available
    And no message slot is available
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then the operation is rejected
