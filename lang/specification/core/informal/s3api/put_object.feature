@s3api @generated
Feature: S3api - An Object Is Uploaded To A Bucket

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @put_object
  Scenario: an object is uploaded to a bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    When an object is uploaded to a bucket
    Then the object "EXISTS" in the bucket
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @put_object
  Scenario: an object is uploaded to a bucket fails when the bucket does not exist
    Given the bucket does not exist
    When an object is uploaded to a bucket
    Then the operation is rejected

  @standard @negative @put_object @lifecycle @internal
  Scenario: an object is uploaded to a bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When an object is uploaded to a bucket
    Then the operation is rejected
