@s3api @generated
Feature: S3api - A Lifecycle Rule Expires An Object

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @lifecycle_expire_object @internal
  Scenario: a lifecycle rule expires an object
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is not deleted
    When a lifecycle rule expires an object
    Then the object is "DELETED" by the lifecycle policy
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @lifecycle_expire_object @internal
  Scenario: a lifecycle rule expires an object fails when the bucket does not exist
    Given the bucket does not exist
    When a lifecycle rule expires an object
    Then the operation is rejected

  @standard @negative @lifecycle_expire_object @internal
  Scenario: a lifecycle rule expires an object fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a lifecycle rule expires an object
    Then the operation is rejected

  @standard @negative @lifecycle_expire_object @internal
  Scenario: a lifecycle rule expires an object fails when the object does not exist in the bucket
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object does not exist in the bucket
    When a lifecycle rule expires an object
    Then the operation is rejected

  @standard @negative @lifecycle_expire_object @internal
  Scenario: a lifecycle rule expires an object fails when the object is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the object exists in the bucket
    And the object is deleted
    When a lifecycle rule expires an object
    Then the operation is rejected
