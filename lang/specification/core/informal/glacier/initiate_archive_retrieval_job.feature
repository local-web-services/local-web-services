@glacier @generated
Feature: Glacier - An Archive Retrieval Job Is Initiated

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_archive_retrieval_job
  Scenario: an archive retrieval job is initiated
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive exists
    And the archive is "STORED"
    And the job slot is available
    When an archive retrieval job is initiated
    Then the job is InProgress for the given archive
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @initiate_archive_retrieval_job
  Scenario: an archive retrieval job is initiated fails when the vault does not exist
    Given the vault does not exist
    When an archive retrieval job is initiated
    Then the operation is rejected

  @standard @negative @initiate_archive_retrieval_job @lifecycle @internal
  Scenario: an archive retrieval job is initiated fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When an archive retrieval job is initiated
    Then the operation is rejected

  @standard @negative @initiate_archive_retrieval_job
  Scenario: an archive retrieval job is initiated fails when the archive does not exist
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive does not exist
    When an archive retrieval job is initiated
    Then the operation is rejected

  @standard @negative @initiate_archive_retrieval_job @lifecycle @internal
  Scenario: an archive retrieval job is initiated fails when the archive is not "STORED"
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive exists
    And the archive is not "STORED"
    When an archive retrieval job is initiated
    Then the operation is rejected

  @standard @negative @initiate_archive_retrieval_job @capacity @internal
  Scenario: an archive retrieval job is initiated fails when the job slot is not available
    Given the vault exists
    And the vault is "ACTIVE"
    And the archive exists
    And the archive is "STORED"
    And the job slot is not available
    When an archive retrieval job is initiated
    Then the operation is rejected
