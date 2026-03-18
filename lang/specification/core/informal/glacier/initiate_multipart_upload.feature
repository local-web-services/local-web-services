@glacier @generated
Feature: Glacier - A Multipart Upload Is Initiated For A Vault

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_multipart_upload
  Scenario: a multipart upload is initiated for a vault
    Given the vault exists
    And the vault is "ACTIVE"
    And the upload does not already exist
    When a multipart upload is initiated for a vault
    Then the upload is InProgress
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @initiate_multipart_upload
  Scenario: a multipart upload is initiated for a vault fails when the vault does not exist
    Given the vault does not exist
    When a multipart upload is initiated for a vault
    Then the operation is rejected

  @standard @negative @initiate_multipart_upload @lifecycle @internal
  Scenario: a multipart upload is initiated for a vault fails when the vault is not "ACTIVE"
    Given the vault exists
    And the vault is not "ACTIVE"
    When a multipart upload is initiated for a vault
    Then the operation is rejected

  @standard @negative @initiate_multipart_upload
  Scenario: a multipart upload is initiated for a vault fails when the upload already exists
    Given the vault exists
    And the vault is "ACTIVE"
    And the upload already exists
    When a multipart upload is initiated for a vault
    Then the operation is rejected
