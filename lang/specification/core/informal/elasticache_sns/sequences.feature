@elasticachesns @generated
Feature: ElasticacheSns - Action Sequences

  # Generated from FizzBee spec: elasticache_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingCluster, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then an "SNS" topic is created
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the "SNS" topic is deleted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then an "SNS" notification is configured on the ElastiCache cluster
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the cluster modification completes
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an ElastiCache cluster is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the ElastiCache cluster
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the cluster modification completes
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an ElastiCache cluster is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the ElastiCache cluster
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the cluster modification completes
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then an ElastiCache cluster is created
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then an "SNS" topic is created
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then the "SNS" topic is deleted
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then the cluster modification completes
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an ElastiCache cluster is created
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the "SNS" topic is deleted
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the cluster modification completes
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an ElastiCache cluster is created
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" topic is created
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the "SNS" topic is deleted
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the cluster modification completes
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created
    Given cid in cluster_status
    Given the cluster modification has completed
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an "SNS" topic is created
    Given cid in cluster_status
    Given the cluster modification has completed
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the "SNS" topic is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given the cluster modification has completed
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given the cluster modification has completed
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the "SNS" topic is deleted then an "SNS" notification is configured on the ElastiCache cluster
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then an "SNS" notification is configured on the ElastiCache cluster then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the cluster modification completes
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an ElastiCache cluster is created then the cluster modification completes then an "SNS" topic is created
    Given cid not in cluster_status
    Given an ElastiCache cluster has been created
    Given the cluster modification has completed
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an ElastiCache cluster is created then an "SNS" notification is configured on the ElastiCache cluster
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an ElastiCache cluster has been created
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the "SNS" topic has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the ElastiCache cluster then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the cluster modification completes
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an ElastiCache cluster is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the cluster modification completes then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the cluster modification has completed
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an ElastiCache cluster is created then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an ElastiCache cluster has been created
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" topic has been created
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the ElastiCache cluster then the cluster modification completes
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an ElastiCache cluster is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the cluster modification completes then an "SNS" notification is configured on the ElastiCache cluster
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given the cluster modification has completed
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then an ElastiCache cluster is created then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given an ElastiCache cluster has been created
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then an "SNS" topic is created then the cluster modification completes
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given an "SNS" topic has been created
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then the "SNS" topic is deleted then an ElastiCache cluster is created
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given the "SNS" topic has been deleted
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an "SNS" topic is created
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the "SNS" topic is deleted
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the ElastiCache cluster then the cluster modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given an "SNS" notification has been configured on the ElastiCache cluster
    Given the cluster modification has completed
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an ElastiCache cluster is created then the cluster modification completes
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given an ElastiCache cluster has been created
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an "SNS" topic is created then an ElastiCache cluster is created
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given an "SNS" topic has been created
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the "SNS" topic is deleted then an "SNS" topic is created
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an "SNS" notification is configured on the ElastiCache cluster then the "SNS" topic is deleted
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the cluster modification completes then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    Given the cluster modification has completed
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an ElastiCache cluster is created then an "SNS" topic is created
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given an ElastiCache cluster has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" topic is created then the "SNS" topic is deleted
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the "SNS" topic is deleted then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" notification is configured on the ElastiCache cluster then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then the cluster modification completes
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When the cluster modification completes
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a cluster event occurs but the "SNS" notification fails because the topic has been deleted then the cluster modification completes then an ElastiCache cluster is created
    Given cid in cluster_status
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    Given the cluster modification has completed
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an ElastiCache cluster is created then the "SNS" topic is deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an ElastiCache cluster has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an "SNS" topic is created then an "SNS" notification is configured on the ElastiCache cluster
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an "SNS" topic has been created
    When an "SNS" notification is configured on the ElastiCache cluster
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then the "SNS" topic is deleted then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Given cid in cluster_status
    Given the cluster modification has completed
    Given the "SNS" topic has been deleted
    When a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then an "SNS" notification is configured on the ElastiCache cluster then a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Given cid in cluster_status
    Given the cluster modification has completed
    Given an "SNS" notification has been configured on the ElastiCache cluster
    When a cluster event occurs but the "SNS" notification fails because the topic has been deleted
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster modification event occurs and ElastiCache publishes a notification to the "SNS" topic then an ElastiCache cluster is created
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic
    When an ElastiCache cluster is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the cluster modification completes then a cluster event occurs but the "SNS" notification fails because the topic has been deleted then an "SNS" topic is created
    Given cid in cluster_status
    Given the cluster modification has completed
    Given a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a cluster that exists
    And every "PUBLISHED" notification references a topic that exists
