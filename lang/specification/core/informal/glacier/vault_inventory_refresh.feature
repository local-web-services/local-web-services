@glacier @generated
Feature: Glacier - A "Glacier" "Vault" Inventory Is Refreshed

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @vault_inventory_refresh @internal
  Scenario: a "glacier" "vault" inventory is refreshed
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    When a "glacier" "vault" inventory is refreshed
    Then the "glacier" "vault" inventory will be marked as fresh
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @vault_inventory_refresh @internal
  Scenario: a "glacier" "vault" inventory is refreshed fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "vault" inventory is refreshed
    Then the operation is rejected

  @guard @negative @vault_inventory_refresh @internal
  Scenario: a "glacier" "vault" inventory is refreshed fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a "glacier" "vault" inventory is refreshed
    Then the operation is rejected
