@elasticachesns @generated
Feature: ElasticacheSns - A Cluster Event Occurs But The Sns Notification Fails Because The Topic Has Been Deleted

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given the cluster exists and is "AVAILABLE"
    And the cluster has an "SNS" notification configured
    And the topic is "DELETED"
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then the cluster is "MODIFYING" but no notification is published
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted fails when the cluster does not exist or is not "AVAILABLE"
    Given the cluster does not exist or is not "AVAILABLE"
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then the operation is rejected

  @standard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted fails when the cluster has no "SNS" notification configured
    Given the cluster exists and is "AVAILABLE"
    And the cluster has no "SNS" notification configured
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then the operation is rejected

  @standard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted fails when the topic is not "DELETED"
    Given the cluster exists and is "AVAILABLE"
    And the cluster has an "SNS" notification configured
    And the topic is not "DELETED"
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then the operation is rejected
