@glacier @generated
Feature: Glacier - A Part Is Uploaded For A Multipart "Glacier" "Upload"

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @upload_multipart_part
  Scenario: a part is uploaded for a multipart "glacier" "upload"
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "upload" part has not already been uploaded
    When a part is uploaded for a multipart "glacier" "upload"
    Then the "glacier" "upload" part will be recorded
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @upload_multipart_part
  Scenario: a part is uploaded for a multipart "glacier" "upload" fails when the "glacier" "upload" did not exist
    Given the "glacier" "upload" did not exist
    When a part is uploaded for a multipart "glacier" "upload"
    Then the operation is rejected

  @guard @negative @upload_multipart_part @lifecycle
  Scenario: a part is uploaded for a multipart "glacier" "upload" fails when the "glacier" "upload" was not "InProgress"
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was not "InProgress"
    When a part is uploaded for a multipart "glacier" "upload"
    Then the operation is rejected

  @guard @negative @upload_multipart_part
  Scenario: a part is uploaded for a multipart "glacier" "upload" fails when the "glacier" "upload" part has already been uploaded
    Given the "glacier" "upload" existed
    And the "glacier" "upload" was "InProgress"
    And the "glacier" "upload" part has already been uploaded
    When a part is uploaded for a multipart "glacier" "upload"
    Then the operation is rejected
