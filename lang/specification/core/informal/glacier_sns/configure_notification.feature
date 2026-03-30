@glaciersns @generated
Feature: GlacierSns - An Sns Notification Is Configured On The Vault

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @configure_notification
  Scenario: an "SNS" notification is configured on the vault
    Given the vault exists
    And the vault has no "SNS" notification configured
    And the topic exists and is "ACTIVE"
    When an "SNS" notification is configured on the vault
    Then the vault will publish job completion notifications to the topic
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @guard @negative @configure_notification
  Scenario: an "SNS" notification is configured on the vault fails when the vault does not exist
    Given the vault does not exist
    When an "SNS" notification is configured on the vault
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SNS" notification is configured on the vault fails when the vault already has an "SNS" notification configured
    Given the vault exists
    And the vault already has an "SNS" notification configured
    When an "SNS" notification is configured on the vault
    Then the operation is rejected

  @guard @negative @configure_notification
  Scenario: an "SNS" notification is configured on the vault fails when the topic does not exist or is not "ACTIVE"
    Given the vault exists
    And the vault has no "SNS" notification configured
    And the topic does not exist or is not "ACTIVE"
    When an "SNS" notification is configured on the vault
    Then the operation is rejected
