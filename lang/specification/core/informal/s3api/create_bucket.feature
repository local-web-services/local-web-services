@s3api @generated
Feature: S3api - A Bucket Is Created

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a bucket is created
    Given the bucket does not already exist
    When a bucket is created
    Then the bucket is "ACTIVE" with versioning disabled
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @create_bucket
  Scenario: a bucket is created fails when the bucket already exists
    Given the bucket already exists
    When a bucket is created
    Then the operation is rejected
