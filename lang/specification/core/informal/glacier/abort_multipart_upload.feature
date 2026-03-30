@glacier @generated
Feature: Glacier - A Multipart Upload Is Aborted

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @abort_multipart_upload
  Scenario: a multipart upload is aborted
    Given the upload exists
    And the upload is InProgress
    When a multipart upload is aborted
    Then the upload is Aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @abort_multipart_upload
  Scenario: a multipart upload is aborted fails when the upload does not exist
    Given the upload does not exist
    When a multipart upload is aborted
    Then the operation is rejected

  @guard @negative @abort_multipart_upload @lifecycle
  Scenario: a multipart upload is aborted fails when the upload is not InProgress
    Given the upload exists
    And the upload is not InProgress
    When a multipart upload is aborted
    Then the operation is rejected
