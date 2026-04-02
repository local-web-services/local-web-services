@glacier @generated
Feature: Glacier - A "Glacier" "Archive" Is Deleted From A "Glacier" "Vault"

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @delete_archive
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" existed
    And the "glacier" "archive" was "STORED"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    Then the "glacier" "archive" will be deleted and the "glacier" "vault" archive count decreases
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @delete_archive
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @delete_archive @lifecycle
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @delete_archive
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" fails when the "glacier" "archive" did not exist
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" did not exist
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @delete_archive @lifecycle
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" fails when the "glacier" "archive" was not "STORED"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" existed
    And the "glacier" "archive" was not "STORED"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    Then the operation is rejected
