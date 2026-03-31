@elasticachesns @generated
Feature: ElasticacheSns - A Cluster Event Occurs But The Sns Notification Fails Because The "Sns" "Topic" Has Been Deleted

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has a "SNS" notification configured
    And the "sns" "topic" was "DELETED"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Then the "elasticache" "cluster" will be "MODIFYING" but no notification will be published
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted fails when the "elasticache" "cluster" did not exist or was "AVAILABLE"
    Given the "elasticache" "cluster" did not exist or was "AVAILABLE"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted fails when the "elasticache" "cluster" has no "SNS" notification configured
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has no "SNS" notification configured
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Then the operation is rejected

  @guard @negative @cluster_event_notification_fails @internal
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted fails when the "sns" "topic" was not "DELETED"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has a "SNS" notification configured
    And the "sns" "topic" was not "DELETED"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Then the operation is rejected
