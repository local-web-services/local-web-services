@s3apisns @generated
Feature: S3apiSns - An Object Is Uploaded And S3 Publishes A Notification To The "Sns" "Topic"

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target topic was "ACTIVE"
    And an object slot is available
    And a message slot is available
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the object will exist and a notification will be "PUBLISHED" to the topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the bucket was not "ACTIVE"
    Given the bucket was not "ACTIVE"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the bucket has no notification configuration
    Given the bucket was "ACTIVE"
    And the bucket has no notification configuration
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the target topic was "DELETED"
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target topic was "DELETED"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when no object slot is available
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target topic was "ACTIVE"
    And no object slot is available
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when no message slot is available
    Given the bucket was "ACTIVE"
    And the bucket has a notification configuration
    And the target topic was "ACTIVE"
    And an object slot is available
    And no message slot is available
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected
