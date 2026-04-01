@s3apisqs @generated
Feature: S3apiSqs - An "Sqs" Notification Configuration Is Added To The "S3" "Bucket"

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    And the "sqs" "queue" existed and was "ACTIVE"
    When an "sqs" notification configuration is added to the "s3" "bucket"
    Then the "s3" "bucket" will send "sqs" notifications to the "sqs" "queue" when "s3" "objects" are uploaded
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @guard @negative @configure_notification
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" fails when the "s3" "bucket" did not exist or was "ACTIVE"
    Given the "s3" "bucket" did not exist or was "ACTIVE"
    When an "sqs" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" fails when the "s3" "bucket" already has a notification configuration
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" already has a notification configuration
    When an "sqs" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" fails when the "sqs" "queue" did not exist or was "ACTIVE"
    Given the "s3" "bucket" existed and was "ACTIVE"
    And the "s3" "bucket" has no notification configuration
    And the "sqs" "queue" did not exist or was "ACTIVE"
    When an "sqs" notification configuration is added to the "s3" "bucket"
    Then the operation is rejected
