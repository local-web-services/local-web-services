@elasticachesns @generated
Feature: ElasticacheSns - Action Sequences

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "sns" "topic" is created
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "sns" "topic" is deleted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "elasticache" "cluster" modification completes
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "elasticache" "cluster" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification is configured on the "elasticache" "cluster"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "elasticache" "cluster" modification completes
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "elasticache" "cluster" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification is configured on the "elasticache" "cluster"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the "elasticache" "cluster" modification completes
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a "sns" "topic" is created
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "sns" "topic" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then the "sns" "topic" is deleted
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "sns" "topic" is deleted then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a "SNS" notification is configured on the "elasticache" "cluster" then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "elasticache" "cluster" modification completes
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: an "elasticache" "cluster" is created then the "elasticache" "cluster" modification completes then a "sns" "topic" is created
    Given cid not in cluster_status
    When an "elasticache" "cluster" is created
    When the "elasticache" "cluster" modification completes
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then an "elasticache" "cluster" is created then a "SNS" notification is configured on the "elasticache" "cluster"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When an "elasticache" "cluster" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification is configured on the "elasticache" "cluster" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "elasticache" "cluster" modification completes
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then an "elasticache" "cluster" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "elasticache" "cluster" modification completes then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "elasticache" "cluster" modification completes
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then an "elasticache" "cluster" is created then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When an "elasticache" "cluster" is created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification is configured on the "elasticache" "cluster" then the "elasticache" "cluster" modification completes
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then an "elasticache" "cluster" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the "elasticache" "cluster" modification completes then a "SNS" notification is configured on the "elasticache" "cluster"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the "elasticache" "cluster" modification completes
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then an "elasticache" "cluster" is created then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When an "elasticache" "cluster" is created
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a "sns" "topic" is created then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a "sns" "topic" is created
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then the "sns" "topic" is deleted then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "sns" "topic" is deleted
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a "sns" "topic" is created
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "elasticache" "cluster" then the "elasticache" "cluster" modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "elasticache" "cluster" modification completes
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then an "elasticache" "cluster" is created then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When an "elasticache" "cluster" is created
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a "sns" "topic" is created then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a "sns" "topic" is created
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "sns" "topic" is deleted then a "sns" "topic" is created
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a "SNS" notification is configured on the "elasticache" "cluster" then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "elasticache" "cluster" modification completes then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "elasticache" "cluster" modification completes
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then an "elasticache" "cluster" is created then a "sns" "topic" is created
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When an "elasticache" "cluster" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "sns" "topic" is deleted then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "SNS" notification is configured on the "elasticache" "cluster" then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then the "elasticache" "cluster" modification completes
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When the "elasticache" "cluster" modification completes
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then the "elasticache" "cluster" modification completes then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then an "elasticache" "cluster" is created then the "sns" "topic" is deleted
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When an "elasticache" "cluster" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "sns" "topic" is created then a "SNS" notification is configured on the "elasticache" "cluster"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "elasticache" "cluster"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then the "sns" "topic" is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When the "sns" "topic" is deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a "SNS" notification is configured on the "elasticache" "cluster" then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a "SNS" notification is configured on the "elasticache" "cluster"
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic" then an "elasticache" "cluster" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a cluster modification event occurs and ElastiCache publishes a notification to the "sns" "topic"
    When an "elasticache" "cluster" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "elasticache" "cluster" modification completes then a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted then a "sns" "topic" is created
    Given cid in cluster_status
    When the "elasticache" "cluster" modification completes
    When a cluster event occurs but the "SNS" notification fails because the "sns" "topic" has been deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" "sns" "notification" references a "elasticache" "cluster" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists
