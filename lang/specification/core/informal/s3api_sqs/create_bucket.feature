@s3apisqs @generated
Feature: S3apiSqs - An S3 Bucket Is Created

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: an S3 bucket is created
    Given the bucket does not already exist
    When an S3 bucket is created
    Then the bucket is "ACTIVE" with no notification configuration
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @standard @negative @create_bucket
  Scenario: an S3 bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 bucket is created
    Then the operation is rejected
