@glacier @generated
Feature: Glacier - A Multipart "Glacier" "Upload" Is Completed

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @complete_multipart_upload
  Scenario: a multipart "glacier" "upload" is completed
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" slot is available
    When a multipart "glacier" "upload" is completed
    Then the "glacier" "upload" will be "Completed" and the assembled archive will be "STORED" in the "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "glacier" "upload" is completed fails when the "glacier" "upload" did not exist
    Given the "glacier" "upload" did not exist
    When a multipart "glacier" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart "glacier" "upload" is completed fails when the "glacier" "upload" was not "InProgress"
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was not "InProgress"
    When a multipart "glacier" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload
  Scenario: a multipart "glacier" "upload" is completed fails when the "glacier" "vault" did not exist
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "vault" did not exist
    When a multipart "glacier" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart "glacier" "upload" is completed fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a multipart "glacier" "upload" is completed
    Then the operation is rejected

  @guard @negative @complete_multipart_upload @capacity
  Scenario: a multipart "glacier" "upload" is completed fails when the "glacier" "archive" slot is not available
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "archive" slot is not available
    When a multipart "glacier" "upload" is completed
    Then the operation is rejected
