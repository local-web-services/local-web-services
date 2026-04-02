@s3apisns @generated
Feature: S3apiSns - Action Sequences

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "s3" "bucket" is created then a "sns" "topic" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sns" "topic" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "s3" "bucket" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" notification configuration is added to the "s3" "bucket"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "s3" "bucket" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" notification configuration is added to the "s3" "bucket"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then a "sns" "topic" is created
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then the "sns" "topic" is deleted
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sns" "topic" is deleted then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "sns" notification configuration is added to the "s3" "bucket" then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "s3" "bucket" is created then a "sns" notification configuration is added to the "s3" "bucket"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "sns" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" notification configuration is added to the "s3" "bucket"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then a "sns" "topic" is created then a "s3" "bucket" is created
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then the "sns" "topic" is deleted then a "sns" "topic" is created
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: a "sns" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" notification configuration is added to the "s3" "bucket" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" notification configuration is added to the "s3" "bucket"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "s3" "bucket" is created then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" "topic" is created then a "sns" notification configuration is added to the "s3" "bucket"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    When a "sns" notification configuration is added to the "s3" "bucket"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then a "sns" notification configuration is added to the "s3" "bucket" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When a "sns" notification configuration is added to the "s3" "bucket"
    When a "s3" "bucket" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists

  @sequence
  Scenario: an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given bid in bucket_status
    When an "s3" "object" is uploaded but "sns" notification delivery fails because the "sns" "topic" has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" notification references an "s3" "object" that exists
    And every "PUBLISHED" "sns" notification references an "sns" "topic" that exists
