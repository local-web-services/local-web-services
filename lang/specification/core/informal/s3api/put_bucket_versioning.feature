@s3api @generated
Feature: S3api - Versioning Is Configured On A "S3" "Bucket"

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @put_bucket_versioning
  Scenario: versioning is configured on a "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    When versioning is configured on a "s3" "bucket"
    Then the "s3" "bucket" versioning state will be "ENABLED" or "SUSPENDED" non-deterministically
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @put_bucket_versioning
  Scenario: versioning is configured on a "s3" "bucket" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When versioning is configured on a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_bucket_versioning @lifecycle
  Scenario: versioning is configured on a "s3" "bucket" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When versioning is configured on a "s3" "bucket"
    Then the operation is rejected
