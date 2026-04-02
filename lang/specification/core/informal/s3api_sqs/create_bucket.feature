@s3apisqs @generated
Feature: S3apiSqs - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the "s3" "bucket" did not already exist
    When a "s3" "bucket" is created
    Then the "s3" "bucket" will be "ACTIVE" with no notification configuration
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the "s3" "bucket" already existed
    Given the "s3" "bucket" already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
