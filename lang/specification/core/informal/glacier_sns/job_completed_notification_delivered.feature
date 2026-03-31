@glaciersns @generated
Feature: GlacierSns - The Glacier Job Completes And Publishes A Notification To The Configured Sns Topic

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured topic was "ACTIVE"
    And a message slot is available
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the "glacier" "job" will be "SUCCEEDED" and the notification will be "PUBLISHED"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when no job was "IN_PROGRESS"
    Given no job was "IN_PROGRESS"
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when the "glacier" "vault" has no "SNS" notification configured
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has no "SNS" notification configured
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when the configured topic was "DELETED"
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured topic was "DELETED"
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the Glacier job completes and publishes a notification to the configured "SNS" topic fails when no message slot is available
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured topic was "ACTIVE"
    And no message slot is available
    When the Glacier job completes and publishes a notification to the configured "SNS" topic
    Then the operation is rejected
