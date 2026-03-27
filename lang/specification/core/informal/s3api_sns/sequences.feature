@s3apisns @generated
Feature: S3apiSns - Action Sequences

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given the "SNS" topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an "SNS" notification configuration has been added to the bucket
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created
    Given bid not in bucket_status
    Given an S3 bucket has been created
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an S3 bucket is created then an "SNS" notification configuration is added to the bucket
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an S3 bucket has been created
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the "SNS" topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an "SNS" notification configuration has been added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an S3 bucket is created then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an S3 bucket has been created
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" topic has been created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" notification configuration has been added to the bucket
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an S3 bucket is created then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    Given an S3 bucket has been created
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an "SNS" topic is created then an S3 bucket is created
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    Given an "SNS" topic has been created
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then the "SNS" topic is deleted then an "SNS" topic is created
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    Given an "SNS" notification configuration has been added to the bucket
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an S3 bucket is created then an "SNS" topic is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    Given an S3 bucket has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    Given the "SNS" topic has been deleted
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" notification configuration is added to the bucket then an object is uploaded but notification delivery fails because the topic has been deleted
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    Given an "SNS" notification configuration has been added to the bucket
    When an object is uploaded but notification delivery fails because the topic has been deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded and S3 publishes a notification to the "SNS" topic then an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an S3 bucket is created then the "SNS" topic is deleted
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    Given an S3 bucket has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" topic is created then an "SNS" notification configuration is added to the bucket
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    Given an "SNS" topic has been created
    When an "SNS" notification configuration is added to the bucket
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then the "SNS" topic is deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    Given the "SNS" topic has been deleted
    When an object is uploaded and S3 publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an "SNS" notification configuration is added to the bucket then an S3 bucket is created
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    Given an "SNS" notification configuration has been added to the bucket
    When an S3 bucket is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an object is uploaded but notification delivery fails because the topic has been deleted then an object is uploaded and S3 publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given bid in bucket_status
    Given an object has been uploaded but notification delivery has failed because the topic has been deleted
    Given an object has been uploaded and S3 has published a notification to the "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists
