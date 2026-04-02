@elasticachesns @generated
Feature: ElasticacheSns - A Cluster Modification Event Occurs And Elasticache Publishes A Notification To The "Sns" "Topic"

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has a "SNS" notification configured
    And the "sns" "topic" was "ACTIVE"
    And a "sns" "message" "slot" was "available"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Then the "elasticache" "cluster" will be "MODIFYING" and the notification will be "PUBLISHED" to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" fails when the "elasticache" "cluster" did not exist or was "AVAILABLE"
    Given the "elasticache" "cluster" did not exist or was "AVAILABLE"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" fails when the "elasticache" "cluster" has no "SNS" notification configured
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has no "SNS" notification configured
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" fails when the "sns" "topic" was "DELETED"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has a "SNS" notification configured
    And the "sns" "topic" was "DELETED"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Then the operation is rejected

  @guard @negative @cluster_event_notification_delivered @internal
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" fails when no "sns" "message" "slot" was "available"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has a "SNS" notification configured
    And the "sns" "topic" was "ACTIVE"
    And no "sns" "message" "slot" was "available"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Then the operation is rejected
