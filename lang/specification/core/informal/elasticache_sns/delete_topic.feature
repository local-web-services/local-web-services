@elasticachesns @generated
Feature: ElasticacheSns - The Sns Topic Is Deleted

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @delete_topic
  Scenario: the "SNS" topic is deleted
    Given the topic exists
    And the topic is "ACTIVE"
    When the "SNS" topic is deleted
    Then the topic is "DELETED" and ElastiCache event notifications will fail
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @delete_topic
  Scenario: the "SNS" topic is deleted fails when the topic does not exist
    Given the topic does not exist
    When the "SNS" topic is deleted
    Then the operation is rejected

  @standard @negative @delete_topic @lifecycle @internal
  Scenario: the "SNS" topic is deleted fails when the topic is already "DELETED"
    Given the topic exists
    And the topic is already "DELETED"
    When the "SNS" topic is deleted
    Then the operation is rejected
