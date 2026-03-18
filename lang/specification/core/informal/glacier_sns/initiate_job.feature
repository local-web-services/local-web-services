@glaciersns @generated
Feature: GlacierSns - A Glacier Archive Retrieval Job Is Initiated On The Vault

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @initiate_job
  Scenario: a Glacier archive retrieval job is initiated on the vault
    Given the vault exists
    And a job slot is available
    When a Glacier archive retrieval job is initiated on the vault
    Then the job is "IN_PROGRESS"
    And every "PUBLISHED" notification references a job that exists
    And every "PUBLISHED" notification references a topic that exists

  @standard @negative @initiate_job
  Scenario: a Glacier archive retrieval job is initiated on the vault fails when the vault does not exist
    Given the vault does not exist
    When a Glacier archive retrieval job is initiated on the vault
    Then the operation is rejected

  @standard @negative @initiate_job @capacity @internal
  Scenario: a Glacier archive retrieval job is initiated on the vault fails when no job slot is available
    Given the vault exists
    And no job slot is available
    When a Glacier archive retrieval job is initiated on the vault
    Then the operation is rejected
