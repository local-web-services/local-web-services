@s3api @generated
Feature: S3api - Action Sequences

  # Generated from FizzBee spec: s3api.fizz
  # Safety invariants: BucketStatusValid, VersioningStateValid, MultipartUploadStatusValid, DeleteBucketRequiresEmpty

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a bucket is created then a bucket is deleted
    Given bname not in bucket_status
    Given a bucket has been created
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then the list of buckets is retrieved
    Given bname not in bucket_status
    Given a bucket has been created
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then versioning is configured on a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is uploaded to a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is retrieved from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is deleted from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then object metadata is retrieved from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then objects in a bucket are listed
    Given bname not in bucket_status
    Given a bucket has been created
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is copied from one bucket to another
    Given bname not in bucket_status
    Given a bucket has been created
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is initiated
    Given bname not in bucket_status
    Given a bucket has been created
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a part is uploaded for a multipart upload
    Given bname not in bucket_status
    Given a bucket has been created
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is completed
    Given bname not in bucket_status
    Given a bucket has been created
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is aborted
    Given bname not in bucket_status
    Given a bucket has been created
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a lifecycle rule expires an object
    Given bname not in bucket_status
    Given a bucket has been created
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a bucket is created
    Given bname in bucket_status
    Given a bucket has been deleted
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then the list of buckets is retrieved
    Given bname in bucket_status
    Given a bucket has been deleted
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then versioning is configured on a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is deleted from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then objects in a bucket are listed
    Given bname in bucket_status
    Given a bucket has been deleted
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a bucket has been deleted
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is initiated
    Given bname in bucket_status
    Given a bucket has been deleted
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a bucket has been deleted
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is completed
    Given bname in bucket_status
    Given a bucket has been deleted
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is aborted
    Given bname in bucket_status
    Given a bucket has been deleted
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a bucket has been deleted
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a bucket is created
    Given the list of buckets has been retrieved
    Given bname not in bucket_status
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a bucket is deleted
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then versioning is configured on a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is uploaded to a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is retrieved from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is deleted from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then object metadata is retrieved from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then objects in a bucket are listed
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is copied from one bucket to another
    Given the list of buckets has been retrieved
    Given src_bname in bucket_status
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is initiated
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a part is uploaded for a multipart upload
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is completed
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is aborted
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a lifecycle rule expires an object
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a bucket is created
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a bucket is deleted
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a bucket is created
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a bucket is deleted
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a bucket is created
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a bucket is deleted
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a bucket is created
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a bucket is deleted
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a bucket is created
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a bucket is deleted
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a bucket is created
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a bucket is deleted
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then the list of buckets is retrieved
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then versioning is configured on a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is uploaded to a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is retrieved from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is deleted from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is copied from one bucket to another
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is initiated
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is completed
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is aborted
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a lifecycle rule expires an object
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a bucket is created
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a bucket is deleted
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then the list of buckets is retrieved
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then versioning is configured on a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is uploaded to a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is retrieved from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is deleted from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then object metadata is retrieved from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then objects in a bucket are listed
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is initiated
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a part is uploaded for a multipart upload
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is completed
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is aborted
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a lifecycle rule expires an object
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a multipart upload is completed
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a multipart upload is aborted
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a bucket is created
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a bucket is deleted
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then the list of buckets is retrieved
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then versioning is configured on a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is deleted from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then objects in a bucket are listed
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been completed
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been completed
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been completed
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a bucket is created
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a bucket is deleted
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then the list of buckets is retrieved
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then versioning is configured on a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is deleted from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then objects in a bucket are listed
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is initiated
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is completed
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is aborted
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a bucket is deleted then the list of buckets is retrieved
    Given bname not in bucket_status
    Given a bucket has been created
    Given a bucket has been deleted
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then the list of buckets is retrieved then versioning is configured on a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    Given the list of buckets has been retrieved
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then versioning is configured on a bucket then an object is uploaded to a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    Given versioning has been configured on a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is uploaded to a bucket then an object is retrieved from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    Given an object has been uploaded to a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is retrieved from a bucket then an object is deleted from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    Given an object has been retrieved from a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is deleted from a bucket then object metadata is retrieved from a bucket
    Given bname not in bucket_status
    Given a bucket has been created
    Given an object has been deleted from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then object metadata is retrieved from a bucket then objects in a bucket are listed
    Given bname not in bucket_status
    Given a bucket has been created
    Given object metadata has been retrieved from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then objects in a bucket are listed then an object is copied from one bucket to another
    Given bname not in bucket_status
    Given a bucket has been created
    Given objects in a bucket have been listed
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then an object is copied from one bucket to another then a multipart upload is initiated
    Given bname not in bucket_status
    Given a bucket has been created
    Given an object has been copied from one bucket to another
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is initiated then a part is uploaded for a multipart upload
    Given bname not in bucket_status
    Given a bucket has been created
    Given a multipart upload has been initiated
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a part is uploaded for a multipart upload then a multipart upload is completed
    Given bname not in bucket_status
    Given a bucket has been created
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is completed then a multipart upload is aborted
    Given bname not in bucket_status
    Given a bucket has been created
    Given a multipart upload has been completed
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a multipart upload is aborted then a lifecycle rule expires an object
    Given bname not in bucket_status
    Given a bucket has been created
    Given a multipart upload has been aborted
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is created then a lifecycle rule expires an object then a bucket is deleted
    Given bname not in bucket_status
    Given a bucket has been created
    Given a lifecycle rule has expired an object
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a bucket is created then versioning is configured on a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a bucket has been created
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then the list of buckets is retrieved then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    Given the list of buckets has been retrieved
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then versioning is configured on a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    Given versioning has been configured on a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is uploaded to a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    Given an object has been uploaded to a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is retrieved from a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a bucket has been deleted
    Given an object has been retrieved from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is deleted from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given a bucket has been deleted
    Given an object has been deleted from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then object metadata is retrieved from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a bucket has been deleted
    Given object metadata has been retrieved from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then objects in a bucket are listed then a multipart upload is initiated
    Given bname in bucket_status
    Given a bucket has been deleted
    Given objects in a bucket have been listed
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then an object is copied from one bucket to another then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a bucket has been deleted
    Given an object has been copied from one bucket to another
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is initiated then a multipart upload is completed
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a multipart upload has been initiated
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is completed then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a multipart upload has been completed
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a multipart upload is aborted then a bucket is created
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a multipart upload has been aborted
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a bucket is deleted then a lifecycle rule expires an object then the list of buckets is retrieved
    Given bname in bucket_status
    Given a bucket has been deleted
    Given a lifecycle rule has expired an object
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a bucket is created then an object is uploaded to a bucket
    Given the list of buckets has been retrieved
    Given bname not in bucket_status
    Given a bucket has been created
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a bucket is deleted then an object is retrieved from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a bucket has been deleted
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then versioning is configured on a bucket then an object is deleted from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is uploaded to a bucket then object metadata is retrieved from a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is retrieved from a bucket then objects in a bucket are listed
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is deleted from a bucket then an object is copied from one bucket to another
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then object metadata is retrieved from a bucket then a multipart upload is initiated
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then objects in a bucket are listed then a part is uploaded for a multipart upload
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given objects in a bucket have been listed
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then an object is copied from one bucket to another then a multipart upload is completed
    Given the list of buckets has been retrieved
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is initiated then a multipart upload is aborted
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a multipart upload has been initiated
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a part is uploaded for a multipart upload then a lifecycle rule expires an object
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is completed then a bucket is created
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a multipart upload has been completed
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a multipart upload is aborted then a bucket is deleted
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a multipart upload has been aborted
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: the list of buckets is retrieved then a lifecycle rule expires an object then versioning is configured on a bucket
    Given the list of buckets has been retrieved
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a bucket is created then an object is retrieved from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a bucket has been created
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a bucket is deleted then an object is deleted from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a bucket has been deleted
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then the list of buckets is retrieved then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given the list of buckets has been retrieved
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is uploaded to a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given an object has been uploaded to a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is retrieved from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given an object has been retrieved from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is deleted from a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given an object has been deleted from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then object metadata is retrieved from a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given object metadata has been retrieved from a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then objects in a bucket are listed then a multipart upload is completed
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given objects in a bucket have been listed
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then an object is copied from one bucket to another then a multipart upload is aborted
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given an object has been copied from one bucket to another
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is initiated then a lifecycle rule expires an object
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a multipart upload has been initiated
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a part is uploaded for a multipart upload then a bucket is created
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a part has been uploaded for a multipart upload
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is completed then a bucket is deleted
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a multipart upload has been completed
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a multipart upload is aborted then the list of buckets is retrieved
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a multipart upload has been aborted
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: versioning is configured on a bucket then a lifecycle rule expires an object then an object is uploaded to a bucket
    Given bname in bucket_status
    Given versioning has been configured on a bucket
    Given a lifecycle rule has expired an object
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a bucket is created then an object is deleted from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a bucket has been created
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a bucket is deleted then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a bucket has been deleted
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then the list of buckets is retrieved then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given the list of buckets has been retrieved
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then versioning is configured on a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given versioning has been configured on a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is retrieved from a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given an object has been retrieved from a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is deleted from a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given an object has been deleted from a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then object metadata is retrieved from a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given object metadata has been retrieved from a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then objects in a bucket are listed then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given objects in a bucket have been listed
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then an object is copied from one bucket to another then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given an object has been copied from one bucket to another
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is initiated then a bucket is created
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a multipart upload has been initiated
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a part is uploaded for a multipart upload then a bucket is deleted
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a part has been uploaded for a multipart upload
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is completed then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a multipart upload has been completed
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a multipart upload is aborted then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a multipart upload has been aborted
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is uploaded to a bucket then a lifecycle rule expires an object then an object is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been uploaded to a bucket
    Given a lifecycle rule has expired an object
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a bucket is created then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a bucket has been created
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a bucket is deleted then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a bucket has been deleted
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then the list of buckets is retrieved then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given the list of buckets has been retrieved
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then versioning is configured on a bucket then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given versioning has been configured on a bucket
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is uploaded to a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given an object has been uploaded to a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is deleted from a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given an object has been deleted from a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then object metadata is retrieved from a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given object metadata has been retrieved from a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then objects in a bucket are listed then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given objects in a bucket have been listed
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then an object is copied from one bucket to another then a bucket is created
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given an object has been copied from one bucket to another
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is initiated then a bucket is deleted
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a multipart upload has been initiated
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a part is uploaded for a multipart upload then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a part has been uploaded for a multipart upload
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is completed then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a multipart upload has been completed
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a multipart upload is aborted then an object is uploaded to a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a multipart upload has been aborted
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is retrieved from a bucket then a lifecycle rule expires an object then an object is deleted from a bucket
    Given bname in bucket_status
    Given an object has been retrieved from a bucket
    Given a lifecycle rule has expired an object
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a bucket is created then objects in a bucket are listed
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a bucket has been created
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a bucket is deleted then an object is copied from one bucket to another
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a bucket has been deleted
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then the list of buckets is retrieved then a multipart upload is initiated
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given the list of buckets has been retrieved
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then versioning is configured on a bucket then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given versioning has been configured on a bucket
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is uploaded to a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given an object has been uploaded to a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is retrieved from a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given an object has been retrieved from a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then object metadata is retrieved from a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given object metadata has been retrieved from a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then objects in a bucket are listed then a bucket is created
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given objects in a bucket have been listed
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then an object is copied from one bucket to another then a bucket is deleted
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given an object has been copied from one bucket to another
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is initiated then the list of buckets is retrieved
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a multipart upload has been initiated
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a part is uploaded for a multipart upload then versioning is configured on a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a part has been uploaded for a multipart upload
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is completed then an object is uploaded to a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a multipart upload has been completed
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a multipart upload is aborted then an object is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a multipart upload has been aborted
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is deleted from a bucket then a lifecycle rule expires an object then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given an object has been deleted from a bucket
    Given a lifecycle rule has expired an object
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a bucket is created then an object is copied from one bucket to another
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a bucket has been created
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a bucket is deleted then a multipart upload is initiated
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a bucket has been deleted
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then the list of buckets is retrieved then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given the list of buckets has been retrieved
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then versioning is configured on a bucket then a multipart upload is completed
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given versioning has been configured on a bucket
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is uploaded to a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given an object has been uploaded to a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is retrieved from a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given an object has been retrieved from a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is deleted from a bucket then a bucket is created
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given an object has been deleted from a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then objects in a bucket are listed then a bucket is deleted
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given objects in a bucket have been listed
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then an object is copied from one bucket to another then the list of buckets is retrieved
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given an object has been copied from one bucket to another
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is initiated then versioning is configured on a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a multipart upload has been initiated
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a part is uploaded for a multipart upload then an object is uploaded to a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a part has been uploaded for a multipart upload
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is completed then an object is retrieved from a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a multipart upload has been completed
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a multipart upload is aborted then an object is deleted from a bucket
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a multipart upload has been aborted
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: object metadata is retrieved from a bucket then a lifecycle rule expires an object then objects in a bucket are listed
    Given bname in bucket_status
    Given object metadata has been retrieved from a bucket
    Given a lifecycle rule has expired an object
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a bucket is created then a multipart upload is initiated
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a bucket has been created
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a bucket is deleted then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a bucket has been deleted
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then the list of buckets is retrieved then a multipart upload is completed
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given the list of buckets has been retrieved
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then versioning is configured on a bucket then a multipart upload is aborted
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given versioning has been configured on a bucket
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is uploaded to a bucket then a lifecycle rule expires an object
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given an object has been uploaded to a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is retrieved from a bucket then a bucket is created
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given an object has been retrieved from a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is deleted from a bucket then a bucket is deleted
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given an object has been deleted from a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then object metadata is retrieved from a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given object metadata has been retrieved from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then an object is copied from one bucket to another then versioning is configured on a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given an object has been copied from one bucket to another
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is initiated then an object is uploaded to a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a multipart upload has been initiated
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a part is uploaded for a multipart upload then an object is retrieved from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a part has been uploaded for a multipart upload
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is completed then an object is deleted from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a multipart upload has been completed
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a multipart upload is aborted then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a multipart upload has been aborted
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: objects in a bucket are listed then a lifecycle rule expires an object then an object is copied from one bucket to another
    Given bname in bucket_status
    Given objects in a bucket have been listed
    Given a lifecycle rule has expired an object
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a bucket is created then a part is uploaded for a multipart upload
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a bucket has been created
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a bucket is deleted then a multipart upload is completed
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a bucket has been deleted
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then the list of buckets is retrieved then a multipart upload is aborted
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given the list of buckets has been retrieved
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then versioning is configured on a bucket then a lifecycle rule expires an object
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given versioning has been configured on a bucket
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is uploaded to a bucket then a bucket is created
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given an object has been uploaded to a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is retrieved from a bucket then a bucket is deleted
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given an object has been retrieved from a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then an object is deleted from a bucket then the list of buckets is retrieved
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given an object has been deleted from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then object metadata is retrieved from a bucket then versioning is configured on a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given object metadata has been retrieved from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then objects in a bucket are listed then an object is uploaded to a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given objects in a bucket have been listed
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is initiated then an object is retrieved from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a multipart upload has been initiated
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a part is uploaded for a multipart upload then an object is deleted from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a part has been uploaded for a multipart upload
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is completed then object metadata is retrieved from a bucket
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a multipart upload has been completed
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a multipart upload is aborted then objects in a bucket are listed
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a multipart upload has been aborted
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: an object is copied from one bucket to another then a lifecycle rule expires an object then a multipart upload is initiated
    Given src_bname in bucket_status
    Given an object has been copied from one bucket to another
    Given a lifecycle rule has expired an object
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a bucket is created then a multipart upload is completed
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a bucket has been created
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a bucket is deleted then a multipart upload is aborted
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a bucket has been deleted
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then the list of buckets is retrieved then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given the list of buckets has been retrieved
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then versioning is configured on a bucket then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given versioning has been configured on a bucket
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is uploaded to a bucket then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given an object has been uploaded to a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is retrieved from a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given an object has been retrieved from a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is deleted from a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given an object has been deleted from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then object metadata is retrieved from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given object metadata has been retrieved from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then objects in a bucket are listed then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given objects in a bucket have been listed
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then an object is copied from one bucket to another then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given an object has been copied from one bucket to another
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a part is uploaded for a multipart upload then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a part has been uploaded for a multipart upload
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a multipart upload is completed then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a multipart upload has been completed
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a multipart upload is aborted then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a multipart upload has been aborted
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is initiated then a lifecycle rule expires an object then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been initiated
    Given a lifecycle rule has expired an object
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a bucket is created then a multipart upload is aborted
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a bucket has been created
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a bucket is deleted then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a bucket has been deleted
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then the list of buckets is retrieved then a bucket is created
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given the list of buckets has been retrieved
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then versioning is configured on a bucket then a bucket is deleted
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given versioning has been configured on a bucket
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is uploaded to a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given an object has been uploaded to a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is retrieved from a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given an object has been retrieved from a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is deleted from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given an object has been deleted from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then object metadata is retrieved from a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given object metadata has been retrieved from a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then objects in a bucket are listed then an object is deleted from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given objects in a bucket have been listed
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an object is copied from one bucket to another then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given an object has been copied from one bucket to another
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated then objects in a bucket are listed
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been initiated
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been completed
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted then a multipart upload is initiated
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been aborted
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a lifecycle rule expires an object then a multipart upload is completed
    Given bname in bucket_status
    Given a part has been uploaded for a multipart upload
    Given a lifecycle rule has expired an object
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a bucket is created then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a bucket has been created
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a bucket is deleted then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a bucket has been deleted
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then the list of buckets is retrieved then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given the list of buckets has been retrieved
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then versioning is configured on a bucket then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given versioning has been configured on a bucket
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is uploaded to a bucket then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given an object has been uploaded to a bucket
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is retrieved from a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given an object has been retrieved from a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is deleted from a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given an object has been deleted from a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then object metadata is retrieved from a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given object metadata has been retrieved from a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then objects in a bucket are listed then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given objects in a bucket have been listed
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an object is copied from one bucket to another then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given an object has been copied from one bucket to another
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a multipart upload has been initiated
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload then a multipart upload is initiated
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a part has been uploaded for a multipart upload
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a multipart upload has been aborted
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a lifecycle rule expires an object then a multipart upload is aborted
    Given bname in bucket_status
    Given a multipart upload has been completed
    Given a lifecycle rule has expired an object
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a bucket is created then a bucket is deleted
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a bucket has been created
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a bucket is deleted then the list of buckets is retrieved
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a bucket has been deleted
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then the list of buckets is retrieved then versioning is configured on a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given the list of buckets has been retrieved
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then versioning is configured on a bucket then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given versioning has been configured on a bucket
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is uploaded to a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given an object has been uploaded to a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is retrieved from a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given an object has been retrieved from a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is deleted from a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given an object has been deleted from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then object metadata is retrieved from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given object metadata has been retrieved from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then objects in a bucket are listed then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given objects in a bucket have been listed
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an object is copied from one bucket to another then a multipart upload is initiated
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given an object has been copied from one bucket to another
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a multipart upload has been initiated
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload then a multipart upload is completed
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed then a lifecycle rule expires an object
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a multipart upload has been completed
    When a lifecycle rule expires an object
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a lifecycle rule expires an object then a bucket is created
    Given bname in bucket_status
    Given a multipart upload has been aborted
    Given a lifecycle rule has expired an object
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a bucket is created then the list of buckets is retrieved
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a bucket has been created
    When the list of buckets is retrieved
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a bucket is deleted then versioning is configured on a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a bucket has been deleted
    When versioning is configured on a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then the list of buckets is retrieved then an object is uploaded to a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given the list of buckets has been retrieved
    When an object is uploaded to a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then versioning is configured on a bucket then an object is retrieved from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given versioning has been configured on a bucket
    When an object is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is uploaded to a bucket then an object is deleted from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given an object has been uploaded to a bucket
    When an object is deleted from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is retrieved from a bucket then object metadata is retrieved from a bucket
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given an object has been retrieved from a bucket
    When object metadata is retrieved from a bucket
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is deleted from a bucket then objects in a bucket are listed
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given an object has been deleted from a bucket
    When objects in a bucket are listed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then object metadata is retrieved from a bucket then an object is copied from one bucket to another
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given object metadata has been retrieved from a bucket
    When an object is copied from one bucket to another
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then objects in a bucket are listed then a multipart upload is initiated
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given objects in a bucket have been listed
    When a multipart upload is initiated
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then an object is copied from one bucket to another then a part is uploaded for a multipart upload
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given an object has been copied from one bucket to another
    When a part is uploaded for a multipart upload
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is initiated then a multipart upload is completed
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a multipart upload has been initiated
    When a multipart upload is completed
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is completed then a bucket is created
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a multipart upload has been completed
    When a bucket is created
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty

  @exhaustive @sequence
  Scenario: a lifecycle rule expires an object then a multipart upload is aborted then a bucket is deleted
    Given bname in bucket_status
    Given a lifecycle rule has expired an object
    Given a multipart upload has been aborted
    When a bucket is deleted
    Then every bucket has a valid status ("ACTIVE" or "DELETED")
    And every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")
    And every multipart upload has a valid status ("IN_PROGRESS", "COMPLETED", or "ABORTED")
    And deleting a bucket requires it to be empty
