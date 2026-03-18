@s3tables @generated
Feature: S3tables - Compaction Finishes On A Table

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_compaction @internal
  Scenario: compaction finishes on a table
    Given the table exists
    And the table is in "MAINTENANCE" state
    When compaction finishes on a table
    Then the table returns to "ACTIVE" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @finish_compaction @internal
  Scenario: compaction finishes on a table fails when the table does not exist
    Given the table does not exist
    When compaction finishes on a table
    Then the operation is rejected

  @standard @negative @finish_compaction @internal
  Scenario: compaction finishes on a table fails when the table is not in "MAINTENANCE" state
    Given the table exists
    And the table is not in "MAINTENANCE" state
    When compaction finishes on a table
    Then the operation is rejected
