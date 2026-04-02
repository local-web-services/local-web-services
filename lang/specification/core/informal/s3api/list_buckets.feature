@s3api @generated
Feature: S3api - The List Of "S3" "Buckets" Is Retrieved

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @list_buckets
  Scenario: the list of "s3" "buckets" is retrieved
    When the list of "s3" "buckets" is retrieved
    Then the available "s3" "buckets" will be returned
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty
