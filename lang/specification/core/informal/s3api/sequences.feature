@s3api @generated
Feature: S3api - Action Sequences

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "bucket" is deleted
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then the list of "s3" "buckets" is retrieved
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then versioning is configured on a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then objects in a "s3" "bucket" are listed
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is initiated
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a part is uploaded for a multipart "s3" "upload"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is completed
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is aborted
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a lifecycle "s3" rule expires a "s3" "object"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "bucket" is created
    When the list of "s3" "buckets" is retrieved
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then versioning is configured on a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is uploaded to a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is deleted from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then "s3" "object" metadata is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then objects in a "s3" "bucket" are listed
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is copied from one "s3" "bucket" to another
    When the list of "s3" "buckets" is retrieved
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is initiated
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a part is uploaded for a multipart "s3" "upload"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is completed
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is aborted
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a lifecycle "s3" rule expires a "s3" "object"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "bucket" is created
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is created
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is deleted
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then the list of "s3" "buckets" is retrieved
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then versioning is configured on a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is uploaded to a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is retrieved from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is deleted from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then objects in a "s3" "bucket" are listed
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is initiated
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a part is uploaded for a multipart "s3" "upload"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is completed
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is aborted
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a lifecycle "s3" rule expires a "s3" "object"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "bucket" is deleted then the list of "s3" "buckets" is retrieved
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then the list of "s3" "buckets" is retrieved then versioning is configured on a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When the list of "s3" "buckets" is retrieved
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then versioning is configured on a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is deleted from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is deleted from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then "s3" "object" metadata is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then objects in a "s3" "bucket" are listed then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is initiated
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is initiated then a part is uploaded for a multipart "s3" "upload"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is initiated
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is completed
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is completed then a multipart "s3" "upload" is aborted
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is completed
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a multipart "s3" "upload" is aborted then a lifecycle "s3" rule expires a "s3" "object"
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is aborted
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is created then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is deleted
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "bucket" is created then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then the list of "s3" "buckets" is retrieved then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then versioning is configured on a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is retrieved from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is deleted from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is deleted from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a "s3" "object" is copied from one "s3" "bucket" to another then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is completed then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is completed
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a multipart "s3" "upload" is aborted then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "bucket" is deleted then a lifecycle "s3" rule expires a "s3" "object" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a lifecycle "s3" rule expires a "s3" "object"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "bucket" is created then a "s3" "object" is uploaded to a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname not in bucket_status
    When a "s3" "bucket" is created
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "bucket" is deleted then a "s3" "object" is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "bucket" is deleted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then versioning is configured on a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is uploaded to a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then objects in a "s3" "bucket" are listed then a part is uploaded for a multipart "s3" "upload"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is completed
    When the list of "s3" "buckets" is retrieved
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is aborted
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a part is uploaded for a multipart "s3" "upload" then a lifecycle "s3" rule expires a "s3" "object"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is completed then a "s3" "bucket" is created
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is aborted then a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: the list of "s3" "buckets" is retrieved then a lifecycle "s3" rule expires a "s3" "object" then versioning is configured on a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "bucket" is created then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is created
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "bucket" is deleted then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is deleted
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then the list of "s3" "buckets" is retrieved then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is initiated then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is created
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is completed then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is aborted then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: versioning is configured on a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When versioning is configured on a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is created then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is created
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is deleted then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is deleted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then the list of "s3" "buckets" is retrieved then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then versioning is configured on a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is initiated then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is completed then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is aborted then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is uploaded to a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is created then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is created
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is deleted then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is completed then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is created then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is created
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is deleted then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then versioning is configured on a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then objects in a "s3" "bucket" are listed then a "s3" "bucket" is created
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is initiated then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is completed then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a multipart "s3" "upload" is aborted then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is deleted from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "bucket" is created then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is created
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "bucket" is deleted then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is initiated then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is initiated
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is completed then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a multipart "s3" "upload" is aborted then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: "s3" "object" metadata is retrieved from a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "bucket" is created then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "bucket" is deleted then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "bucket" is deleted
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When the list of "s3" "buckets" is retrieved
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then versioning is configured on a "s3" "bucket" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When versioning is configured on a "s3" "bucket"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is uploaded to a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then "s3" "object" metadata is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a "s3" "object" is copied from one "s3" "bucket" to another then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is initiated then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is completed then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is aborted then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is aborted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: objects in a "s3" "bucket" are listed then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When objects in a "s3" "bucket" are listed
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is created then a part is uploaded for a multipart "s3" "upload"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is created
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "bucket" is deleted then a multipart "s3" "upload" is completed
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then the list of "s3" "buckets" is retrieved then a multipart "s3" "upload" is aborted
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When the list of "s3" "buckets" is retrieved
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then versioning is configured on a "s3" "bucket" then a lifecycle "s3" rule expires a "s3" "object"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When versioning is configured on a "s3" "bucket"
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is created
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "bucket" is deleted
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is deleted from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is deleted from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then "s3" "object" metadata is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then objects in a "s3" "bucket" are listed then a "s3" "object" is uploaded to a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is initiated then a "s3" "object" is retrieved from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is deleted from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is completed then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is completed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is aborted then objects in a "s3" "bucket" are listed
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is aborted
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a "s3" "object" is copied from one "s3" "bucket" to another then a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is initiated
    Given src_bname in bucket_status
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "bucket" is created then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "bucket" is deleted then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "bucket" is deleted
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then the list of "s3" "buckets" is retrieved then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When the list of "s3" "buckets" is retrieved
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then versioning is configured on a "s3" "bucket" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is retrieved from a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is deleted from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is deleted from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then objects in a "s3" "bucket" are listed then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a "s3" "object" is copied from one "s3" "bucket" to another then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a part is uploaded for a multipart "s3" "upload" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a part is uploaded for a multipart "s3" "upload"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is completed then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is completed
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is aborted then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is initiated then a lifecycle "s3" rule expires a "s3" "object" then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is initiated
    When a lifecycle "s3" rule expires a "s3" "object"
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is created then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is created
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "bucket" is deleted then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "bucket" is deleted
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then the list of "s3" "buckets" is retrieved then a "s3" "bucket" is created
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When the list of "s3" "buckets" is retrieved
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then versioning is configured on a "s3" "bucket" then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When versioning is configured on a "s3" "bucket"
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is uploaded to a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is retrieved from a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then objects in a "s3" "bucket" are listed then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a "s3" "object" is copied from one "s3" "bucket" to another then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is initiated then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is initiated
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is completed then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is aborted then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is aborted
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a part is uploaded for a multipart "s3" "upload" then a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a part is uploaded for a multipart "s3" "upload"
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "bucket" is created then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is created
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "bucket" is deleted then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is deleted
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then the list of "s3" "buckets" is retrieved then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When the list of "s3" "buckets" is retrieved
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then versioning is configured on a "s3" "bucket" then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When versioning is configured on a "s3" "bucket"
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is uploaded to a "s3" "bucket" then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is deleted from a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is deleted from a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then objects in a "s3" "bucket" are listed then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When objects in a "s3" "bucket" are listed
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a "s3" "object" is copied from one "s3" "bucket" to another then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a multipart "s3" "upload" is initiated then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a multipart "s3" "upload" is initiated
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a multipart "s3" "upload" is aborted then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a multipart "s3" "upload" is aborted
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is completed then a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a multipart "s3" "upload" is completed
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "bucket" is created then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is created
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "bucket" is deleted then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is deleted
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then the list of "s3" "buckets" is retrieved then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When the list of "s3" "buckets" is retrieved
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then versioning is configured on a "s3" "bucket" then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is retrieved from a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is deleted from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is deleted from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then "s3" "object" metadata is retrieved from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then objects in a "s3" "bucket" are listed then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When objects in a "s3" "bucket" are listed
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a "s3" "object" is copied from one "s3" "bucket" to another then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a multipart "s3" "upload" is initiated then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a multipart "s3" "upload" is initiated
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a multipart "s3" "upload" is completed then a lifecycle "s3" rule expires a "s3" "object"
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a multipart "s3" "upload" is completed
    When a lifecycle "s3" rule expires a "s3" "object"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a multipart "s3" "upload" is aborted then a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is created
    Given bname in bucket_status
    When a multipart "s3" "upload" is aborted
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is created then the list of "s3" "buckets" is retrieved
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is created
    When the list of "s3" "buckets" is retrieved
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "bucket" is deleted then versioning is configured on a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "bucket" is deleted
    When versioning is configured on a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then the list of "s3" "buckets" is retrieved then a "s3" "object" is uploaded to a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When the list of "s3" "buckets" is retrieved
    When a "s3" "object" is uploaded to a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then versioning is configured on a "s3" "bucket" then a "s3" "object" is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When versioning is configured on a "s3" "bucket"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is uploaded to a "s3" "bucket" then a "s3" "object" is deleted from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is uploaded to a "s3" "bucket"
    When a "s3" "object" is deleted from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is retrieved from a "s3" "bucket" then "s3" "object" metadata is retrieved from a "s3" "bucket"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is retrieved from a "s3" "bucket"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is deleted from a "s3" "bucket" then objects in a "s3" "bucket" are listed
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is deleted from a "s3" "bucket"
    When objects in a "s3" "bucket" are listed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then "s3" "object" metadata is retrieved from a "s3" "bucket" then a "s3" "object" is copied from one "s3" "bucket" to another
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When "s3" "object" metadata is retrieved from a "s3" "bucket"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then objects in a "s3" "bucket" are listed then a multipart "s3" "upload" is initiated
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When objects in a "s3" "bucket" are listed
    When a multipart "s3" "upload" is initiated
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a "s3" "object" is copied from one "s3" "bucket" to another then a part is uploaded for a multipart "s3" "upload"
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a "s3" "object" is copied from one "s3" "bucket" to another
    When a part is uploaded for a multipart "s3" "upload"
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is initiated then a multipart "s3" "upload" is completed
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is initiated
    When a multipart "s3" "upload" is completed
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a part is uploaded for a multipart "s3" "upload" then a multipart "s3" "upload" is aborted
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a part is uploaded for a multipart "s3" "upload"
    When a multipart "s3" "upload" is aborted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is completed then a "s3" "bucket" is created
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is completed
    When a "s3" "bucket" is created
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty

  @sequence
  Scenario: a lifecycle "s3" rule expires a "s3" "object" then a multipart "s3" "upload" is aborted then a "s3" "bucket" is deleted
    Given bname in bucket_status
    When a lifecycle "s3" rule expires a "s3" "object"
    When a multipart "s3" "upload" is aborted
    When a "s3" "bucket" is deleted
    And every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")
    And every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every "s3" "multipart upload" has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting an "s3" "bucket" requires it to be empty
