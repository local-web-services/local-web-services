@elasticachesns @generated
Feature: ElasticacheSns - A Cluster Modification Event Occurs And Elasticache Publishes A Notification To The Sns Topic

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given the cluster exists and is "AVAILABLE"
    And the cluster has an "SNS" notification configured
    And the topic is "ACTIVE"
    And a message slot is available
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then the cluster is "MODIFYING" and the notification is "PUBLISHED" to the topic
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic fails when the cluster does not exist or is not "AVAILABLE"
    Given the cluster does not exist or is not "AVAILABLE"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic fails when the cluster has no "SNS" notification configured
    Given the cluster exists and is "AVAILABLE"
    And the cluster has no "SNS" notification configured
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic fails when the topic is "DELETED"
    Given the cluster exists and is "AVAILABLE"
    And the cluster has an "SNS" notification configured
    And the topic is "DELETED"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic fails when no message slot is available
    Given the cluster exists and is "AVAILABLE"
    And the cluster has an "SNS" notification configured
    And the topic is "ACTIVE"
    And no message slot is available
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then the operation is rejected
