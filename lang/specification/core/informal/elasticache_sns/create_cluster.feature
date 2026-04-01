@elasticachesns @generated
Feature: ElasticacheSns - An "Elasticache" "Cluster" Is Created

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_cluster
  Scenario: an "elasticache" "cluster" is created
    Given the "elasticache" "cluster" did not already exist
    When an "elasticache" "cluster" is created
    Then the "elasticache" "cluster" will be "AVAILABLE" with no "SNS" notification configured
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @create_cluster
  Scenario: an "elasticache" "cluster" is created fails when the "elasticache" "cluster" already existed
    Given the "elasticache" "cluster" already existed
    When an "elasticache" "cluster" is created
    Then the operation is rejected
