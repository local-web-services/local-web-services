@s3api @generated
Feature: S3api - Object Metadata Is Retrieved From A Bucket

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @head_object
  Scenario: object metadata is retrieved from a bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is not deleted
    When object metadata is retrieved from a bucket
    Then the object metadata is returned
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @head_object
  Scenario: object metadata is retrieved from a bucket fails when the bucket does not exist
    Given the bucket does not exist
    When object metadata is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @head_object @lifecycle @internal
  Scenario: object metadata is retrieved from a bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When object metadata is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @head_object
  Scenario: object metadata is retrieved from a bucket fails when the object does not exist in the bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object does not exist in the bucket
    When object metadata is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @head_object
  Scenario: object metadata is retrieved from a bucket fails when the object is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is deleted
    When object metadata is retrieved from a bucket
    Then the operation is rejected
