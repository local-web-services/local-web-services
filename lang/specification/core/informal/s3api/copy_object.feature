@s3api @generated
Feature: S3api - An Object Is Copied From One Bucket To Another

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @copy_object
  Scenario: an object is copied from one bucket to another
    Given the source bucket exists
    And the source bucket is "ACTIVE"
    And the source object exists
    And the source object is not deleted
    And the destination bucket exists
    And the destination bucket is "ACTIVE"
    When an object is copied from one bucket to another
    Then the object "EXISTS" in the destination bucket
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @copy_object
  Scenario: an object is copied from one bucket to another fails when the source bucket does not exist
    Given the source bucket does not exist
    When an object is copied from one bucket to another
    Then the operation is rejected

  @guard @negative @copy_object @lifecycle
  Scenario: an object is copied from one bucket to another fails when the source bucket is not "ACTIVE"
    Given the source bucket exists
    And the source bucket is not "ACTIVE"
    When an object is copied from one bucket to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: an object is copied from one bucket to another fails when the source object does not exist
    Given the source bucket exists
    And the source bucket is "ACTIVE"
    And the source object does not exist
    When an object is copied from one bucket to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: an object is copied from one bucket to another fails when the source object is deleted
    Given the source bucket exists
    And the source bucket is "ACTIVE"
    And the source object exists
    And the source object is deleted
    When an object is copied from one bucket to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: an object is copied from one bucket to another fails when the destination bucket does not exist
    Given the source bucket exists
    And the source bucket is "ACTIVE"
    And the source object exists
    And the source object is not deleted
    And the destination bucket does not exist
    When an object is copied from one bucket to another
    Then the operation is rejected

  @guard @negative @copy_object @lifecycle
  Scenario: an object is copied from one bucket to another fails when the destination bucket is not "ACTIVE"
    Given the source bucket exists
    And the source bucket is "ACTIVE"
    And the source object exists
    And the source object is not deleted
    And the destination bucket exists
    And the destination bucket is not "ACTIVE"
    When an object is copied from one bucket to another
    Then the operation is rejected
