@glaciersns @generated
Feature: GlacierSns - A Glacier Vault Is Created

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a Glacier vault is created
    Given the vault does not already exist
    When a Glacier vault is created
    Then the vault "EXISTS" with no "SNS" notification configuration
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @create_vault
  Scenario: a Glacier vault is created fails when the vault already exists
    Given the vault already exists
    When a Glacier vault is created
    Then the operation is rejected
