@s3api @generated
Feature: S3api - A "S3" "Object" Is Deleted From A "S3" "Bucket"

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @delete_object
  Scenario: a "s3" "object" is deleted from a "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" existed in the "s3" "bucket"
    And the "s3" "object" was not "deleted"
    When a "s3" "object" is deleted from a "s3" "bucket"
    Then the "s3" "object" will be "DELETED"
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @delete_object
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a "s3" "object" is deleted from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @delete_object @lifecycle
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a "s3" "object" is deleted from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @delete_object
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" fails when the "s3" "object" did not exist in the "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" did not exist in the "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @delete_object
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" fails when the "s3" "object" was "deleted"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" existed in the "s3" "bucket"
    And the "s3" "object" was "deleted"
    When a "s3" "object" is deleted from a "s3" "bucket"
    Then the operation is rejected
