@s3apisns @generated
Feature: S3apiSns - An Sns Notification Configuration Is Added To The Bucket

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an "SNS" notification configuration is added to the bucket
    Given the bucket exists and is "ACTIVE"
    And the bucket has no notification configuration
    And the topic exists and is "ACTIVE"
    When an "SNS" notification configuration is added to the bucket
    Then the bucket will publish notifications to the topic when objects are uploaded
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @configure_notification
  Scenario: an "SNS" notification configuration is added to the bucket fails when the bucket does not exist or is not "ACTIVE"
    Given the bucket does not exist or is not "ACTIVE"
    When an "SNS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SNS" notification configuration is added to the bucket fails when the bucket already has a notification configuration
    Given the bucket exists and is "ACTIVE"
    And the bucket already has a notification configuration
    When an "SNS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SNS" notification configuration is added to the bucket fails when the topic does not exist or is not "ACTIVE"
    Given the bucket exists and is "ACTIVE"
    And the bucket has no notification configuration
    And the topic does not exist or is not "ACTIVE"
    When an "SNS" notification configuration is added to the bucket
    Then the operation is rejected
