@s3api @generated
Feature: S3api - A "S3" "Object" Is Copied From One "S3" "Bucket" To Another

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @copy_object
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was "ACTIVE"
    And the source "s3" "object" existed
    And the source "s3" "object" is not "DELETED"
    And the destination "s3" "bucket" existed
    And the destination "s3" "bucket" was "ACTIVE"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the "s3" "object" will exist in the destination "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @guard @negative @copy_object
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the source "s3" "bucket" did not exist
    Given the source "s3" "bucket" did not exist
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected

  @guard @negative @copy_object @lifecycle
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the source "s3" "bucket" was not "ACTIVE"
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was not "ACTIVE"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the source "s3" "object" did not exist
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was "ACTIVE"
    And the source "s3" "object" did not exist
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the source "s3" "object" is "DELETED"
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was "ACTIVE"
    And the source "s3" "object" existed
    And the source "s3" "object" is "DELETED"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected

  @guard @negative @copy_object
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the destination "s3" "bucket" did not exist
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was "ACTIVE"
    And the source "s3" "object" existed
    And the source "s3" "object" is not "DELETED"
    And the destination "s3" "bucket" did not exist
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected

  @guard @negative @copy_object @lifecycle
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another fails when the destination "s3" "bucket" was not "ACTIVE"
    Given the source "s3" "bucket" existed
    And the source "s3" "bucket" was "ACTIVE"
    And the source "s3" "object" existed
    And the source "s3" "object" is not "DELETED"
    And the destination "s3" "bucket" existed
    And the destination "s3" "bucket" was not "ACTIVE"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    Then the operation is rejected
