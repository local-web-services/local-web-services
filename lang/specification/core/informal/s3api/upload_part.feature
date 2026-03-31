@s3api @generated
Feature: S3api - A Part Is Uploaded For A Multipart "S3" "Upload"

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @upload_part
  Scenario: a part is uploaded for a multipart "s3" "upload"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was "IN_PROGRESS"
    When a part is uploaded for a multipart "s3" "upload"
    Then the "s3" "upload" has at least one part
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart "s3" "upload" fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a part is uploaded for a multipart "s3" "upload"
    Then the operation is rejected

  @guard @negative @upload_part @lifecycle
  Scenario: a part is uploaded for a multipart "s3" "upload" fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a part is uploaded for a multipart "s3" "upload"
    Then the operation is rejected

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart "s3" "upload" fails when the "s3" "upload" did not exist
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" did not exist
    When a part is uploaded for a multipart "s3" "upload"
    Then the operation is rejected

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart "s3" "upload" fails when the "s3" "upload" was not "IN_PROGRESS"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was not "IN_PROGRESS"
    When a part is uploaded for a multipart "s3" "upload"
    Then the operation is rejected
