@s3api @generated
Feature: S3api - A Bucket Is Deleted

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @delete_bucket
  Scenario: a bucket is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket is empty
    When a bucket is deleted
    Then the bucket is "DELETED"
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @delete_bucket
  Scenario: a bucket is deleted fails when the bucket does not exist
    Given the bucket does not exist
    When a bucket is deleted
    Then the operation is rejected

  @standard @negative @delete_bucket @lifecycle
  Scenario: a bucket is deleted fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a bucket is deleted
    Then the operation is rejected

  @standard @negative @delete_bucket
  Scenario: a bucket is deleted fails when the bucket is not empty
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket is not empty
    When a bucket is deleted
    Then the operation is rejected
