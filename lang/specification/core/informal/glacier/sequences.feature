@glacier @generated
Feature: Glacier - Action Sequences

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a vault is created then an empty vault is deleted
    Given vault not in vault_status
    When a vault is created
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive is uploaded to a vault
    Given vault not in vault_status
    When a vault is created
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive is deleted from a vault
    Given vault not in vault_status
    When a vault is created
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is initiated for a vault
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a part is uploaded for a multipart upload
    Given vault not in vault_status
    When a vault is created
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is completed
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is aborted
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive retrieval job is initiated
    Given vault not in vault_status
    When a vault is created
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a vault inventory retrieval job is initiated
    Given vault not in vault_status
    When a vault is created
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a job completes successfully
    Given vault not in vault_status
    When a vault is created
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a job fails
    Given vault not in vault_status
    When a vault is created
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then the output of a succeeded job is retrieved
    Given vault not in vault_status
    When a vault is created
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a vault inventory is refreshed
    Given vault not in vault_status
    When a vault is created
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault is created
    Given vault in vault_status
    When an empty vault is deleted
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive is uploaded to a vault
    Given vault in vault_status
    When an empty vault is deleted
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive is deleted from a vault
    Given vault in vault_status
    When an empty vault is deleted
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an empty vault is deleted
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is completed
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is aborted
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive retrieval job is initiated
    Given vault in vault_status
    When an empty vault is deleted
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an empty vault is deleted
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a job completes successfully
    Given vault in vault_status
    When an empty vault is deleted
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a job fails
    Given vault in vault_status
    When an empty vault is deleted
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an empty vault is deleted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault inventory is refreshed
    Given vault in vault_status
    When an empty vault is deleted
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault is created
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an empty vault is deleted
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an archive is deleted from a vault
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is completed
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is aborted
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an archive retrieval job is initiated
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a job completes successfully
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a job fails
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive is uploaded to a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory is refreshed
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault is created
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an empty vault is deleted
    Given vault in vault_status
    When an archive is deleted from a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an archive is uploaded to a vault
    Given vault in vault_status
    When an archive is deleted from a vault
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive is deleted from a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is completed
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is aborted
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an archive retrieval job is initiated
    Given vault in vault_status
    When an archive is deleted from a vault
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a job completes successfully
    Given vault in vault_status
    When an archive is deleted from a vault
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a job fails
    Given vault in vault_status
    When an archive is deleted from a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive is deleted from a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault inventory is refreshed
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault is created
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an empty vault is deleted
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is uploaded to a vault
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is deleted from a vault
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is aborted
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive retrieval job is initiated
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a job completes successfully
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a job fails
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory is refreshed
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault is created
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an empty vault is deleted
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is uploaded to a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is deleted from a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated for a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a job completes successfully
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a job fails
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then the output of a succeeded job is retrieved
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory is refreshed
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault is created
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an empty vault is deleted
    Given upload_id in upload_status
    When a multipart upload is completed
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive is uploaded to a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive is deleted from a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    When a multipart upload is completed
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted
    Given upload_id in upload_status
    When a multipart upload is completed
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a job completes successfully
    Given upload_id in upload_status
    When a multipart upload is completed
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a job fails
    Given upload_id in upload_status
    When a multipart upload is completed
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart upload is completed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault inventory is refreshed
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault is created
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an empty vault is deleted
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive is uploaded to a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive is deleted from a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a job completes successfully
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a job fails
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart upload is aborted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault inventory is refreshed
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault is created
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an empty vault is deleted
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an archive is uploaded to a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an archive is deleted from a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is completed
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is aborted
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a job fails
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault is created
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an empty vault is deleted
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is uploaded to a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is deleted from a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is completed
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is aborted
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive retrieval job is initiated
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault is created
    Given jid in job_status
    When a job completes successfully
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an empty vault is deleted
    Given jid in job_status
    When a job completes successfully
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive is uploaded to a vault
    Given jid in job_status
    When a job completes successfully
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive is deleted from a vault
    Given jid in job_status
    When a job completes successfully
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is initiated for a vault
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a part is uploaded for a multipart upload
    Given jid in job_status
    When a job completes successfully
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is completed
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is aborted
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive retrieval job is initiated
    Given jid in job_status
    When a job completes successfully
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault inventory retrieval job is initiated
    Given jid in job_status
    When a job completes successfully
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a job fails
    Given jid in job_status
    When a job completes successfully
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then the output of a succeeded job is retrieved
    Given jid in job_status
    When a job completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault inventory is refreshed
    Given jid in job_status
    When a job completes successfully
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault is created
    Given jid in job_status
    When a job fails
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an empty vault is deleted
    Given jid in job_status
    When a job fails
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive is uploaded to a vault
    Given jid in job_status
    When a job fails
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive is deleted from a vault
    Given jid in job_status
    When a job fails
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is initiated for a vault
    Given jid in job_status
    When a job fails
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a part is uploaded for a multipart upload
    Given jid in job_status
    When a job fails
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is completed
    Given jid in job_status
    When a job fails
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is aborted
    Given jid in job_status
    When a job fails
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive retrieval job is initiated
    Given jid in job_status
    When a job fails
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault inventory retrieval job is initiated
    Given jid in job_status
    When a job fails
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a job completes successfully
    Given jid in job_status
    When a job fails
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then the output of a succeeded job is retrieved
    Given jid in job_status
    When a job fails
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault inventory is refreshed
    Given jid in job_status
    When a job fails
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault is created
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an empty vault is deleted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is uploaded to a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is deleted from a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is initiated for a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart upload
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is completed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is aborted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a job completes successfully
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a job fails
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory is refreshed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a vault is created
    Given vault in vault_status
    When a vault inventory is refreshed
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an empty vault is deleted
    Given vault in vault_status
    When a vault inventory is refreshed
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive is uploaded to a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive is deleted from a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is initiated for a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a vault inventory is refreshed
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is completed
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is aborted
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive retrieval job is initiated
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When a vault inventory is refreshed
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a job completes successfully
    Given vault in vault_status
    When a vault inventory is refreshed
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a job fails
    Given vault in vault_status
    When a vault inventory is refreshed
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a vault inventory is refreshed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an empty vault is deleted then an archive is uploaded to a vault
    Given vault not in vault_status
    When a vault is created
    When an empty vault is deleted
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive is uploaded to a vault then an archive is deleted from a vault
    Given vault not in vault_status
    When a vault is created
    When an archive is uploaded to a vault
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given vault not in vault_status
    When a vault is created
    When an archive is deleted from a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is initiated for a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a part is uploaded for a multipart upload then a multipart upload is completed
    Given vault not in vault_status
    When a vault is created
    When a part is uploaded for a multipart upload
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is completed then a multipart upload is aborted
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is completed
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a multipart upload is aborted then an archive retrieval job is initiated
    Given vault not in vault_status
    When a vault is created
    When a multipart upload is aborted
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given vault not in vault_status
    When a vault is created
    When an archive retrieval job is initiated
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a vault inventory retrieval job is initiated then a job completes successfully
    Given vault not in vault_status
    When a vault is created
    When a vault inventory retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a job completes successfully then a job fails
    Given vault not in vault_status
    When a vault is created
    When a job completes successfully
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a job fails then the output of a succeeded job is retrieved
    Given vault not in vault_status
    When a vault is created
    When a job fails
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then the output of a succeeded job is retrieved then a vault inventory is refreshed
    Given vault not in vault_status
    When a vault is created
    When the output of a succeeded job is retrieved
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault is created then a vault inventory is refreshed then an empty vault is deleted
    Given vault not in vault_status
    When a vault is created
    When a vault inventory is refreshed
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault is created then an archive is deleted from a vault
    Given vault in vault_status
    When an empty vault is deleted
    When a vault is created
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an empty vault is deleted
    When an archive is uploaded to a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an empty vault is deleted
    When an archive is deleted from a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is initiated for a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given vault in vault_status
    When an empty vault is deleted
    When a part is uploaded for a multipart upload
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is completed then an archive retrieval job is initiated
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is completed
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an empty vault is deleted
    When a multipart upload is aborted
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    When an empty vault is deleted
    When an archive retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    When an empty vault is deleted
    When a vault inventory retrieval job is initiated
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a job completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an empty vault is deleted
    When a job completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a job fails then a vault inventory is refreshed
    Given vault in vault_status
    When an empty vault is deleted
    When a job fails
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then the output of a succeeded job is retrieved then a vault is created
    Given vault in vault_status
    When an empty vault is deleted
    When the output of a succeeded job is retrieved
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an empty vault is deleted then a vault inventory is refreshed then an archive is uploaded to a vault
    Given vault in vault_status
    When an empty vault is deleted
    When a vault inventory is refreshed
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault is created then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault is created
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an empty vault is deleted then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an empty vault is deleted
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an archive is deleted from a vault then a multipart upload is completed
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an archive is deleted from a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is initiated for a vault then a multipart upload is aborted
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is initiated for a vault
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a part is uploaded for a multipart upload then an archive retrieval job is initiated
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a part is uploaded for a multipart upload
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is completed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is completed
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a multipart upload is aborted then a job completes successfully
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a multipart upload is aborted
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then an archive retrieval job is initiated then a job fails
    Given vault in vault_status
    When an archive is uploaded to a vault
    When an archive retrieval job is initiated
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a job completes successfully then a vault inventory is refreshed
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a job completes successfully
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a job fails then a vault is created
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a job fails
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then the output of a succeeded job is retrieved then an empty vault is deleted
    Given vault in vault_status
    When an archive is uploaded to a vault
    When the output of a succeeded job is retrieved
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is uploaded to a vault then a vault inventory is refreshed then an archive is deleted from a vault
    Given vault in vault_status
    When an archive is uploaded to a vault
    When a vault inventory is refreshed
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault is created then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault is created
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an empty vault is deleted then a multipart upload is completed
    Given vault in vault_status
    When an archive is deleted from a vault
    When an empty vault is deleted
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an archive is uploaded to a vault then a multipart upload is aborted
    Given vault in vault_status
    When an archive is deleted from a vault
    When an archive is uploaded to a vault
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is initiated for a vault then an archive retrieval job is initiated
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is initiated for a vault
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive is deleted from a vault
    When a part is uploaded for a multipart upload
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is completed then a job completes successfully
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is completed
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a multipart upload is aborted then a job fails
    Given vault in vault_status
    When an archive is deleted from a vault
    When a multipart upload is aborted
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then an archive retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive is deleted from a vault
    When an archive retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault inventory retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault inventory retrieval job is initiated
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a job completes successfully then a vault is created
    Given vault in vault_status
    When an archive is deleted from a vault
    When a job completes successfully
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a job fails then an empty vault is deleted
    Given vault in vault_status
    When an archive is deleted from a vault
    When a job fails
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then the output of a succeeded job is retrieved then an archive is uploaded to a vault
    Given vault in vault_status
    When an archive is deleted from a vault
    When the output of a succeeded job is retrieved
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive is deleted from a vault then a vault inventory is refreshed then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive is deleted from a vault
    When a vault inventory is refreshed
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault is created then a multipart upload is completed
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault is created
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an empty vault is deleted then a multipart upload is aborted
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an empty vault is deleted
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is uploaded to a vault then an archive retrieval job is initiated
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive is uploaded to a vault
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive is deleted from a vault then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive is deleted from a vault
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a part is uploaded for a multipart upload then a job completes successfully
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a part is uploaded for a multipart upload
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is completed then a job fails
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a multipart upload is completed
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a multipart upload is aborted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a multipart upload is aborted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then an archive retrieval job is initiated then a vault inventory is refreshed
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When an archive retrieval job is initiated
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory retrieval job is initiated then a vault is created
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault inventory retrieval job is initiated
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a job completes successfully then an empty vault is deleted
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a job completes successfully
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a job fails then an archive is uploaded to a vault
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a job fails
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then the output of a succeeded job is retrieved then an archive is deleted from a vault
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When the output of a succeeded job is retrieved
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is initiated for a vault then a vault inventory is refreshed then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a multipart upload is initiated for a vault
    When a vault inventory is refreshed
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault is created then a multipart upload is aborted
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault is created
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an empty vault is deleted then an archive retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an empty vault is deleted
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is uploaded to a vault then a vault inventory retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive is uploaded to a vault
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive is deleted from a vault then a job completes successfully
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive is deleted from a vault
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is initiated for a vault then a job fails
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is initiated for a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is completed then the output of a succeeded job is retrieved
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is completed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a multipart upload is aborted then a vault inventory is refreshed
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a multipart upload is aborted
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then an archive retrieval job is initiated then a vault is created
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When an archive retrieval job is initiated
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory retrieval job is initiated then an empty vault is deleted
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault inventory retrieval job is initiated
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a job completes successfully then an archive is uploaded to a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a job completes successfully
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a job fails then an archive is deleted from a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a job fails
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then the output of a succeeded job is retrieved then a multipart upload is initiated for a vault
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When the output of a succeeded job is retrieved
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a part is uploaded for a multipart upload then a vault inventory is refreshed then a multipart upload is completed
    Given upload in upload_status
    When a part is uploaded for a multipart upload
    When a vault inventory is refreshed
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault is created then an archive retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault is created
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an empty vault is deleted then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is completed
    When an empty vault is deleted
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive is uploaded to a vault then a job completes successfully
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive is uploaded to a vault
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive is deleted from a vault then a job fails
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive is deleted from a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is initiated for a vault then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart upload is completed
    When a multipart upload is initiated for a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a part is uploaded for a multipart upload then a vault inventory is refreshed
    Given upload_id in upload_status
    When a multipart upload is completed
    When a part is uploaded for a multipart upload
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a multipart upload is aborted then a vault is created
    Given upload_id in upload_status
    When a multipart upload is completed
    When a multipart upload is aborted
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then an archive retrieval job is initiated then an empty vault is deleted
    Given upload_id in upload_status
    When a multipart upload is completed
    When an archive retrieval job is initiated
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault inventory retrieval job is initiated then an archive is uploaded to a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault inventory retrieval job is initiated
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a job completes successfully then an archive is deleted from a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When a job completes successfully
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a job fails then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    When a multipart upload is completed
    When a job fails
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then the output of a succeeded job is retrieved then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    When a multipart upload is completed
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is completed then a vault inventory is refreshed then a multipart upload is aborted
    Given upload_id in upload_status
    When a multipart upload is completed
    When a vault inventory is refreshed
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault is created then a vault inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault is created
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an empty vault is deleted then a job completes successfully
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an empty vault is deleted
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive is uploaded to a vault then a job fails
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive is uploaded to a vault
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive is deleted from a vault then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive is deleted from a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is initiated for a vault then a vault inventory is refreshed
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a multipart upload is initiated for a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a part is uploaded for a multipart upload then a vault is created
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a part is uploaded for a multipart upload
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a multipart upload is completed then an empty vault is deleted
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a multipart upload is completed
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then an archive retrieval job is initiated then an archive is uploaded to a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When an archive retrieval job is initiated
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault inventory retrieval job is initiated then an archive is deleted from a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault inventory retrieval job is initiated
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a job completes successfully then a multipart upload is initiated for a vault
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a job completes successfully
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a job fails then a part is uploaded for a multipart upload
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a job fails
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then the output of a succeeded job is retrieved then a multipart upload is completed
    Given upload_id in upload_status
    When a multipart upload is aborted
    When the output of a succeeded job is retrieved
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a multipart upload is aborted then a vault inventory is refreshed then an archive retrieval job is initiated
    Given upload_id in upload_status
    When a multipart upload is aborted
    When a vault inventory is refreshed
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault is created then a job completes successfully
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault is created
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an empty vault is deleted then a job fails
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an empty vault is deleted
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an archive is uploaded to a vault then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an archive is uploaded to a vault
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then an archive is deleted from a vault then a vault inventory is refreshed
    Given vault in vault_status
    When an archive retrieval job is initiated
    When an archive is deleted from a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is initiated for a vault then a vault is created
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is initiated for a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a part is uploaded for a multipart upload then an empty vault is deleted
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a part is uploaded for a multipart upload
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is completed then an archive is uploaded to a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is completed
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a multipart upload is aborted then an archive is deleted from a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a multipart upload is aborted
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault inventory retrieval job is initiated
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a job completes successfully then a part is uploaded for a multipart upload
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a job completes successfully
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a job fails then a multipart upload is completed
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a job fails
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then the output of a succeeded job is retrieved then a multipart upload is aborted
    Given vault in vault_status
    When an archive retrieval job is initiated
    When the output of a succeeded job is retrieved
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: an archive retrieval job is initiated then a vault inventory is refreshed then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When an archive retrieval job is initiated
    When a vault inventory is refreshed
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault is created then a job fails
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a vault is created
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an empty vault is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an empty vault is deleted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is uploaded to a vault then a vault inventory is refreshed
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive is uploaded to a vault
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive is deleted from a vault then a vault is created
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive is deleted from a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is initiated for a vault then an empty vault is deleted
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is initiated for a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a part is uploaded for a multipart upload then an archive is uploaded to a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a part is uploaded for a multipart upload
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is completed then an archive is deleted from a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is completed
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a multipart upload is aborted then a multipart upload is initiated for a vault
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a multipart upload is aborted
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then an archive retrieval job is initiated then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When an archive retrieval job is initiated
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a job completes successfully then a multipart upload is completed
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a job completes successfully
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a job fails then a multipart upload is aborted
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a job fails
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then the output of a succeeded job is retrieved then an archive retrieval job is initiated
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory retrieval job is initiated then a vault inventory is refreshed then a job completes successfully
    Given vault in vault_status
    When a vault inventory retrieval job is initiated
    When a vault inventory is refreshed
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault is created then the output of a succeeded job is retrieved
    Given jid in job_status
    When a job completes successfully
    When a vault is created
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an empty vault is deleted then a vault inventory is refreshed
    Given jid in job_status
    When a job completes successfully
    When an empty vault is deleted
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive is uploaded to a vault then a vault is created
    Given jid in job_status
    When a job completes successfully
    When an archive is uploaded to a vault
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive is deleted from a vault then an empty vault is deleted
    Given jid in job_status
    When a job completes successfully
    When an archive is deleted from a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is initiated for a vault then an archive is uploaded to a vault
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is initiated for a vault
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a part is uploaded for a multipart upload then an archive is deleted from a vault
    Given jid in job_status
    When a job completes successfully
    When a part is uploaded for a multipart upload
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is completed then a multipart upload is initiated for a vault
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is completed
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a multipart upload is aborted then a part is uploaded for a multipart upload
    Given jid in job_status
    When a job completes successfully
    When a multipart upload is aborted
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then an archive retrieval job is initiated then a multipart upload is completed
    Given jid in job_status
    When a job completes successfully
    When an archive retrieval job is initiated
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault inventory retrieval job is initiated then a multipart upload is aborted
    Given jid in job_status
    When a job completes successfully
    When a vault inventory retrieval job is initiated
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a job fails then an archive retrieval job is initiated
    Given jid in job_status
    When a job completes successfully
    When a job fails
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated
    Given jid in job_status
    When a job completes successfully
    When the output of a succeeded job is retrieved
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job completes successfully then a vault inventory is refreshed then a job fails
    Given jid in job_status
    When a job completes successfully
    When a vault inventory is refreshed
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault is created then a vault inventory is refreshed
    Given jid in job_status
    When a job fails
    When a vault is created
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an empty vault is deleted then a vault is created
    Given jid in job_status
    When a job fails
    When an empty vault is deleted
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive is uploaded to a vault then an empty vault is deleted
    Given jid in job_status
    When a job fails
    When an archive is uploaded to a vault
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive is deleted from a vault then an archive is uploaded to a vault
    Given jid in job_status
    When a job fails
    When an archive is deleted from a vault
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is initiated for a vault then an archive is deleted from a vault
    Given jid in job_status
    When a job fails
    When a multipart upload is initiated for a vault
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a part is uploaded for a multipart upload then a multipart upload is initiated for a vault
    Given jid in job_status
    When a job fails
    When a part is uploaded for a multipart upload
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is completed then a part is uploaded for a multipart upload
    Given jid in job_status
    When a job fails
    When a multipart upload is completed
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a multipart upload is aborted then a multipart upload is completed
    Given jid in job_status
    When a job fails
    When a multipart upload is aborted
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then an archive retrieval job is initiated then a multipart upload is aborted
    Given jid in job_status
    When a job fails
    When an archive retrieval job is initiated
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault inventory retrieval job is initiated then an archive retrieval job is initiated
    Given jid in job_status
    When a job fails
    When a vault inventory retrieval job is initiated
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a job completes successfully then a vault inventory retrieval job is initiated
    Given jid in job_status
    When a job fails
    When a job completes successfully
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then the output of a succeeded job is retrieved then a job completes successfully
    Given jid in job_status
    When a job fails
    When the output of a succeeded job is retrieved
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a job fails then a vault inventory is refreshed then the output of a succeeded job is retrieved
    Given jid in job_status
    When a job fails
    When a vault inventory is refreshed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault is created then an empty vault is deleted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault is created
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an empty vault is deleted then an archive is uploaded to a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an empty vault is deleted
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is uploaded to a vault then an archive is deleted from a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive is uploaded to a vault
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive is deleted from a vault then a multipart upload is initiated for a vault
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive is deleted from a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is initiated for a vault then a part is uploaded for a multipart upload
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is initiated for a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart upload then a multipart upload is completed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart upload
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is completed then a multipart upload is aborted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is completed
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart upload is aborted then an archive retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart upload is aborted
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then an archive retrieval job is initiated then a vault inventory retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an archive retrieval job is initiated
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory retrieval job is initiated then a job completes successfully
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault inventory retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a job completes successfully then a job fails
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a job completes successfully
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a job fails then a vault inventory is refreshed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a job fails
    When a vault inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: the output of a succeeded job is retrieved then a vault inventory is refreshed then a vault is created
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a vault inventory is refreshed
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a vault is created then an archive is uploaded to a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When a vault is created
    When an archive is uploaded to a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an empty vault is deleted then an archive is deleted from a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When an empty vault is deleted
    When an archive is deleted from a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive is uploaded to a vault then a multipart upload is initiated for a vault
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive is uploaded to a vault
    When a multipart upload is initiated for a vault
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive is deleted from a vault then a part is uploaded for a multipart upload
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive is deleted from a vault
    When a part is uploaded for a multipart upload
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is initiated for a vault then a multipart upload is completed
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is initiated for a vault
    When a multipart upload is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a part is uploaded for a multipart upload then a multipart upload is aborted
    Given vault in vault_status
    When a vault inventory is refreshed
    When a part is uploaded for a multipart upload
    When a multipart upload is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is completed then an archive retrieval job is initiated
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is completed
    When an archive retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a multipart upload is aborted then a vault inventory retrieval job is initiated
    Given vault in vault_status
    When a vault inventory is refreshed
    When a multipart upload is aborted
    When a vault inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then an archive retrieval job is initiated then a job completes successfully
    Given vault in vault_status
    When a vault inventory is refreshed
    When an archive retrieval job is initiated
    When a job completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a vault inventory retrieval job is initiated then a job fails
    Given vault in vault_status
    When a vault inventory is refreshed
    When a vault inventory retrieval job is initiated
    When a job fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a job completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a vault inventory is refreshed
    When a job completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then a job fails then a vault is created
    Given vault in vault_status
    When a vault inventory is refreshed
    When a job fails
    When a vault is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @exhaustive @sequence
  Scenario: a vault inventory is refreshed then the output of a succeeded job is retrieved then an empty vault is deleted
    Given vault in vault_status
    When a vault inventory is refreshed
    When the output of a succeeded job is retrieved
    When an empty vault is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"
