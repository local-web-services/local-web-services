@elasticachesns @generated
Feature: ElasticacheSns - An Sns Topic Is Created

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_topic
  Scenario: an "SNS" topic is created
    Given the topic does not already exist
    When an "SNS" topic is created
    Then the topic is "ACTIVE"
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @create_topic
  Scenario: an "SNS" topic is created fails when the topic already exists
    Given the topic already exists
    When an "SNS" topic is created
    Then the operation is rejected
