@glacier @generated
Feature: Glacier - A "Glacier" "Job" Fails

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @job_fails @internal
  Scenario: a "glacier" "job" fails
    Given the "glacier" "job" existed
    And the "glacier" "job" was "InProgress"
    When a "glacier" "job" fails
    Then the "glacier" "JOB" will be "Failed"
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @job_fails @internal
  Scenario: a "glacier" "job" fails fails when the "glacier" "job" did not exist
    Given the "glacier" "job" did not exist
    When a "glacier" "job" fails
    Then the operation is rejected

  @guard @negative @job_fails @internal
  Scenario: a "glacier" "job" fails fails when the "glacier" "job" was not "InProgress"
    Given the "glacier" "job" existed
    And the "glacier" "job" was not "InProgress"
    When a "glacier" "job" fails
    Then the operation is rejected
