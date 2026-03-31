@glaciersns @generated
Feature: GlacierSns - A Sns Notification Is Configured On The "Glacier" "Vault"

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: a "SNS" notification is configured on the "glacier" "vault"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" has no "SNS" notification configured
    And the "sns" "topic" existed and was "ACTIVE"
    When a "SNS" notification is configured on the "glacier" "vault"
    Then the "glacier" "vault" will publish job completion notifications to the "sns" "topic"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @configure_notification
  Scenario: a "SNS" notification is configured on the "glacier" "vault" fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "SNS" notification is configured on the "glacier" "vault"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification is configured on the "glacier" "vault" fails when the "glacier" "vault" already has a "SNS" notification configured
    Given the "glacier" "vault" existed
    And the "glacier" "vault" already has a "SNS" notification configured
    When a "SNS" notification is configured on the "glacier" "vault"
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: a "SNS" notification is configured on the "glacier" "vault" fails when the "sns" "topic" did not exist or was "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" has no "SNS" notification configured
    And the "sns" "topic" did not exist or was "ACTIVE"
    When a "SNS" notification is configured on the "glacier" "vault"
    Then the operation is rejected
