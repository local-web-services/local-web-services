@glaciersns @generated
Feature: GlacierSns - A Glacier Archive Retrieval Job Is Initiated On The "Glacier" "Vault"

  # Generated from FizzBee spec: glacier_sns.fizz
  # Safety invariants: PublishedNotificationReferencesExistingJob, PublishedNotificationReferencesExistingTopic

  Background:
    Given the system is initialized

  @minimal @happy @initiate_job
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Given the "glacier" "vault" existed
    And a "glacier" "job" "slot" was "available"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Then the "glacier" "job" will be "IN_PROGRESS"
    And every "PUBLISHED" notification references a "glacier" "job" that exists
    And every "PUBLISHED" notification references a "sns" "topic" that exists

  @guard @negative @initiate_job
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Then the operation is rejected

  @guard @negative @initiate_job @capacity
  Scenario: a Glacier archive retrieval job is initiated on the "glacier" "vault" fails when no "glacier" "job" "slot" was "available"
    Given the "glacier" "vault" existed
    And no "glacier" "job" "slot" was "available"
    When a Glacier archive retrieval job is initiated on the "glacier" "vault"
    Then the operation is rejected
