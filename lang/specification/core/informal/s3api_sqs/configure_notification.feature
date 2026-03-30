@s3apisqs @generated
Feature: S3apiSqs - An Sqs Notification Configuration Is Added To The Bucket

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an "SQS" notification configuration is added to the bucket
    Given the bucket exists and is "ACTIVE"
    And the bucket has no notification configuration
    And the queue exists and is "ACTIVE"
    When an "SQS" notification configuration is added to the bucket
    Then the bucket will send notifications to the queue when objects are uploaded
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @guard @negative @configure_notification
  Scenario: an "SQS" notification configuration is added to the bucket fails when the bucket does not exist or is not "ACTIVE"
    Given the bucket does not exist or is not "ACTIVE"
    When an "SQS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SQS" notification configuration is added to the bucket fails when the bucket already has a notification configuration
    Given the bucket exists and is "ACTIVE"
    And the bucket already has a notification configuration
    When an "SQS" notification configuration is added to the bucket
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SQS" notification configuration is added to the bucket fails when the queue does not exist or is not "ACTIVE"
    Given the bucket exists and is "ACTIVE"
    And the bucket has no notification configuration
    And the queue does not exist or is not "ACTIVE"
    When an "SQS" notification configuration is added to the bucket
    Then the operation is rejected
