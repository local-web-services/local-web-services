@elasticachesns @generated
Feature: ElasticacheSns - The "Elasticache" "Cluster" Modification Completes

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_modification_complete @internal
  Scenario: the "elasticache" "cluster" modification completes
    Given the "elasticache" "cluster" was "MODIFYING"
    When the "elasticache" "cluster" modification completes
    Then the "elasticache" "cluster" will be "AVAILABLE" again
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @cluster_modification_complete @internal
  Scenario: the "elasticache" "cluster" modification completes fails when the "elasticache" "cluster" was not "MODIFYING"
    Given the "elasticache" "cluster" was not "MODIFYING"
    When the "elasticache" "cluster" modification completes
    Then the operation is rejected
