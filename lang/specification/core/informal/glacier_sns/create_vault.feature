@glaciersns @generated
Feature: GlacierSns - A "Glacier" "Vault" Is Created

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a "glacier" "vault" is created
    Given the "glacier" "vault" did not already exist
    When a "glacier" "vault" is created
    Then the "glacier" "vault" will exist with no "SNS" notification configuration
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @create_vault
  Scenario: a "glacier" "vault" is created fails when the "glacier" "vault" already existed
    Given the "glacier" "vault" already existed
    When a "glacier" "vault" is created
    Then the operation is rejected
