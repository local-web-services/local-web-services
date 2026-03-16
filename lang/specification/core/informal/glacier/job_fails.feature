@glacier @generated
Feature: Glacier - A Job Fails

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @job_fails @internal
  Scenario: a job fails
    Given the job exists
    And the job is InProgress
    When a job fails
    Then the job is Failed
    And every in-progress job references an active vault
    And vault archive count is never negative
    And all stored archives belong to an "ACTIVE" vault
    And job output is only available for succeeded jobs
    And every archive retrieval job references a non-empty archive "ID"

  @standard @negative @job_fails @internal
  Scenario: a job fails fails when the job does not exist
    Given the job does not exist
    When a job fails
    Then the operation is rejected

  @standard @negative @job_fails @internal
  Scenario: a job fails fails when the job is not InProgress
    Given the job exists
    And the job is not InProgress
    When a job fails
    Then the operation is rejected
