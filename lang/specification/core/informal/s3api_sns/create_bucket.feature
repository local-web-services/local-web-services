@s3apisns @generated
Feature: S3apiSns - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the bucket did not already exist
    When a "s3" "bucket" is created
    Then the bucket will be "ACTIVE" with no notification configuration
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the bucket already existed
    Given the bucket already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
