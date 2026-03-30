@glacier @generated
Feature: Glacier - A Part Is Uploaded For A Multipart Upload

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @upload_multipart_part
  Scenario: a part is uploaded for a multipart upload
    Given the upload exists
    And the upload is InProgress
    And the part has not already been uploaded
    When a part is uploaded for a multipart upload
    Then the part is recorded for the upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @upload_multipart_part
  Scenario: a part is uploaded for a multipart upload fails when the upload does not exist
    Given the upload does not exist
    When a part is uploaded for a multipart upload
    Then the operation is rejected

  @guard @negative @upload_multipart_part @lifecycle
  Scenario: a part is uploaded for a multipart upload fails when the upload is not InProgress
    Given the upload exists
    And the upload is not InProgress
    When a part is uploaded for a multipart upload
    Then the operation is rejected

  @guard @negative @upload_multipart_part
  Scenario: a part is uploaded for a multipart upload fails when the part has already been uploaded
    Given the upload exists
    And the upload is InProgress
    And the part has already been uploaded
    When a part is uploaded for a multipart upload
    Then the operation is rejected
