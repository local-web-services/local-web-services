@s3api @generated
Feature: S3api - A "S3" "Object" Is Uploaded To A "S3" "Bucket"

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @put_object
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    Then the "s3" "object" will exist in the "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @guard @negative @put_object
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a "s3" "object" is uploaded to a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @put_object @lifecycle
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    Then the operation is rejected
