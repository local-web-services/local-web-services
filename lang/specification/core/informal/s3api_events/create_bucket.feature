@s3apievents @generated
Feature: S3apiEvents - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: s3api_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingObject, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the bucket did not already exist
    When a "s3" "bucket" is created
    Then the bucket will be "ACTIVE" with no EventBridge notification configuration
    And every "DELIVERED" event references an object that exists
    And every "DELIVERED" event references a bus that exists

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the bucket already existed
    Given the bucket already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
