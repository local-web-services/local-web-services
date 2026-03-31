@s3apisqs @generated
Feature: S3apiSqs - A Sqs Notification Configuration Is Added To The Bucket

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a "SQS" notification configuration is added to the bucket
    Given the bucket existed and was "ACTIVE"
    And the bucket has no notification configuration
    And the "sqs" "queue" existed and was "ACTIVE"
    When a "SQS" notification configuration is added to the bucket
    Then the bucket will send notifications to the queue when objects are uploaded
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @guard @negative @configure_notification
  Scenario: a "SQS" notification configuration is added to the bucket fails when the bucket did not exist or was "ACTIVE"
    Given the bucket did not exist or was "ACTIVE"
    When a "SQS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SQS" notification configuration is added to the bucket fails when the bucket already has a notification configuration
    Given the bucket existed and was "ACTIVE"
    And the bucket already has a notification configuration
    When a "SQS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SQS" notification configuration is added to the bucket fails when the "sqs" "queue" did not exist or was "ACTIVE"
    Given the bucket existed and was "ACTIVE"
    And the bucket has no notification configuration
    And the "sqs" "queue" did not exist or was "ACTIVE"
    When a "SQS" notification configuration is added to the bucket
    Then the operation is rejected
