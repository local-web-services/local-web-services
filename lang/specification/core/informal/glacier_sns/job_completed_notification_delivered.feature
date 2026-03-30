@glaciersns @generated
Feature: GlacierSns - The Glacier Job Completes And Publishes A Notification To The Configured Sns Topic

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given a job is "IN_PROGRESS"
    And the vault has an "SNS" notification configured
    And the configured topic is "ACTIVE"
    And a message slot is available
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the job is "SUCCEEDED" and the notification is "PUBLISHED"
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when no job is "IN_PROGRESS"
    Given no job is "IN_PROGRESS"
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when the vault has no "SNS" notification configured
    Given a job is "IN_PROGRESS"
    And the vault has no "SNS" notification configured
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when the configured topic is "DELETED"
    Given a job is "IN_PROGRESS"
    And the vault has an "SNS" notification configured
    And the configured topic is "DELETED"
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when no message slot is available
    Given a job is "IN_PROGRESS"
    And the vault has an "SNS" notification configured
    And the configured topic is "ACTIVE"
    And no message slot is available
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected
