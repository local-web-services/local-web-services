@s3apisns @generated
Feature: S3apiSns - An Object Is Uploaded And S3 Publishes A Notification To The "Sns" "Topic"

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And a "sns" "message" "slot" was "available"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the "s3" "object" will exist and a "sns" notification will be "PUBLISHED" to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the "s3" "bucket" has no notification configuration
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @lifecycle
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when the target "sns" "topic" was "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "DELETED"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "ACTIVE"
    And no "s3" "object" "slot" was "available"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @put_object_with_notification @capacity
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" fails when no "sns" "message" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "ACTIVE"
    And a "s3" "object" "slot" was "available"
    And no "sns" "message" "slot" was "available"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Then the operation is rejected
