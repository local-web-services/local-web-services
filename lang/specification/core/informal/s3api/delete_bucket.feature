@s3api @generated
Feature: S3api - A "S3" "Bucket" Is Deleted

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @delete_bucket
  Scenario: a "s3" "bucket" is deleted
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" was empty
    When a "s3" "bucket" is deleted
    Then the "s3" "bucket" will be "DELETED"
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @delete_bucket
  Scenario: a "s3" "bucket" is deleted fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a "s3" "bucket" is deleted
    Then the operation is rejected

  @guard @negative @delete_bucket @lifecycle
  Scenario: a "s3" "bucket" is deleted fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a "s3" "bucket" is deleted
    Then the operation is rejected

  @guard @negative @delete_bucket
  Scenario: a "s3" "bucket" is deleted fails when the "s3" "bucket" was not empty
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "bucket" was not empty
    When a "s3" "bucket" is deleted
    Then the operation is rejected
