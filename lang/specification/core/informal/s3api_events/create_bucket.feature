@s3apievents @generated
Feature: S3apiEvents - An S3 Bucket Is Created

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: an S3 bucket is created
    Given the bucket does not already exist
    When an S3 bucket is created
    Then the bucket is "ACTIVE" with no EventBridge notification configuration
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_bucket
  Scenario: an S3 bucket is created fails when the bucket already exists
    Given the bucket already exists
    When an S3 bucket is created
    Then the operation is rejected
