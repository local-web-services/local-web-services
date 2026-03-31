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
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @create_vault
  Scenario: a "glacier" "vault" is created fails when the "glacier" "vault" already existed
    Given the "glacier" "vault" already existed
    When a "glacier" "vault" is created
    Then the operation is rejected
