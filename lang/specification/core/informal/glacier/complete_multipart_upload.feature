@glacier @generated
Feature: Glacier - A Multipart Upload Is Completed

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @complete_multipart_upload
  Scenario: a multipart upload is completed
    Given the upload exists
    And the upload is InProgress
    And the vault exists
    And the vault is "ACTIVE"
    And the archive slot is available
    When a multipart upload is completed
    Then the upload is Completed and the assembled archive is "STORED" in the vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @complete_multipart_upload
  Scenario: a multipart upload is completed fails when the upload does not exist
    Given the upload does not exist
    When a multipart upload is completed
    Then the operation is rejected

  @standard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart upload is completed fails when the upload is not InProgress
    Given the upload exists
    And the upload is not InProgress
    When a multipart upload is completed
    Then the operation is rejected

  @standard @negative @complete_multipart_upload @internal
  Scenario: a multipart upload is completed fails when the vault does not exist
    Given the upload exists
    And the upload is InProgress
    And the vault does not exist
    When a multipart upload is completed
    Then the operation is rejected

  @standard @negative @complete_multipart_upload @lifecycle
  Scenario: a multipart upload is completed fails when the vault is not "ACTIVE"
    Given the upload exists
    And the upload is InProgress
    And the vault exists
    And the vault is not "ACTIVE"
    When a multipart upload is completed
    Then the operation is rejected

  @standard @negative @internal @complete_multipart_upload @capacity
  Scenario: a multipart upload is completed fails when the archive slot is not available
    Given the upload exists
    And the upload is InProgress
    And the vault exists
    And the vault is "ACTIVE"
    And the archive slot is not available
    When a multipart upload is completed
    Then the operation is rejected
