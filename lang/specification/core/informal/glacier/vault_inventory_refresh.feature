@glacier @generated
Feature: Glacier - A Vault Inventory Is Refreshed

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @vault_inventory_refresh @internal
  Scenario: a vault inventory is refreshed
    Given the vault exists
    And the vault is "ACTIVE"
    When a vault inventory is refreshed
    Then the vault inventory is marked as fresh
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @vault_inventory_refresh @internal
  Scenario: a vault inventory is refreshed fails when the vault does not exist
    Given the vault does not exist
    When a vault inventory is refreshed
    Then the operation is rejected

  @standard @negative @vault_inventory_refresh @internal
  Scenario: a vault inventory is refreshed fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When a vault inventory is refreshed
    Then the operation is rejected
