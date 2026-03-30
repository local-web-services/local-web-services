@glacier @generated
Feature: Glacier - An Empty Vault Is Deleted

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: an empty vault is deleted
    Given the vault exists
    And the vault is "ACTIVE"
    And the vault has no archives
    And the vault has no in-progress jobs
    When an empty vault is deleted
    Then the vault is "DELETED"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @delete_vault
  Scenario: an empty vault is deleted fails when the vault does not exist
    Given the vault does not exist
    When an empty vault is deleted
    Then the operation is rejected

  @guard @negative @delete_vault @lifecycle
  Scenario: an empty vault is deleted fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When an empty vault is deleted
    Then the operation is rejected

  @guard @negative @delete_vault
  Scenario: an empty vault is deleted fails when the vault has archives
    Given the vault exists
    And the vault is "ACTIVE"
    And the vault has archives
    When an empty vault is deleted
    Then the operation is rejected

  @guard @negative @delete_vault
  Scenario: an empty vault is deleted fails when the vault has in-progress jobs
    Given the vault exists
    And the vault is "ACTIVE"
    And the vault has no archives
    And the vault has in-progress jobs
    When an empty vault is deleted
    Then the operation is rejected
