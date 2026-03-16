@s3api @generated
Feature: S3api - A Multipart Upload Is Initiated

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @create_multipart_upload
  Scenario: a multipart upload is initiated
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload does not already exist
    When a multipart upload is initiated
    Then the upload is "IN_PROGRESS" with no parts
    And every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @standard @negative @create_multipart_upload
  Scenario: a multipart upload is initiated fails when the bucket does not exist
    Given the bucket does not exist
    When a multipart upload is initiated
    Then the operation is rejected

  @standard @negative @create_multipart_upload @lifecycle
  Scenario: a multipart upload is initiated fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a multipart upload is initiated
    Then the operation is rejected

  @standard @negative @create_multipart_upload
  Scenario: a multipart upload is initiated fails when the upload already exists
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the upload already exists
    When a multipart upload is initiated
    Then the operation is rejected
