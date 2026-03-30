@s3api @generated
Feature: S3api - A Part Is Uploaded For A Multipart Upload

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @upload_part
  Scenario: a part is uploaded for a multipart upload
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is "IN_PROGRESS"
    When a part is uploaded for a multipart upload
    Then the upload has at least one part
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart upload fails when the bucket does not exist
    Given the bucket does not exist
    When a part is uploaded for a multipart upload
    Then the operation is rejected

  @guard @negative @upload_part @lifecycle
  Scenario: a part is uploaded for a multipart upload fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a part is uploaded for a multipart upload
    Then the operation is rejected

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart upload fails when the upload does not exist
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload does not exist
    When a part is uploaded for a multipart upload
    Then the operation is rejected

  @guard @negative @upload_part
  Scenario: a part is uploaded for a multipart upload fails when the upload is not "IN_PROGRESS"
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload exists
    And the upload is not "IN_PROGRESS"
    When a part is uploaded for a multipart upload
    Then the operation is rejected
