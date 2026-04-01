@glaciersns @generated
Feature: GlacierSns - Action Sequences

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "glacier" "vault" is created then a "sns" "topic" is created
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "sns" "topic" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "SNS" notification is configured on the "glacier" "vault"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "glacier" "vault" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification is configured on the "glacier" "vault"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "glacier" "vault" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification is configured on the "glacier" "vault"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a "glacier" "vault" is created
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a "sns" "topic" is created
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the "sns" "topic" is deleted
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "glacier" "vault" is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "sns" "topic" is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the "sns" "topic" is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "SNS" notification is configured on the "glacier" "vault"
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "glacier" "vault" is created
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "sns" "topic" is created
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the "sns" "topic" is deleted
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "SNS" notification is configured on the "glacier" "vault"
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "glacier" "vault" is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "sns" "topic" is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "sns" "topic" is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "SNS" notification is configured on the "glacier" "vault"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "sns" "topic" is deleted then a "SNS" notification is configured on the "glacier" "vault"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a "SNS" notification is configured on the "glacier" "vault" then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then a Glacier archive retrieval job is initiated on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "glacier" "vault" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "sns" "topic" is created
    Given vid not in vault_status
    When a "glacier" "vault" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "glacier" "vault" is created then a "SNS" notification is configured on the "glacier" "vault"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "glacier" "vault" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "sns" "topic" is deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a "SNS" notification is configured on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then a Glacier archive retrieval job is initiated on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "glacier" "vault" is created
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "sns" "topic" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "sns" "topic" is deleted
    Given tid not in topic_status
    When a "sns" "topic" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "glacier" "vault" is created then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "glacier" "vault" is created
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "sns" "topic" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a "SNS" notification is configured on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "glacier" "vault" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "sns" "topic" is created
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "sns" "topic" is deleted then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "SNS" notification is configured on the "glacier" "vault"
    Given tid in topic_status
    When the "sns" "topic" is deleted
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a "glacier" "vault" is created then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a "glacier" "vault" is created
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a "sns" "topic" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a "sns" "topic" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the "sns" "topic" is deleted then a "glacier" "vault" is created
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "sns" "topic" is deleted
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "sns" "topic" is created
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the "sns" "topic" is deleted
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a "SNS" notification is configured on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given vid in vault_status
    When a "SNS" notification is configured on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "glacier" "vault" is created then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "glacier" "vault" is created
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "sns" "topic" is created then a "glacier" "vault" is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "sns" "topic" is created
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the "sns" "topic" is deleted then a "sns" "topic" is created
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the "sns" "topic" is deleted
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "SNS" notification is configured on the "glacier" "vault" then the "sns" "topic" is deleted
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "SNS" notification is configured on the "glacier" "vault"
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given vid in vault_status
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "glacier" "vault" is created then a "sns" "topic" is created
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "glacier" "vault" is created
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "sns" "topic" is created then the "sns" "topic" is deleted
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "sns" "topic" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the "sns" "topic" is deleted then a "SNS" notification is configured on the "glacier" "vault"
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the "sns" "topic" is deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "SNS" notification is configured on the "glacier" "vault" then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "SNS" notification is configured on the "glacier" "vault"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a Glacier archive retrieval job is initiated on the "glacier" "vault" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "glacier" "vault" is created
    Given jid in job_status
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "glacier" "vault" is created then the "sns" "topic" is deleted
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "glacier" "vault" is created
    When the "sns" "topic" is deleted
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "sns" "topic" is created then a "SNS" notification is configured on the "glacier" "vault"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "sns" "topic" is created
    When a "SNS" notification is configured on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "sns" "topic" is deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "sns" "topic" is deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a "SNS" notification is configured on the "glacier" "vault" then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a "SNS" notification is configured on the "glacier" "vault"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then a Glacier archive retrieval job is initiated on the "glacier" "vault" then a "glacier" "vault" is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    When a "glacier" "vault" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @sequence
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted then the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" then a "sns" "topic" is created
    Given jid in job_status
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    When a "sns" "topic" is created
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists
