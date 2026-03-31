@glacier @generated
Feature: Glacier - A "Glacier" "Archive" Retrieval Job Is Initiated

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_archive_retrieval_job
  Scenario: a "glacier" "archive" retrieval job is initiated
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" existed
    And the "glacier" "archive" was "STORED"
    And the "glacier" "job" slot is available
    When a "glacier" "archive" retrieval job is initiated
    Then the "glacier" "JOB" will be "InProgress" for the given archive
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @initiate_archive_retrieval_job
  Scenario: a "glacier" "archive" retrieval job is initiated fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "archive" retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_archive_retrieval_job @lifecycle
  Scenario: a "glacier" "archive" retrieval job is initiated fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a "glacier" "archive" retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_archive_retrieval_job
  Scenario: a "glacier" "archive" retrieval job is initiated fails when the "glacier" "archive" did not exist
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" did not exist
    When a "glacier" "archive" retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_archive_retrieval_job @lifecycle
  Scenario: a "glacier" "archive" retrieval job is initiated fails when the "glacier" "archive" was not "STORED"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" existed
    And the "glacier" "archive" was not "STORED"
    When a "glacier" "archive" retrieval job is initiated
    Then the operation is rejected

  @guard @negative @initiate_archive_retrieval_job @capacity
  Scenario: a "glacier" "archive" retrieval job is initiated fails when the "glacier" "job" slot is not available
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" existed
    And the "glacier" "archive" was "STORED"
    And the "glacier" "job" slot is not available
    When a "glacier" "archive" retrieval job is initiated
    Then the operation is rejected
