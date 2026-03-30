@s3api @generated
Feature: S3api - Versioning Is Configured On A Bucket

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @put_bucket_versioning
  Scenario: versioning is configured on a bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    When versioning is configured on a bucket
    Then the bucket versioning state is "ENABLED" or "SUSPENDED" non-deterministically
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @put_bucket_versioning
  Scenario: versioning is configured on a bucket fails when the bucket does not exist
    Given the bucket does not exist
    When versioning is configured on a bucket
    Then the operation is rejected

  @guard @negative @put_bucket_versioning @lifecycle
  Scenario: versioning is configured on a bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When versioning is configured on a bucket
    Then the operation is rejected
