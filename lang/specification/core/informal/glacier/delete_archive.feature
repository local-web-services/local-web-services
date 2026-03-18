@glacier @generated
Feature: Glacier - An Archive Is Deleted From A Vault

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @delete_archive
  Scenario: an archive is deleted from a vault
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive exists
    And the archive is "STORED"
    When an archive is deleted from a vault
    Then the archive is "DELETED" and the vault archive count decreases
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @delete_archive
  Scenario: an archive is deleted from a vault fails when the vault does not exist
    Given the vault does not exist
    When an archive is deleted from a vault
    Then the operation is rejected

  @standard @negative @delete_archive @lifecycle @internal
  Scenario: an archive is deleted from a vault fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When an archive is deleted from a vault
    Then the operation is rejected

  @standard @negative @delete_archive
  Scenario: an archive is deleted from a vault fails when the archive does not exist
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive does not exist
    When an archive is deleted from a vault
    Then the operation is rejected

  @standard @negative @delete_archive @lifecycle @internal
  Scenario: an archive is deleted from a vault fails when the archive is not "STORED"
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive exists
    And the archive is not "STORED"
    When an archive is deleted from a vault
    Then the operation is rejected
