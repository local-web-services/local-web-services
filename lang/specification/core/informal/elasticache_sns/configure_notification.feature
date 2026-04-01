@elasticachesns @generated
Feature: ElasticacheSns - A Sns Notification Is Configured On The "Elasticache" "Cluster"

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has no "SNS" notification configured
    And the "sns" "topic" existed and was "ACTIVE"
    When a "SNS" notification is configured on the "elasticache" "cluster"
    Then the "elasticache" "cluster" will publish lifecycle events to the "sns" "topic"
    And every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @configure_notification @lifecycle
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" fails when the "elasticache" "cluster" did not exist or was "AVAILABLE"
    Given the "elasticache" "cluster" did not exist or was "AVAILABLE"
    When a "SNS" notification is configured on the "elasticache" "cluster"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" fails when the "elasticache" "cluster" already has a "SNS" notification configured
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" already has a "SNS" notification configured
    When a "SNS" notification is configured on the "elasticache" "cluster"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" fails when the "sns" "topic" did not exist or was "ACTIVE"
    Given the "elasticache" "cluster" existed and was "AVAILABLE"
    And the "elasticache" "cluster" has no "SNS" notification configured
    And the "sns" "topic" did not exist or was "ACTIVE"
    When a "SNS" notification is configured on the "elasticache" "cluster"
    Then the operation is rejected
