@glacier @generated
Feature: Glacier - The Output Of A Succeeded Job Is Retrieved

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @get_job_output
  Scenario: the output of a succeeded job is retrieved
    Given the job exists
    And the job is Succeeded
    And the job output is available
    When the output of a succeeded job is retrieved
    Then the job output is marked as retrieved
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @guard @negative @get_job_output
  Scenario: the output of a succeeded job is retrieved fails when the job does not exist
    Given the job does not exist
    When the output of a succeeded job is retrieved
    Then the operation is rejected

  @guard @negative @get_job_output @lifecycle
  Scenario: the output of a succeeded job is retrieved fails when the job is not Succeeded
    Given the job exists
    And the job is not Succeeded
    When the output of a succeeded job is retrieved
    Then the operation is rejected

  @guard @negative @internal @get_job_output
  Scenario: the output of a succeeded job is retrieved fails when the job output is not available
    Given the job exists
    And the job is Succeeded
    And the job output is not available
    When the output of a succeeded job is retrieved
    Then the operation is rejected
