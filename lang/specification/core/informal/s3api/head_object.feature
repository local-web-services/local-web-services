@s3api @generated
Feature: S3api - "S3" "Object" Metadata Is Retrieved From A "S3" "Bucket"

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @head_object
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" existed in the "s3" "bucket"
    And the "s3" "object" was not "deleted"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    Then the "s3" "object" metadata will be returned
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @guard @negative @head_object
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @head_object @lifecycle
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @head_object
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" fails when the "s3" "object" did not exist in the "s3" "bucket"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" did not exist in the "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    Then the operation is rejected

  @guard @negative @head_object
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" fails when the "s3" "object" was "deleted"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "object" existed in the "s3" "bucket"
    And the "s3" "object" was "deleted"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    Then the operation is rejected
