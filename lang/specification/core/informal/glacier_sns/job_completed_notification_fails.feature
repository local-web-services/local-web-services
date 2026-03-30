@glaciersns @generated
Feature: GlacierSns - The Glacier Job Completes But Notification Delivery Fails Because The Topic Was Deleted

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted
    Given a job is "IN_PROGRESS"
    And the vault has an "SNS" notification configured
    And the configured topic is "DELETED"
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then the job is "SUCCEEDED" but no notification is published
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted fails when no job is "IN_PROGRESS"
    Given no job is "IN_PROGRESS"
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then the operation is rejected

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted fails when the vault has no "SNS" notification configured
    Given a job is "IN_PROGRESS"
    And the vault has no "SNS" notification configured
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then the operation is rejected

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the topic was deleted fails when the configured topic is not "DELETED"
    Given a job is "IN_PROGRESS"
    And the vault has an "SNS" notification configured
    And the configured topic is not "DELETED"
    When the Glacier job completes but notification delivery fails because the topic was deleted
    Then the operation is rejected
