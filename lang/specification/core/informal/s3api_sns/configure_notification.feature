@s3apisns @generated
Feature: S3apiSns - A Sns Notification Configuration Is Added To The Bucket

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a "SNS" notification configuration is added to the bucket
    Given the bucket existed and was "ACTIVE"
    And the bucket has no notification configuration
    And the "sns" "topic" existed and was "ACTIVE"
    When a "SNS" notification configuration is added to the bucket
    Then the bucket will publish notifications to the topic when objects are uploaded
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @configure_notification
  Scenario: a "SNS" notification configuration is added to the bucket fails when the bucket did not exist or was "ACTIVE"
    Given the bucket did not exist or was "ACTIVE"
    When a "SNS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification configuration is added to the bucket fails when the bucket already has a notification configuration
    Given the bucket existed and was "ACTIVE"
    And the bucket already has a notification configuration
    When a "SNS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification configuration is added to the bucket fails when the "sns" "topic" did not exist or was "ACTIVE"
    Given the bucket existed and was "ACTIVE"
    And the bucket has no notification configuration
    And the "sns" "topic" did not exist or was "ACTIVE"
    When a "SNS" notification configuration is added to the bucket
    Then the operation is rejected
