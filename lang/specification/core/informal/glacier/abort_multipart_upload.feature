@glacier @generated
Feature: Glacier - A Multipart "Glacier" "Upload" Is Aborted

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @abort_multipart_upload
  Scenario: a multipart "glacier" "upload" is aborted
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    When a multipart "glacier" "upload" is aborted
    Then the "glacier" "upload" will be "Aborted"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @abort_multipart_upload
  Scenario: a multipart "glacier" "upload" is aborted fails when the "glacier" "upload" did not exist
    Given the "glacier" "upload" did not exist
    When a multipart "glacier" "upload" is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload @lifecycle
  Scenario: a multipart "glacier" "upload" is aborted fails when the "glacier" "upload" was not "InProgress"
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was not "InProgress"
    When a multipart "glacier" "upload" is aborted
    Then the operation is rejected
