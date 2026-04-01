@glacier @generated
Feature: Glacier - A "Glacier" "Vault" Inventory Retrieval Job Is Initiated

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_inventory_retrieval_job
  Scenario: a "glacier" "vault" inventory retrieval job is initiated
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "job" slot is available
    When a "glacier" "vault" inventory retrieval job is initiated
    Then the "glacier" "JOB" will be "InProgress" for the given "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @initiate_inventory_retrieval_job
  Scenario: a "glacier" "vault" inventory retrieval job is initiated fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "vault" inventory retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_inventory_retrieval_job @lifecycle
  Scenario: a "glacier" "vault" inventory retrieval job is initiated fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a "glacier" "vault" inventory retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_inventory_retrieval_job @capacity
  Scenario: a "glacier" "vault" inventory retrieval job is initiated fails when the "glacier" "job" slot is not available
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "job" slot is not available
    When a "glacier" "vault" inventory retrieval job is initiated
    Then the operation is rejected
