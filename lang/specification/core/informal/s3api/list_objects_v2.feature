@s3api @generated
Feature: S3api - Objects In A "S3" "Bucket" Are Listed

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @minimal @happy @list_objects_v2
  Scenario: objects in a "s3" "bucket" are listed
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was "ACTIVE"
    When objects in a "s3" "bucket" are listed
    Then the list of objects in the "s3" "bucket" will be returned
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @guard @negative @list_objects_v2
  Scenario: objects in a "s3" "bucket" are listed fails when the "s3" "bucket" did not exist
    Given the "s3" "bucket" did not exist
    When objects in a "s3" "bucket" are listed
    Then the operation is rejected

  @guard @negative @list_objects_v2 @lifecycle
  Scenario: objects in a "s3" "bucket" are listed fails when the "s3" "bucket" was not "ACTIVE"
    Given the "s3" "bucket" existed
    And the "s3" "bucket" was not "ACTIVE"
    When objects in a "s3" "bucket" are listed
    Then the operation is rejected
