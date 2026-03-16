@s3apisns @generated
Feature: S3apiSns - Action Sequences

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted then an "SNS" topic is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an S3 bucket is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When an "SNS" topic is created
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an S3 bucket is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an S3 bucket is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an S3 bucket is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created then an "SNS" topic is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created then an S3 bucket is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted then an S3 bucket is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an S3 bucket is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" topic is created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When the "SNS" topic is deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an S3 bucket is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    When an object is uploaded but notification delivery fails because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists
