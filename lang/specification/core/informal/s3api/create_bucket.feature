@s3api @generated
Feature: S3api - A "S3" "Bucket" Is Created

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @create_bucket
  Scenario: a "s3" "bucket" is created
    Given the "s3" "bucket" did not already exist
    When a "s3" "bucket" is created
    Then the "s3" "bucket" will be "ACTIVE" with versioning disabled
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @create_bucket
  Scenario: a "s3" "bucket" is created fails when the "s3" "bucket" already existed
    Given the "s3" "bucket" already existed
    When a "s3" "bucket" is created
    Then the operation is rejected
