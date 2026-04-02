@s3apisns @generated
Feature: S3apiSns - An "S3" "Object" Is Uploaded But "Sns" Notification Delivery Fails Because The "Sns" "Topic" Has Been Deleted

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @put_object_notification_fails
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "DELETED"
    And a "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Then the "s3" "object" will exist but no "sns" notification will be published
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" was not "ACTIVE"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted fails when the "s3" "bucket" has no notification configuration
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @lifecycle
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted fails when the target "sns" "topic" was not "DELETED"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was not "DELETED"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @put_object_notification_fails @capacity
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted fails when no "s3" "object" "slot" was "available"
    Given the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" has a notification configuration
    And the target "sns" "topic" was "DELETED"
    And no "s3" "object" "slot" was "available"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Then the operation is rejected
