@glaciersns @generated
Feature: GlacierSns - Action Sequences

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier vault is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" topic is created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the "SNS" topic is deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When an "SNS" notification is configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier vault is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" topic is created
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists
