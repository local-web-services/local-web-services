@glacier @generated
Feature: Glacier - An Empty "Glacier" "Vault" Is Deleted

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @delete_vault
  Scenario: an empty "glacier" "vault" is deleted
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "vault" had no archives
    And the "glacier" "vault" had no in-progress jobs
    When an empty "glacier" "vault" is deleted
    Then the "glacier" "vault" will be "DELETED"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @delete_vault
  Scenario: an empty "glacier" "vault" is deleted fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When an empty "glacier" "vault" is deleted
    Then the operation is rejected

  @guard @negative @delete_vault @lifecycle
  Scenario: an empty "glacier" "vault" is deleted fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When an empty "glacier" "vault" is deleted
    Then the operation is rejected

  @guard @negative @delete_vault
  Scenario: an empty "glacier" "vault" is deleted fails when the "glacier" "vault" had archives
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "vault" had archives
    When an empty "glacier" "vault" is deleted
    Then the operation is rejected

  @guard @negative @delete_vault
  Scenario: an empty "glacier" "vault" is deleted fails when the "glacier" "vault" had in-progress jobs
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "vault" had no archives
    And the "glacier" "vault" had in-progress jobs
    When an empty "glacier" "vault" is deleted
    Then the operation is rejected
