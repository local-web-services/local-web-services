@glacier @generated
Feature: Glacier - A "Glacier" "Archive" Is Uploaded To A "Glacier" "Vault"

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @upload_archive
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" did not already exist
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    Then the "glacier" "archive" will be "STORED" and the "glacier" "vault" archive count will increase
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @upload_archive
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @upload_archive @lifecycle
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @upload_archive
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" fails when the "glacier" "archive" already existed
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" already existed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    Then the operation is rejected
