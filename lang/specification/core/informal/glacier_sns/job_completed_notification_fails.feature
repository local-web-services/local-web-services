@glaciersns @generated
Feature: GlacierSns - The Glacier Job Completes But Notification Delivery Fails Because The "Sns" "Topic" Was Deleted

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured topic was "DELETED"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Then the "glacier" "job" will be "SUCCEEDED" but no notification will be published
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted fails when no job was "IN_PROGRESS"
    Given no job was "IN_PROGRESS"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Then the operation is rejected

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted fails when the "glacier" "vault" has no "SNS" notification configured
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has no "SNS" notification configured
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Then the operation is rejected

  @guard @negative @job_completed_notification_fails @internal
  Scenario: the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted fails when the configured topic was not "DELETED"
    Given a "glacier" "job" was "IN_PROGRESS"
    And the "glacier" "vault" has a "SNS" notification configured
    And the configured topic was not "DELETED"
    When the Glacier job completes but notification delivery fails because the "sns" "topic" was deleted
    Then the operation is rejected
