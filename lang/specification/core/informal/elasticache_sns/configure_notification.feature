@elasticachesns @generated
Feature: ElasticacheSns - An Sns Notification Is Configured On The Elasticache Cluster

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an "SNS" notification is configured on the ElastiCache cluster
    Given the cluster exists and is "AVAILABLE"
    And the cluster has no "SNS" notification configured
    And the topic exists and is "ACTIVE"
    When an "SNS" notification is configured on the ElastiCache cluster
    Then the cluster will publish lifecycle events to the topic
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @configure_notification @lifecycle
  Scenario: an "SNS" notification is configured on the ElastiCache cluster fails when the cluster does not exist or is not "AVAILABLE"
    Given the cluster does not exist or is not "AVAILABLE"
    When an "SNS" notification is configured on the ElastiCache cluster
    Then the operation is rejected

  @standard @negative @configure_notification
  Scenario: an "SNS" notification is configured on the ElastiCache cluster fails when the cluster already has an "SNS" notification configured
    Given the cluster exists and is "AVAILABLE"
    And the cluster already has an "SNS" notification configured
    When an "SNS" notification is configured on the ElastiCache cluster
    Then the operation is rejected

  @standard @negative @configure_notification
  Scenario: an "SNS" notification is configured on the ElastiCache cluster fails when the topic does not exist or is not "ACTIVE"
    Given the cluster exists and is "AVAILABLE"
    And the cluster has no "SNS" notification configured
    And the topic does not exist or is not "ACTIVE"
    When an "SNS" notification is configured on the ElastiCache cluster
    Then the operation is rejected
