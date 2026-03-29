@glacier @generated
Feature: Glacier - A Vault Inventory Retrieval Job Is Initiated

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_inventory_retrieval_job
  Scenario: a vault inventory retrieval job is initiated
    Given the vault exists
    And the vault is "ACTIVE"
    And the job slot is available
    When a vault inventory retrieval job is initiated
    Then the job is InProgress for the given vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @initiate_inventory_retrieval_job
  Scenario: a vault inventory retrieval job is initiated fails when the vault does not exist
    Given the vault does not exist
    When a vault inventory retrieval job is initiated
    Then the operation is rejected

  @standard @negative @initiate_inventory_retrieval_job @lifecycle
  Scenario: a vault inventory retrieval job is initiated fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When a vault inventory retrieval job is initiated
    Then the operation is rejected

  @standard @negative @internal @initiate_inventory_retrieval_job @capacity
  Scenario: a vault inventory retrieval job is initiated fails when the job slot is not available
    Given the vault exists
    And the vault is "ACTIVE"
    And the job slot is not available
    When a vault inventory retrieval job is initiated
    Then the operation is rejected
