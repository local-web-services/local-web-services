@glacier @generated
Feature: Glacier - The Output Of A Succeeded "Glacier" "Job" Is Retrieved

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @get_job_output
  Scenario: the output of a succeeded "glacier" "job" is retrieved
    Given the "glacier" "job" existed
    And the "glacier" "job" was "Succeeded"
    And the "glacier" "job" output is available
    When the output of a succeeded "glacier" "job" is retrieved
    Then the "glacier" "job" output will be marked as retrieved
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @get_job_output
  Scenario: the output of a succeeded "glacier" "job" is retrieved fails when the "glacier" "job" did not exist
    Given the "glacier" "job" did not exist
    When the output of a succeeded "glacier" "job" is retrieved
    Then the operation is rejected

  @guard @negative @get_job_output @lifecycle
  Scenario: the output of a succeeded "glacier" "job" is retrieved fails when the "glacier" "job" was not "Succeeded"
    Given the "glacier" "job" existed
    And the "glacier" "job" was not "Succeeded"
    When the output of a succeeded "glacier" "job" is retrieved
    Then the operation is rejected

  @guard @negative @get_job_output
  Scenario: the output of a succeeded "glacier" "job" is retrieved fails when the "glacier" "job" output is not available
    Given the "glacier" "job" existed
    And the "glacier" "job" was "Succeeded"
    And the "glacier" "job" output is not available
    When the output of a succeeded "glacier" "job" is retrieved
    Then the operation is rejected
