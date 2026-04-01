@s3api @generated
Feature: S3api - A Multipart "S3" "Upload" Is Completed

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @complete_multipart_upload
  Scenario: a multipart "s3" "upload" is completed
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was "IN_PROGRESS"
    And the "s3" "upload" had at least one part
    When a multipart "s3" "upload" is completed
    Then the "s3" "upload" will be "COMPLETED" and the assembled "s3" "object" will exist in the "s3" "bucket"
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "s3" "upload" is completed fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a multipart "s3" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart "s3" "upload" is completed fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a multipart "s3" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "s3" "upload" is completed fails when the "s3" "upload" did not exist
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" did not exist
    When a multipart "s3" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "s3" "upload" is completed fails when the "s3" "upload" was not "IN_PROGRESS"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was not "IN_PROGRESS"
    When a multipart "s3" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "s3" "upload" is completed fails when the "s3" "upload" had no parts
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was "IN_PROGRESS"
    And the "s3" "upload" had no parts
    When a multipart "s3" "upload" is completed
    Then the operation is rejected
