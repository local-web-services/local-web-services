@glacier @generated
Feature: Glacier - A "Glacier" "Vault" Is Created

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a "glacier" "vault" is created
    Given the "glacier" "vault" did not already exist
    When a "glacier" "vault" is created
    Then the "glacier" "vault" will be "ACTIVE" with zero archives
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @create_vault
  Scenario: a "glacier" "vault" is created fails when the "glacier" "vault" already existed
    Given the "glacier" "vault" already existed
    When a "glacier" "vault" is created
    Then the operation is rejected
