@s3api @generated
Feature: S3api - A Multipart "S3" "Upload" Is Initiated

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @create_multipart_upload
  Scenario: a multipart "s3" "upload" is initiated
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" did not already exist
    When a multipart "s3" "upload" is initiated
    Then the "s3" "upload" will be "IN_PROGRESS" with no parts
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @create_multipart_upload
  Scenario: a multipart "s3" "upload" is initiated fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When a multipart "s3" "upload" is initiated
    Then the operation is rejected

  @guard @negative @create_multipart_upload @lifecycle
  Scenario: a multipart "s3" "upload" is initiated fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When a multipart "s3" "upload" is initiated
    Then the operation is rejected

  @guard @negative @create_multipart_upload
  Scenario: a multipart "s3" "upload" is initiated fails when the "s3" "upload" already existed
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    And the "s3" "upload" already existed
    When a multipart "s3" "upload" is initiated
    Then the operation is rejected
