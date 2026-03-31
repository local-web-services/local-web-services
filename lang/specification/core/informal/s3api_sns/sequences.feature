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
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sns" "topic" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "s3" "bucket" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "s3" "bucket" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then a "s3" "bucket" is created
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then a "sns" "topic" is created
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then the "sns" "topic" is deleted
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then the "sns" "topic" is deleted then a "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then a "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic" then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "s3" "bucket" is created then an object is uploaded but notification delivery fails because the topic has been deleted then a "sns" "topic" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "s3" "bucket" is created then a "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "sns" "topic" is created then an object is uploaded but notification delivery fails because the topic has been deleted then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "s3" "bucket" is created then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "s3" "bucket" is created
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification configuration is added to the bucket then a "s3" "bucket" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification configuration is added to the bucket
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then a "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then a "s3" "bucket" is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When a "s3" "bucket" is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then a "sns" "topic" is created then a "s3" "bucket" is created
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When a "sns" "topic" is created
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then the "sns" "topic" is deleted then a "sns" "topic" is created
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: a "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "s3" "bucket" is created then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "s3" "bucket" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted then a "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "sns" "topic" then an object is uploaded but notification delivery fails because the topic has been deleted then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "s3" "bucket" is created then the "sns" "topic" is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "s3" "bucket" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "sns" "topic" is created then a "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "sns" "topic" is created
    When a "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "sns" "topic" is deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic"
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "sns" "topic" is deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then a "SNS" notification configuration is added to the bucket then a "s3" "bucket" is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When a "SNS" notification configuration is added to the bucket
    When a "s3" "bucket" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists
