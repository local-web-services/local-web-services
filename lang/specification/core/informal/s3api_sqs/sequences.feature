@s3apisqs @generated
Feature: S3apiSqs - Action Sequences

  # Generated from FizzBee spec: s3api_sqs.fizz
  # Safety invariants: QueuedMessageReferencesExistingObject, QueuedMessageReferencesExistingQueue

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SQS" queue is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SQS" queue is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SQS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an S3 bucket is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is deleted
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" notification configuration is added to the bucket
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an object is uploaded but notification delivery fails because the queue has been deleted
    Given qid not in queue_status
    When an "SQS" queue is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an S3 bucket is created
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an "SQS" queue is created
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an "SQS" notification configuration is added to the bucket
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an object is uploaded but notification delivery fails because the queue has been deleted
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an "SQS" queue is created
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then the "SQS" queue is deleted
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" queue is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then the "SQS" queue is deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" queue is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then the "SQS" queue is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SQS" queue is created then the "SQS" queue is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SQS" queue is created
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SQS" queue is deleted then an "SQS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SQS" queue is deleted
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SQS" notification configuration is added to the bucket then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" queue is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an S3 bucket is created then an "SQS" notification configuration is added to the bucket
    Given qid not in queue_status
    When an "SQS" queue is created
    When an S3 bucket is created
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then the "SQS" queue is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given qid not in queue_status
    When an "SQS" queue is created
    When the "SQS" queue is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an "SQS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the queue has been deleted
    Given qid not in queue_status
    When an "SQS" queue is created
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an S3 bucket is created
    Given qid not in queue_status
    When an "SQS" queue is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" queue is created then an object is uploaded but notification delivery fails because the queue has been deleted then the "SQS" queue is deleted
    Given qid not in queue_status
    When an "SQS" queue is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an S3 bucket is created then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an S3 bucket is created
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an "SQS" queue is created then an object is uploaded but notification delivery fails because the queue has been deleted
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an "SQS" queue is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an "SQS" notification configuration is added to the bucket then an S3 bucket is created
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an "SQS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" queue is created
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: the "SQS" queue is deleted then an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" notification configuration is added to the bucket
    Given qid in queue_status
    When the "SQS" queue is deleted
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an S3 bucket is created then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an "SQS" queue is created then an S3 bucket is created
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an "SQS" queue is created
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then the "SQS" queue is deleted then an "SQS" queue is created
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When the "SQS" queue is deleted
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then the "SQS" queue is deleted
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an "SQS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the queue has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid in bucket_status
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an S3 bucket is created then an "SQS" queue is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an S3 bucket is created
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" queue is created then the "SQS" queue is deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" queue is created
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then the "SQS" queue is deleted then an "SQS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When the "SQS" queue is deleted
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the queue has been deleted
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the queue has been deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an object is uploaded but notification delivery fails because the queue has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an S3 bucket is created then the "SQS" queue is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an S3 bucket is created
    When the "SQS" queue is deleted
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" queue is created then an "SQS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" queue is created
    When an "SQS" notification configuration is added to the bucket
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then the "SQS" queue is deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When the "SQS" queue is deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an "SQS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an "SQS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the queue has been deleted then an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue then an "SQS" queue is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the queue has been deleted
    When an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue
    When an "SQS" queue is created
    And every "QUEUED" message references an object that exists
    And every "QUEUED" message references a queue that exists
