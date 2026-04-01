@s3apisqs @generated
Feature: S3apiSqs - Action Sequences

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then a "sqs" "queue" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sqs" "queue" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then a "s3" "bucket" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then the "sqs" "queue" is deleted
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an "sqs" notification configuration is added to the "s3" "bucket"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then a "s3" "bucket" is created
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then a "sqs" "queue" is created
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an "sqs" notification configuration is added to the "s3" "bucket"
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then a "sqs" "queue" is created
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "sqs" "queue" is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "sqs" "queue" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "sqs" "queue" is created then the "sqs" "queue" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sqs" "queue" is created
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sqs" "queue" is deleted then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sqs" "queue" is deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "sqs" notification configuration is added to the "s3" "bucket" then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "sqs" "queue" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then a "s3" "bucket" is created then an "sqs" notification configuration is added to the "s3" "bucket"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When a "s3" "bucket" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then the "sqs" "queue" is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When the "sqs" "queue" is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an "sqs" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "s3" "bucket" is created
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: a "sqs" "queue" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then the "sqs" "queue" is deleted
    Given qid not in queue_status
    When a "sqs" "queue" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then a "s3" "bucket" is created then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When a "s3" "bucket" is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then a "sqs" "queue" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an "sqs" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "sqs" "queue" is created
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: the "sqs" "queue" is deleted then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an "sqs" notification configuration is added to the "s3" "bucket"
    Given qid in queue_status
    When the "sqs" "queue" is deleted
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then a "sqs" "queue" is created then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "sqs" "queue" is created
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then the "sqs" "queue" is deleted then a "sqs" "queue" is created
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When the "sqs" "queue" is deleted
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "sqs" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid in bucket_status
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "s3" "bucket" is created then a "sqs" "queue" is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "s3" "bucket" is created
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "sqs" "queue" is created then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "sqs" "queue" is created
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then the "sqs" "queue" is deleted then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When the "sqs" "queue" is deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then an "sqs" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "s3" "bucket" is created then the "sqs" "queue" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "s3" "bucket" is created
    When the "sqs" "queue" is deleted
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then a "sqs" "queue" is created then an "sqs" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When a "sqs" "queue" is created
    When an "sqs" notification configuration is added to the "s3" "bucket"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then the "sqs" "queue" is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When the "sqs" "queue" is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an "sqs" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an "sqs" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue" then a "sqs" "queue" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sqs" notification delivery fails because the "sqs" "queue" has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "sqs" "queue"
    When a "sqs" "queue" is created
    And every "QUEUED" "sqs" "message" references an "s3" "object" that exists
    And every "QUEUED" "sqs" "message" references an "sqs" "queue" that exists
