@s3api @generated
Feature: S3api - A Multipart Upload Is Completed

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @complete_multipart_upload
  Scenario: a multipart upload is completed
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is "IN_PROGRESS"
    And the upload has at least one part
    When a multipart upload is completed
    Then the upload is "COMPLETED" and the assembled object "EXISTS" in the bucket
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @complete_multipart_upload
  Scenario: a multipart upload is completed fails when the bucket does not exist
    Given the bucket does not exist
    When a multipart upload is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart upload is completed fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a multipart upload is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart upload is completed fails when the upload does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload does not exist
    When a multipart upload is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart upload is completed fails when the upload is not "IN_PROGRESS"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is not "IN_PROGRESS"
    When a multipart upload is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart upload is completed fails when the upload has no parts
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is "IN_PROGRESS"
    And the upload has no parts
    When a multipart upload is completed
    Then the operation is rejected
