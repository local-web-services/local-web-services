@glacier @generated
Feature: Glacier - A Multipart "Glacier" "Upload" Is Initiated For A "Glacier" "Vault"

  # Generated from FizzBee spec: glacier.fizz
  # Safety invariants: InProgressJobReferencesActiveVault, VaultArchiveCountNonNegative, ArchivesHaveActiveParentVault, JobOutputOnlyOnSuccess, ArchiveRetrievalJobHasArchive

  Background:
    Given the system is initialized

  @minimal @happy @initiate_multipart_upload
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "upload" did not already exist
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Then the "glacier" "upload" will be "InProgress"
    And every in-progress "glacier" "job" references an active "glacier" "vault"
    And "glacier" "vault" archive count is never negative
    And all stored "glacier" "archive"s belong to an "ACTIVE" "glacier" "vault"
    And "glacier" "job" output is only available for succeeded "glacier" "job"s
    And every "glacier" "archive" retrieval "glacier" "job" references a non-empty "glacier" "archive" "ID"

  @guard @negative @initiate_multipart_upload
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" fails when the "glacier" "vault" did not exist
    Given the "glacier" "vault" did not exist
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @initiate_multipart_upload @lifecycle
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" fails when the "glacier" "vault" was not "ACTIVE"
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was not "ACTIVE"
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Then the operation is rejected

  @guard @negative @initiate_multipart_upload
  Scenario: a multipart "glacier" "upload" is initiated for a "glacier" "vault" fails when the "glacier" "upload" already existed
    Given the "glacier" "vault" existed
    And the "glacier" "vault" was "ACTIVE"
    And the "glacier" "upload" already existed
    When a multipart "glacier" "upload" is initiated for a "glacier" "vault"
    Then the operation is rejected
