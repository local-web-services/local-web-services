@glacier @generated
Feature: Glacier - A Vault Is Created

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @create_vault
  Scenario: a vault is created
    Given the vault does not already exist
    When a vault is created
    Then the vault is "ACTIVE" with zero archives
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @create_vault
  Scenario: a vault is created fails when the vault already exists
    Given the vault already exists
    When a vault is created
    Then the operation is rejected
