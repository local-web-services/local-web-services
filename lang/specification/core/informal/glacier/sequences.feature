@glacier @generated
Feature: Glacier - Action Sequences

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @sequence
  Scenario: a vault is created then an empty vault is deleted
    Given vault not in vault_status
    Given a vault has been created
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive is uploaded to a vault
    Given vault not in vault_status
    Given a vault has been created
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive is deleted from a vault
    Given vault not in vault_status
    Given a vault has been created
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is initiated for a vault
    Given vault not in vault_status
    Given a vault has been created
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a part is uploaded for a multipart upload
    Given vault not in vault_status
    Given a vault has been created
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is completed
    Given vault not in vault_status
    Given a vault has been created
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is aborted
    Given vault not in vault_status
    Given a vault has been created
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive retrieval job is initiated
    Given vault not in vault_status
    Given a vault has been created
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a vault inventory retrieval job is initiated
    Given vault not in vault_status
    Given a vault has been created
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a job completes successfully
    Given vault not in vault_status
    Given a vault has been created
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a job fails
    Given vault not in vault_status
    Given a vault has been created
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then the output of a succeeded job is retrieved
    Given vault not in vault_status
    Given a vault has been created
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a vault inventory is refreshed
    Given vault not in vault_status
    Given a vault has been created
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault is created
    Given vault in vault_status
    Given an empty vault has been deleted
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive is uploaded to a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive is deleted from a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an empty vault has been deleted
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is completed
    Given vault in vault_status
    Given an empty vault has been deleted
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is aborted
    Given vault in vault_status
    Given an empty vault has been deleted
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive retrieval job is initiated
    Given vault in vault_status
    Given an empty vault has been deleted
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an empty vault has been deleted
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a job completes successfully
    Given vault in vault_status
    Given an empty vault has been deleted
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a job fails
    Given vault in vault_status
    Given an empty vault has been deleted
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an empty vault has been deleted
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault inventory is refreshed
    Given vault in vault_status
    Given an empty vault has been deleted
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault is created
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an empty vault is deleted
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an archive is deleted from a vault
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is completed
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is aborted
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an archive retrieval job is initiated
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a job completes successfully
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a job fails
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault is created
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an empty vault is deleted
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an archive is uploaded to a vault
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is completed
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is aborted
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an archive retrieval job is initiated
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a job completes successfully
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a job fails
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive has been deleted from a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault is created
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an empty vault is deleted
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is uploaded to a vault
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is deleted from a vault
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is aborted
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive retrieval job is initiated
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a job completes successfully
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a job fails
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory is refreshed
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault is created
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an empty vault is deleted
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is uploaded to a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is deleted from a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated for a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive retrieval job is initiated
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a job completes successfully
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a job fails
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then the output of a succeeded job is retrieved
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory is refreshed
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault is created
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an empty vault is deleted
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive is uploaded to a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive is deleted from a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a job completes successfully
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a job fails
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault inventory is refreshed
    Given upload_id in upload_status
    Given a multipart upload has been completed
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault is created
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an empty vault is deleted
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive is uploaded to a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive is deleted from a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a job completes successfully
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a job fails
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault inventory is refreshed
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault is created
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an empty vault is deleted
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an archive is uploaded to a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an archive is deleted from a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is completed
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is aborted
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a job fails
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault is created
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an empty vault is deleted
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is uploaded to a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is deleted from a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is completed
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is aborted
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault is created
    Given jid in job_status
    Given a job has completed successfully
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an empty vault is deleted
    Given jid in job_status
    Given a job has completed successfully
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive is uploaded to a vault
    Given jid in job_status
    Given a job has completed successfully
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive is deleted from a vault
    Given jid in job_status
    Given a job has completed successfully
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is initiated for a vault
    Given jid in job_status
    Given a job has completed successfully
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a part is uploaded for a multipart upload
    Given jid in job_status
    Given a job has completed successfully
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is completed
    Given jid in job_status
    Given a job has completed successfully
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is aborted
    Given jid in job_status
    Given a job has completed successfully
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive retrieval job is initiated
    Given jid in job_status
    Given a job has completed successfully
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given a job has completed successfully
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a job fails
    Given jid in job_status
    Given a job has completed successfully
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then the output of a succeeded job is retrieved
    Given jid in job_status
    Given a job has completed successfully
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault inventory is refreshed
    Given jid in job_status
    Given a job has completed successfully
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault is created
    Given jid in job_status
    Given a job has failed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an empty vault is deleted
    Given jid in job_status
    Given a job has failed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive is uploaded to a vault
    Given jid in job_status
    Given a job has failed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive is deleted from a vault
    Given jid in job_status
    Given a job has failed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is initiated for a vault
    Given jid in job_status
    Given a job has failed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a part is uploaded for a multipart upload
    Given jid in job_status
    Given a job has failed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is completed
    Given jid in job_status
    Given a job has failed
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is aborted
    Given jid in job_status
    Given a job has failed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive retrieval job is initiated
    Given jid in job_status
    Given a job has failed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given a job has failed
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a job completes successfully
    Given jid in job_status
    Given a job has failed
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then the output of a succeeded job is retrieved
    Given jid in job_status
    Given a job has failed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault inventory is refreshed
    Given jid in job_status
    Given a job has failed
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault is created
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an empty vault is deleted
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is uploaded to a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is deleted from a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is initiated for a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart upload
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is completed
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is aborted
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive retrieval job is initiated
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a job completes successfully
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a job fails
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory is refreshed
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a vault is created
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an empty vault is deleted
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive is uploaded to a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive is deleted from a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is completed
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is aborted
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a job completes successfully
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a job fails
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a vault inventory has been refreshed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an empty vault is deleted then an archive is uploaded to a vault
    Given vault not in vault_status
    Given a vault has been created
    Given an empty vault has been deleted
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive is uploaded to a vault then an archive is deleted from a vault
    Given vault not in vault_status
    Given a vault has been created
    Given an archive has been uploaded to a vault
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given vault not in vault_status
    Given a vault has been created
    Given an archive has been deleted from a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given vault not in vault_status
    Given a vault has been created
    Given a multipart upload has been initiated for a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a part is uploaded for a multipart upload then a multipart upload is completed
    Given vault not in vault_status
    Given a vault has been created
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is completed then a multipart upload is aborted
    Given vault not in vault_status
    Given a vault has been created
    Given a multipart upload has been completed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a multipart upload is aborted then an archive retrieval job is initiated
    Given vault not in vault_status
    Given a vault has been created
    Given a multipart upload has been aborted
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given vault not in vault_status
    Given a vault has been created
    Given an archive retrieval job has been initiated
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a vault inventory retrieval job is initiated then a job completes successfully
    Given vault not in vault_status
    Given a vault has been created
    Given a vault inventory retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a job completes successfully then a job fails
    Given vault not in vault_status
    Given a vault has been created
    Given a job has completed successfully
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a job fails then the output of a succeeded job is retrieved
    Given vault not in vault_status
    Given a vault has been created
    Given a job has failed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then the output of a succeeded job is retrieved then a vault inventory is refreshed
    Given vault not in vault_status
    Given a vault has been created
    Given the output of a succeeded job has been retrieved
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault is created then a vault inventory is refreshed then an empty vault is deleted
    Given vault not in vault_status
    Given a vault has been created
    Given a vault inventory has been refreshed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault is created then an archive is deleted from a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a vault has been created
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    Given an archive has been uploaded to a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an empty vault has been deleted
    Given an archive has been deleted from a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a multipart upload has been initiated for a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is completed then an archive retrieval job is initiated
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a multipart upload has been completed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a multipart upload has been aborted
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    Given an empty vault has been deleted
    Given an archive retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a vault inventory retrieval job has been initiated
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a job completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a job has completed successfully
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a job fails then a vault inventory is refreshed
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a job has failed
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then the output of a succeeded job is retrieved then a vault is created
    Given vault in vault_status
    Given an empty vault has been deleted
    Given the output of a succeeded job has been retrieved
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty vault is deleted then a vault inventory is refreshed then an archive is uploaded to a vault
    Given vault in vault_status
    Given an empty vault has been deleted
    Given a vault inventory has been refreshed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault is created then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a vault has been created
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an empty vault is deleted then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given an empty vault has been deleted
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an archive is deleted from a vault then a multipart upload is completed
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given an archive has been deleted from a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is initiated for a vault then a multipart upload is aborted
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a multipart upload has been initiated for a vault
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a part is uploaded for a multipart upload then an archive retrieval job is initiated
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a part has been uploaded for a multipart upload
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is completed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a multipart upload has been completed
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is aborted then a job completes successfully
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a multipart upload has been aborted
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then an archive retrieval job is initiated then a job fails
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given an archive retrieval job has been initiated
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a vault inventory retrieval job has been initiated
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a job completes successfully then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a job has completed successfully
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a job fails then a vault is created
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a job has failed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then the output of a succeeded job is retrieved then an empty vault is deleted
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given the output of a succeeded job has been retrieved
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory is refreshed then an archive is deleted from a vault
    Given vault in vault_status
    Given an archive has been uploaded to a vault
    Given a vault inventory has been refreshed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault is created then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a vault has been created
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an empty vault is deleted then a multipart upload is completed
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given an empty vault has been deleted
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an archive is uploaded to a vault then a multipart upload is aborted
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given an archive has been uploaded to a vault
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is initiated for a vault then an archive retrieval job is initiated
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a multipart upload has been initiated for a vault
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a part has been uploaded for a multipart upload
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is completed then a job completes successfully
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a multipart upload has been completed
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is aborted then a job fails
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a multipart upload has been aborted
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then an archive retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given an archive retrieval job has been initiated
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault inventory retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a vault inventory retrieval job has been initiated
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a job completes successfully then a vault is created
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a job has completed successfully
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a job fails then an empty vault is deleted
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a job has failed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then the output of a succeeded job is retrieved then an archive is uploaded to a vault
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given the output of a succeeded job has been retrieved
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive is deleted from a vault then a vault inventory is refreshed then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive has been deleted from a vault
    Given a vault inventory has been refreshed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault is created then a multipart upload is completed
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a vault has been created
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an empty vault is deleted then a multipart upload is aborted
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given an empty vault has been deleted
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is uploaded to a vault then an archive retrieval job is initiated
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given an archive has been uploaded to a vault
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is deleted from a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given an archive has been deleted from a vault
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a part is uploaded for a multipart upload then a job completes successfully
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a part has been uploaded for a multipart upload
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is completed then a job fails
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a multipart upload has been completed
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is aborted then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a multipart upload has been aborted
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then an archive retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given an archive retrieval job has been initiated
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory retrieval job is initiated then a vault is created
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a vault inventory retrieval job has been initiated
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a job completes successfully then an empty vault is deleted
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a job has completed successfully
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a job fails then an archive is uploaded to a vault
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a job has failed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then the output of a succeeded job is retrieved then an archive is deleted from a vault
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given the output of a succeeded job has been retrieved
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory is refreshed then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a multipart upload has been initiated for a vault
    Given a vault inventory has been refreshed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault is created then a multipart upload is aborted
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a vault has been created
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an empty vault is deleted then an archive retrieval job is initiated
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given an empty vault has been deleted
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is uploaded to a vault then a vault inventory retrieval job is initiated
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given an archive has been uploaded to a vault
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is deleted from a vault then a job completes successfully
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given an archive has been deleted from a vault
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated for a vault then a job fails
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been initiated for a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed then the output of a succeeded job is retrieved
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been completed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted then a vault inventory is refreshed
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a multipart upload has been aborted
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then an archive retrieval job is initiated then a vault is created
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given an archive retrieval job has been initiated
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated then an empty vault is deleted
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a vault inventory retrieval job has been initiated
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a job completes successfully then an archive is uploaded to a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a job has completed successfully
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a job fails then an archive is deleted from a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a job has failed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then the output of a succeeded job is retrieved then a multipart upload is initiated for a vault
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given the output of a succeeded job has been retrieved
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory is refreshed then a multipart upload is completed
    Given upload in upload_status
    Given a part has been uploaded for a multipart upload
    Given a vault inventory has been refreshed
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault is created then an archive retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a vault has been created
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an empty vault is deleted then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given an empty vault has been deleted
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive is uploaded to a vault then a job completes successfully
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given an archive has been uploaded to a vault
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive is deleted from a vault then a job fails
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given an archive has been deleted from a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated for a vault then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a multipart upload has been initiated for a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload then a vault inventory is refreshed
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a part has been uploaded for a multipart upload
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted then a vault is created
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a multipart upload has been aborted
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then an archive retrieval job is initiated then an empty vault is deleted
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given an archive retrieval job has been initiated
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault inventory retrieval job is initiated then an archive is uploaded to a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a vault inventory retrieval job has been initiated
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a job completes successfully then an archive is deleted from a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a job has completed successfully
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a job fails then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a job has failed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then the output of a succeeded job is retrieved then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given the output of a succeeded job has been retrieved
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is completed then a vault inventory is refreshed then a multipart upload is aborted
    Given upload_id in upload_status
    Given a multipart upload has been completed
    Given a vault inventory has been refreshed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault is created then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a vault has been created
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an empty vault is deleted then a job completes successfully
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given an empty vault has been deleted
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive is uploaded to a vault then a job fails
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given an archive has been uploaded to a vault
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive is deleted from a vault then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given an archive has been deleted from a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated for a vault then a vault inventory is refreshed
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a multipart upload has been initiated for a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload then a vault is created
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a part has been uploaded for a multipart upload
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed then an empty vault is deleted
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a multipart upload has been completed
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then an archive retrieval job is initiated then an archive is uploaded to a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given an archive retrieval job has been initiated
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault inventory retrieval job is initiated then an archive is deleted from a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a vault inventory retrieval job has been initiated
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a job completes successfully then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a job has completed successfully
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a job fails then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a job has failed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then the output of a succeeded job is retrieved then a multipart upload is completed
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given the output of a succeeded job has been retrieved
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart upload is aborted then a vault inventory is refreshed then an archive retrieval job is initiated
    Given upload_id in upload_status
    Given a multipart upload has been aborted
    Given a vault inventory has been refreshed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault is created then a job completes successfully
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a vault has been created
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an empty vault is deleted then a job fails
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given an empty vault has been deleted
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an archive is uploaded to a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given an archive has been uploaded to a vault
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then an archive is deleted from a vault then a vault inventory is refreshed
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given an archive has been deleted from a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is initiated for a vault then a vault is created
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a multipart upload has been initiated for a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a part is uploaded for a multipart upload then an empty vault is deleted
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a part has been uploaded for a multipart upload
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is completed then an archive is uploaded to a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a multipart upload has been completed
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is aborted then an archive is deleted from a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a multipart upload has been aborted
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a vault inventory retrieval job has been initiated
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a job completes successfully then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a job has completed successfully
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a job fails then a multipart upload is completed
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a job has failed
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then the output of a succeeded job is retrieved then a multipart upload is aborted
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given the output of a succeeded job has been retrieved
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory is refreshed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given an archive retrieval job has been initiated
    Given a vault inventory has been refreshed
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault is created then a job fails
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a vault has been created
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an empty vault is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given an empty vault has been deleted
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is uploaded to a vault then a vault inventory is refreshed
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given an archive has been uploaded to a vault
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is deleted from a vault then a vault is created
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given an archive has been deleted from a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault then an empty vault is deleted
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a multipart upload has been initiated for a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a part is uploaded for a multipart upload then an archive is uploaded to a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a part has been uploaded for a multipart upload
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is completed then an archive is deleted from a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a multipart upload has been completed
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is aborted then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a multipart upload has been aborted
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given an archive retrieval job has been initiated
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a job completes successfully then a multipart upload is completed
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a job has completed successfully
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a job fails then a multipart upload is aborted
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a job has failed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved then an archive retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given the output of a succeeded job has been retrieved
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault inventory is refreshed then a job completes successfully
    Given vault in vault_status
    Given a vault inventory retrieval job has been initiated
    Given a vault inventory has been refreshed
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault is created then the output of a succeeded job is retrieved
    Given jid in job_status
    Given a job has completed successfully
    Given a vault has been created
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an empty vault is deleted then a vault inventory is refreshed
    Given jid in job_status
    Given a job has completed successfully
    Given an empty vault has been deleted
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive is uploaded to a vault then a vault is created
    Given jid in job_status
    Given a job has completed successfully
    Given an archive has been uploaded to a vault
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive is deleted from a vault then an empty vault is deleted
    Given jid in job_status
    Given a job has completed successfully
    Given an archive has been deleted from a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is initiated for a vault then an archive is uploaded to a vault
    Given jid in job_status
    Given a job has completed successfully
    Given a multipart upload has been initiated for a vault
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a part is uploaded for a multipart upload then an archive is deleted from a vault
    Given jid in job_status
    Given a job has completed successfully
    Given a part has been uploaded for a multipart upload
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is completed then a multipart upload is initiated for a vault
    Given jid in job_status
    Given a job has completed successfully
    Given a multipart upload has been completed
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a multipart upload is aborted then a part is uploaded for a multipart upload
    Given jid in job_status
    Given a job has completed successfully
    Given a multipart upload has been aborted
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then an archive retrieval job is initiated then a multipart upload is completed
    Given jid in job_status
    Given a job has completed successfully
    Given an archive retrieval job has been initiated
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault inventory retrieval job is initiated then a multipart upload is aborted
    Given jid in job_status
    Given a job has completed successfully
    Given a vault inventory retrieval job has been initiated
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a job fails then an archive retrieval job is initiated
    Given jid in job_status
    Given a job has completed successfully
    Given a job has failed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given a job has completed successfully
    Given the output of a succeeded job has been retrieved
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job completes successfully then a vault inventory is refreshed then a job fails
    Given jid in job_status
    Given a job has completed successfully
    Given a vault inventory has been refreshed
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault is created then a vault inventory is refreshed
    Given jid in job_status
    Given a job has failed
    Given a vault has been created
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an empty vault is deleted then a vault is created
    Given jid in job_status
    Given a job has failed
    Given an empty vault has been deleted
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive is uploaded to a vault then an empty vault is deleted
    Given jid in job_status
    Given a job has failed
    Given an archive has been uploaded to a vault
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive is deleted from a vault then an archive is uploaded to a vault
    Given jid in job_status
    Given a job has failed
    Given an archive has been deleted from a vault
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is initiated for a vault then an archive is deleted from a vault
    Given jid in job_status
    Given a job has failed
    Given a multipart upload has been initiated for a vault
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a part is uploaded for a multipart upload then a multipart upload is initiated for a vault
    Given jid in job_status
    Given a job has failed
    Given a part has been uploaded for a multipart upload
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is completed then a part is uploaded for a multipart upload
    Given jid in job_status
    Given a job has failed
    Given a multipart upload has been completed
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a multipart upload is aborted then a multipart upload is completed
    Given jid in job_status
    Given a job has failed
    Given a multipart upload has been aborted
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then an archive retrieval job is initiated then a multipart upload is aborted
    Given jid in job_status
    Given a job has failed
    Given an archive retrieval job has been initiated
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault inventory retrieval job is initiated then an archive retrieval job is initiated
    Given jid in job_status
    Given a job has failed
    Given a vault inventory retrieval job has been initiated
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a job completes successfully then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given a job has failed
    Given a job has completed successfully
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then the output of a succeeded job is retrieved then a job completes successfully
    Given jid in job_status
    Given a job has failed
    Given the output of a succeeded job has been retrieved
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a job fails then a vault inventory is refreshed then the output of a succeeded job is retrieved
    Given jid in job_status
    Given a job has failed
    Given a vault inventory has been refreshed
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault is created then an empty vault is deleted
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a vault has been created
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an empty vault is deleted then an archive is uploaded to a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given an empty vault has been deleted
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is uploaded to a vault then an archive is deleted from a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given an archive has been uploaded to a vault
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given an archive has been deleted from a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a multipart upload has been initiated for a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart upload then a multipart upload is completed
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a part has been uploaded for a multipart upload
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is completed then a multipart upload is aborted
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a multipart upload has been completed
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is aborted then an archive retrieval job is initiated
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a multipart upload has been aborted
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given an archive retrieval job has been initiated
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated then a job completes successfully
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a vault inventory retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a job completes successfully then a job fails
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a job has completed successfully
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a job fails then a vault inventory is refreshed
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a job has failed
    When a vault inventory is refreshed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory is refreshed then a vault is created
    Given jid in job_status
    Given the output of a succeeded job has been retrieved
    Given a vault inventory has been refreshed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a vault is created then an archive is uploaded to a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a vault has been created
    When an archive is uploaded to a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an empty vault is deleted then an archive is deleted from a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given an empty vault has been deleted
    When an archive is deleted from a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given an archive has been uploaded to a vault
    When a multipart upload is initiated for a vault
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given an archive has been deleted from a vault
    When a part is uploaded for a multipart upload
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a multipart upload has been initiated for a vault
    When a multipart upload is completed
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a part has been uploaded for a multipart upload
    When a multipart upload is aborted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is completed then an archive retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a multipart upload has been completed
    When an archive retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a multipart upload has been aborted
    When a vault inventory retrieval job is initiated
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given an archive retrieval job has been initiated
    When a job completes successfully
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a vault inventory retrieval job has been initiated
    When a job fails
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a job completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a job has completed successfully
    When the output of a succeeded job is retrieved
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then a job fails then a vault is created
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given a job has failed
    When a vault is created
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a vault inventory is refreshed then the output of a succeeded job is retrieved then an empty vault is deleted
    Given vault in vault_status
    Given a vault inventory has been refreshed
    Given the output of a succeeded job has been retrieved
    When an empty vault is deleted
    Then every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"
