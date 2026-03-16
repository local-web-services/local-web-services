@s3api @generated
Feature: S3api - An Object Is Retrieved From A Bucket

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @get_object
  Scenario: an object is retrieved from a bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is not deleted
    When an object is retrieved from a bucket
    Then the object data is returned
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @get_object
  Scenario: an object is retrieved from a bucket fails when the bucket does not exist
    Given the bucket does not exist
    When an object is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @get_object @lifecycle
  Scenario: an object is retrieved from a bucket fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When an object is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @get_object
  Scenario: an object is retrieved from a bucket fails when the object does not exist in the bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object does not exist in the bucket
    When an object is retrieved from a bucket
    Then the operation is rejected

  @standard @negative @get_object
  Scenario: an object is retrieved from a bucket fails when the object is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is deleted
    When an object is retrieved from a bucket
    Then the operation is rejected
