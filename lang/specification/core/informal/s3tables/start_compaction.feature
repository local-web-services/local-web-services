@s3tables @generated
Feature: S3tables - Compaction Is Started On A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @start_compaction
  Scenario: compaction is started on a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And compaction was "ENABLED" for the "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    Then the "s3 tables" "table" will be in "MAINTENANCE" state
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @start_compaction
  Scenario: compaction is started on a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When compaction is started on a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @start_compaction @lifecycle
  Scenario: compaction is started on a "s3 tables" "table" fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When compaction is started on a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @start_compaction
  Scenario: compaction is started on a "s3 tables" "table" fails when compaction was not "ENABLED" for the "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    And compaction was not "ENABLED" for the "s3 tables" "table"
    When compaction is started on a "s3 tables" "table"
    Then the operation is rejected
