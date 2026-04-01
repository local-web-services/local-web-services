@s3api @generated
Feature: S3api - A Multipart "S3" "Upload" Is Aborted

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @abort_multipart_upload
  Scenario: a multipart "s3" "upload" is aborted
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was "IN_PROGRESS"
    When a multipart "s3" "upload" is aborted
    Then the "s3" "upload" will be "ABORTED"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @guard @negative @abort_multipart_upload
  Scenario: a multipart "s3" "upload" is aborted fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a multipart "s3" "upload" is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload @lifecycle
  Scenario: a multipart "s3" "upload" is aborted fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a multipart "s3" "upload" is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload
  Scenario: a multipart "s3" "upload" is aborted fails when the "s3" "upload" did not exist
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" did not exist
    When a multipart "s3" "upload" is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload
  Scenario: a multipart "s3" "upload" is aborted fails when the "s3" "upload" was not "IN_PROGRESS"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" existed
    And the "s3" "upload" was not "IN_PROGRESS"
    When a multipart "s3" "upload" is aborted
    Then the operation is rejected
