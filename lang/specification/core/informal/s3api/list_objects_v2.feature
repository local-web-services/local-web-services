@s3api @generated
Feature: S3api - Objects In A Bucket Are Listed

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @list_objects_v2
  Scenario: objects in a bucket are listed
    Given the bucket exists
    And the bucket is "ACTIVE"
    When objects in a bucket are listed
    Then the list of objects in the bucket is returned
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @list_objects_v2
  Scenario: objects in a bucket are listed fails when the bucket does not exist
    Given the bucket does not exist
    When objects in a bucket are listed
    Then the operation is rejected

  @guard @negative @list_objects_v2 @lifecycle
  Scenario: objects in a bucket are listed fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When objects in a bucket are listed
    Then the operation is rejected
