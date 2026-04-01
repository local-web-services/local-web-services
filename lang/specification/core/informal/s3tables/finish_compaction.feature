@s3tables @generated
Feature: S3tables - Compaction Finishes On A "S3 Tables" "Table"

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_compaction @internal
  Scenario: compaction finishes on a "s3 tables" "table"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was in "MAINTENANCE" state
    When compaction finishes on a "s3 tables" "table"
    Then the "s3 tables" "table" returns to "ACTIVE" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @finish_compaction @internal
  Scenario: compaction finishes on a "s3 tables" "table" fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When compaction finishes on a "s3 tables" "table"
    Then the operation is rejected

  @guard @negative @finish_compaction @internal
  Scenario: compaction finishes on a "s3 tables" "table" fails when the "s3 tables" "table" is not in "MAINTENANCE" state
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" is not in "MAINTENANCE" state
    When compaction finishes on a "s3 tables" "table"
    Then the operation is rejected
