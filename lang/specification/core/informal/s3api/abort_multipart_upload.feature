@s3api @generated
Feature: S3api - A Multipart Upload Is Aborted

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @abort_multipart_upload
  Scenario: a multipart upload is aborted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is "IN_PROGRESS"
    When a multipart upload is aborted
    Then the upload is "ABORTED"
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @abort_multipart_upload
  Scenario: a multipart upload is aborted fails when the bucket does not exist
    Given the bucket does not exist
    When a multipart upload is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload @lifecycle
  Scenario: a multipart upload is aborted fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a multipart upload is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload
  Scenario: a multipart upload is aborted fails when the upload does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload does not exist
    When a multipart upload is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload
  Scenario: a multipart upload is aborted fails when the upload is not "IN_PROGRESS"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is not "IN_PROGRESS"
    When a multipart upload is aborted
    Then the operation is rejected
