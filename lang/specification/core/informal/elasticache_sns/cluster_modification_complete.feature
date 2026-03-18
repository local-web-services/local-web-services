@elasticachesns @generated
Feature: ElasticacheSns - The Cluster Modification Completes

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_complete @internal
  Scenario: the cluster modification completes
    Given the cluster is "MODIFYING"
    When the cluster modification completes
    Then the cluster is "AVAILABLE" again
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @cluster_modification_complete @internal
  Scenario: the cluster modification completes fails when the cluster is not "MODIFYING"
    Given the cluster is not "MODIFYING"
    When the cluster modification completes
    Then the operation is rejected
