@glaciersns @generated
Feature: GlacierSns - Action Sequences

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created
    Given vid not in vault_status
    Given a Glacier vault has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    Given a Glacier vault has been created
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    Given a Glacier vault has been created
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" topic is created then the "SNS" topic is deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given an "SNS" notification has been configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given a Glacier archive retrieval job has been initiated on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created
    Given vid not in vault_status
    Given a Glacier vault has been created
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier vault is created then an "SNS" notification is configured on the vault
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a Glacier vault has been created
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the "SNS" topic has been deleted
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given an "SNS" notification has been configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given a Glacier archive retrieval job has been initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted
    Given tid not in topic_status
    Given an "SNS" topic has been created
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier vault is created then a Glacier archive retrieval job is initiated on the vault
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given a Glacier vault has been created
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" topic is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" topic has been created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given an "SNS" notification has been configured on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given a Glacier archive retrieval job has been initiated on the vault
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the "SNS" topic is deleted then the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault
    Given tid in topic_status
    Given the "SNS" topic has been deleted
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier vault is created then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given a Glacier vault has been created
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then an "SNS" topic is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given an "SNS" topic has been created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the "SNS" topic is deleted then a Glacier vault is created
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given the "SNS" topic has been deleted
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given a Glacier archive retrieval job has been initiated on the vault
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: an "SNS" notification is configured on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault
    Given vid in vault_status
    Given an "SNS" notification has been configured on the vault
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created then the Glacier job completes but notification delivery fails because the topic was deleted
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given a Glacier vault has been created
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" topic is created then a Glacier vault is created
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given an "SNS" topic has been created
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the "SNS" topic is deleted then an "SNS" topic is created
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given the "SNS" topic has been deleted
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then an "SNS" notification is configured on the vault then the "SNS" topic is deleted
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given an "SNS" notification has been configured on the vault
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given vid in vault_status
    Given a Glacier archive retrieval job has been initiated on the vault
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier vault is created then an "SNS" topic is created
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given a Glacier vault has been created
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created then the "SNS" topic is deleted
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given an "SNS" topic has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the "SNS" topic is deleted then an "SNS" notification is configured on the vault
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given the "SNS" topic has been deleted
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" notification is configured on the vault then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given an "SNS" notification has been configured on the vault
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then a Glacier archive retrieval job is initiated on the vault then the Glacier job completes but notification delivery fails because the topic was deleted
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given a Glacier archive retrieval job has been initiated on the vault
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic then the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created
    Given jid in job_status
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier vault is created then the "SNS" topic is deleted
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given a Glacier vault has been created
    When the "SNS" topic is deleted
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" topic is created then an "SNS" notification is configured on the vault
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given an "SNS" topic has been created
    When an "SNS" notification is configured on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the "SNS" topic is deleted then a Glacier archive retrieval job is initiated on the vault
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given the "SNS" topic has been deleted
    When a Glacier archive retrieval job is initiated on the vault
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then an "SNS" notification is configured on the vault then the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given an "SNS" notification has been configured on the vault
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then a Glacier archive retrieval job is initiated on the vault then a Glacier vault is created
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given a Glacier archive retrieval job has been initiated on the vault
    When a Glacier vault is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @exhaustive @sequence
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted then the Glacier job completes and publishes a notification to the configured "SNS" topic then an "SNS" topic is created
    Given jid in job_status
    Given the Glacier job has completed but notification delivery has failed because the topic was deleted
    Given the Glacier job has completed and published a notification to the configured "SNS" topic
    When an "SNS" topic is created
    Then every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists
