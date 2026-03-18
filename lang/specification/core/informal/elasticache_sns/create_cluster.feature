@elasticachesns @generated
Feature: ElasticacheSns - An Elasticache Cluster Is Created

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an ElastiCache cluster is created
    Given the cluster does not already exist
    When an ElastiCache cluster is created
    Then the cluster is "AVAILABLE" with no "SNS" notification configured
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @create_cluster
  Scenario: an ElastiCache cluster is created fails when the cluster already exists
    Given the cluster already exists
    When an ElastiCache cluster is created
    Then the operation is rejected
