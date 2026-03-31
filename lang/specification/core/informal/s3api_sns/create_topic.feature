@s3apisns @generated
Feature: S3apiSns - A "Sns" "Topic" Is Created

  # Generated from FizzBee spec: s3api_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingObject, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: a "sns" "topic" is created
    Given the topic did not already exist
    When a "sns" "topic" is created
    Then the "sns" "topic" will be "ACTIVE"
    And every "PUBLISHED" notification references an object that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @create_topic
  Scenario: a "sns" "topic" is created fails when the topic already existed
    Given the topic already existed
    When a "sns" "topic" is created
    Then the operation is rejected
