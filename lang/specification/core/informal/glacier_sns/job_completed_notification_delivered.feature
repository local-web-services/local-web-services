@glaciersns @generated
Feature: GlacierSns - The "Glacier" "Job" Completes And Publishes A Notification To The Configured "Sns" "Topic"

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @job_completed_notification_delivered @internal
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured "sns" "topic" was "ACTIVE"
    And a "sns" "message" "slot" was "available"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Then the "glacier" "job" will be "SUCCEEDED" and the notification will be "PUBLISHED"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" fails when no "glacier" "job" was "IN_PROGRESS"
    Given no "glacier" "job" was "IN_PROGRESS"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" fails when the "glacier" "vault" has no "SNS" notification configured
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has no "SNS" notification configured
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" fails when the configured "sns" "topic" was "DELETED"
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured "sns" "topic" was "DELETED"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Then the operation is rejected

  @guard @negative @job_completed_notification_delivered @internal
  Scenario: the "glacier" "job" completes and publishes a notification to the configured "sns" "topic" fails when no "sns" "message" "slot" was "available"
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured "sns" "topic" was "ACTIVE"
    And no "sns" "message" "slot" was "available"
    When the "glacier" "job" completes and publishes a notification to the configured "sns" "topic"
    Then the operation is rejected
