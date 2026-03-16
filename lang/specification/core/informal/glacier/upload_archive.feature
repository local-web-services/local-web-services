@glacier @generated
Feature: Glacier - An Archive Is Uploaded To A Vault

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @upload_archive
  Scenario: an archive is uploaded to a vault
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive does not already exist
    When an archive is uploaded to a vault
    Then the archive is "STORED" and the vault archive count increases
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @upload_archive
  Scenario: an archive is uploaded to a vault fails when the vault does not exist
    Given the vault does not exist
    When an archive is uploaded to a vault
    Then the operation is rejected

  @standard @negative @upload_archive @lifecycle
  Scenario: an archive is uploaded to a vault fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When an archive is uploaded to a vault
    Then the operation is rejected

  @standard @negative @upload_archive
  Scenario: an archive is uploaded to a vault fails when the archive already exists
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive already exists
    When an archive is uploaded to a vault
    Then the operation is rejected
