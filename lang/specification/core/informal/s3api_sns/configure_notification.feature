@s3apisns @generated
Feature: S3apiSns - A "Sns" Notification Configuration Is Added To The "S3" "Bucket"

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a "sns" notification configuration is added to the "s3" "bucket"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    And the "sns" "topic" existed and was "ACTIVE"
    When a "sns" notification configuration is added to the "s3" "bucket"
    Then the "s3" "bucket" will publish "sns" notifications to the "sns" "topic" when "s3" "objects" are uploaded
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @guard @negative @configure_notification
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" fails when the "s3" "bucket" did not exist or was "ACTIVE"
    Given the "s3" "bucket" did not exist or was "ACTIVE"
    When a "sns" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" fails when the "s3" "bucket" already has a notification configuration
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" already has a notification configuration
    When a "sns" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" fails when the "sns" "topic" did not exist or was "ACTIVE"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    And the "sns" "topic" did not exist or was "ACTIVE"
    When a "sns" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected
