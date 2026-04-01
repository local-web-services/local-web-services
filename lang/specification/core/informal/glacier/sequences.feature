@glacier @generated
Feature: Glacier - Action Sequences

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "glacier" "vault" is created then an empty "glacier" "vault" is deleted
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a part is uploaded for a multipart "glacier" "upload"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is completed
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is aborted
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" retrieval job is initiated
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" inventory retrieval job is initiated
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "job" completes successfully
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "job" fails
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then the output of a succeeded job is retrieved
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" inventory is refreshed
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "job" completes successfully
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "job" fails
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" is created
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "job" fails
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" is created
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then an empty "glacier" "vault" is deleted
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is completed
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is aborted
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "job" completes successfully
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "job" fails
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then the output of a succeeded job is retrieved
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory is refreshed
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" is created
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then an empty "glacier" "vault" is deleted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a part is uploaded for a multipart "glacier" "upload"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is aborted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "job" completes successfully
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "job" fails
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" inventory is refreshed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" is created
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then an empty "glacier" "vault" is deleted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a part is uploaded for a multipart "glacier" "upload"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is completed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "job" completes successfully
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "job" fails
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory is refreshed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" is created
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "job" fails
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then the output of a succeeded job is retrieved
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" is created
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When a "glacier" "job" fails
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When a "glacier" "job" fails
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "job" completes successfully
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then the output of a succeeded job is retrieved
    Given jid in job_status
    When a "glacier" "job" fails
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" is created
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "job" completes successfully
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "job" fails
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then an empty "glacier" "vault" is deleted then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is completed
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is aborted
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a multipart "glacier" "upload" is aborted then a "glacier" "archive" retrieval job is initiated
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory retrieval job is initiated
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" completes successfully
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "job" completes successfully then a "glacier" "job" fails
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "job" completes successfully
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "job" fails then the output of a succeeded job is retrieved
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "job" fails
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then the output of a succeeded job is retrieved then a "glacier" "vault" inventory is refreshed
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" is created then a "glacier" "vault" inventory is refreshed then an empty "glacier" "vault" is deleted
    Given vault not in vault_status
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory is refreshed
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" is created then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" is deleted from a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is completed then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "archive" retrieval job is initiated then a "glacier" "job" completes successfully
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" fails
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "job" completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "job" fails then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then the output of a succeeded job is retrieved then a "glacier" "vault" is created
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" is created then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then an empty "glacier" "vault" is deleted then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is completed then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is aborted then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" completes successfully then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" fails then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" fails
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then the output of a succeeded job is retrieved then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When the output of a succeeded job is retrieved
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" is created then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" is created
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is completed then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is aborted then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" completes successfully then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" fails then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" fails
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then the output of a succeeded job is retrieved then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" is created then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then an empty "glacier" "vault" is deleted then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is completed then a "glacier" "job" fails
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is aborted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is aborted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" is created
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "job" completes successfully then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "job" completes successfully
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "job" fails then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "job" fails
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then the output of a succeeded job is retrieved then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" inventory is refreshed then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" is created then a multipart "glacier" "upload" is aborted
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" is created
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then an empty "glacier" "vault" is deleted then a "glacier" "archive" retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory retrieval job is initiated
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" completes successfully
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "job" fails
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is completed then the output of a succeeded job is retrieved
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is completed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory is refreshed
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" is created
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory retrieval job is initiated then an empty "glacier" "vault" is deleted
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "job" completes successfully then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "job" fails then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "job" fails
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then the output of a succeeded job is retrieved then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is completed
    Given upload in upload_status
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" is created then a "glacier" "archive" retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" is created
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" completes successfully
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "job" fails
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" inventory is refreshed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is aborted then a "glacier" "vault" is created
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "archive" retrieval job is initiated then an empty "glacier" "vault" is deleted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "job" completes successfully then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "job" fails then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then the output of a succeeded job is retrieved then a part is uploaded for a multipart "glacier" "upload"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is completed then a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is aborted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is completed
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" is created then a "glacier" "vault" inventory retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then an empty "glacier" "vault" is deleted then a "glacier" "job" completes successfully
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "job" fails
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" is deleted from a "glacier" "vault" then the output of a succeeded job is retrieved
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "vault" is created
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is completed then an empty "glacier" "vault" is deleted
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is completed
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "archive" retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "job" completes successfully then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "job" fails then a part is uploaded for a multipart "glacier" "upload"
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "job" fails
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then the output of a succeeded job is retrieved then a multipart "glacier" "upload" is completed
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory is refreshed then a "glacier" "archive" retrieval job is initiated
    Given upload_id in upload_status
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" is created then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" is created
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then an empty "glacier" "vault" is deleted then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault" then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a part is uploaded for a multipart "glacier" "upload" then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a part is uploaded for a multipart "glacier" "upload"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is completed then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is aborted then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "job" completes successfully then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" completes successfully
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "job" fails then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then the output of a succeeded job is retrieved then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory is refreshed then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" is created then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" is created
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then an empty "glacier" "vault" is deleted then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When an empty "glacier" "vault" is deleted
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" inventory is refreshed
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is completed then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" retrieval job is initiated then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" retrieval job is initiated
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" completes successfully then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" fails then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then the output of a succeeded job is retrieved then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "vault" inventory is refreshed then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" is created then the output of a succeeded job is retrieved
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" is created
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then an empty "glacier" "vault" is deleted then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "vault" is created
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" is deleted from a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a part is uploaded for a multipart "glacier" "upload" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a part is uploaded for a multipart "glacier" "upload"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a multipart "glacier" "upload" is aborted then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a multipart "glacier" "upload" is aborted
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" inventory retrieval job is initiated then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "job" fails then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "job" fails
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then the output of a succeeded job is retrieved then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" completes successfully then a "glacier" "vault" inventory is refreshed then a "glacier" "job" fails
    Given jid in job_status
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" is created then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" is created
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then an empty "glacier" "vault" is deleted then a "glacier" "vault" is created
    Given jid in job_status
    When a "glacier" "job" fails
    When an empty "glacier" "vault" is deleted
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" is uploaded to a "glacier" "vault" then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" is deleted from a "glacier" "vault" then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When a "glacier" "job" fails
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is completed then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is completed
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a multipart "glacier" "upload" is aborted then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When a "glacier" "job" fails
    When a multipart "glacier" "upload" is aborted
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "archive" retrieval job is initiated then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "archive" retrieval job is initiated
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "job" completes successfully then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "job" completes successfully
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then the output of a succeeded job is retrieved then a "glacier" "job" completes successfully
    Given jid in job_status
    When a "glacier" "job" fails
    When the output of a succeeded job is retrieved
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "job" fails then a "glacier" "vault" inventory is refreshed then the output of a succeeded job is retrieved
    Given jid in job_status
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory is refreshed
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" is created then an empty "glacier" "vault" is deleted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" is created
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then an empty "glacier" "vault" is deleted then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" is uploaded to a "glacier" "vault" then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" is deleted from a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is completed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is completed then a multipart "glacier" "upload" is aborted
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is completed
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a multipart "glacier" "upload" is aborted then a "glacier" "archive" retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "archive" retrieval job is initiated then a "glacier" "vault" inventory retrieval job is initiated
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" completes successfully
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "job" completes successfully then a "glacier" "job" fails
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "job" completes successfully
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "job" fails then a "glacier" "vault" inventory is refreshed
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "job" fails
    When a "glacier" "vault" inventory is refreshed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: the output of a succeeded job is retrieved then a "glacier" "vault" inventory is refreshed then a "glacier" "vault" is created
    Given jid in job_status
    When the output of a succeeded job is retrieved
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "vault" is created then a "glacier" "archive" is uploaded to a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" is created
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then an empty "glacier" "vault" is deleted then a "glacier" "archive" is deleted from a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When an empty "glacier" "vault" is deleted
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is uploaded to a "glacier" "vault" then a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is uploaded to a "glacier" "vault"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" is deleted from a "glacier" "vault" then a part is uploaded for a multipart "glacier" "upload"
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" is deleted from a "glacier" "vault"
    When a part is uploaded for a multipart "glacier" "upload"
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is initiated for a "glacier" "vault" then a multipart "glacier" "upload" is completed
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    When a multipart "glacier" "upload" is completed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a part is uploaded for a multipart "glacier" "upload" then a multipart "glacier" "upload" is aborted
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a part is uploaded for a multipart "glacier" "upload"
    When a multipart "glacier" "upload" is aborted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is completed then a "glacier" "archive" retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is completed
    When a "glacier" "archive" retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a multipart "glacier" "upload" is aborted then a "glacier" "vault" inventory retrieval job is initiated
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a multipart "glacier" "upload" is aborted
    When a "glacier" "vault" inventory retrieval job is initiated
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "archive" retrieval job is initiated then a "glacier" "job" completes successfully
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "archive" retrieval job is initiated
    When a "glacier" "job" completes successfully
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "vault" inventory retrieval job is initiated then a "glacier" "job" fails
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "vault" inventory retrieval job is initiated
    When a "glacier" "job" fails
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "job" completes successfully then the output of a succeeded job is retrieved
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" completes successfully
    When the output of a succeeded job is retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then a "glacier" "job" fails then a "glacier" "vault" is created
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When a "glacier" "job" fails
    When a "glacier" "vault" is created
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @sequence
  Scenario: a "glacier" "vault" inventory is refreshed then the output of a succeeded job is retrieved then an empty "glacier" "vault" is deleted
    Given vault in vault_status
    When a "glacier" "vault" inventory is refreshed
    When the output of a succeeded job is retrieved
    When an empty "glacier" "vault" is deleted
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"
