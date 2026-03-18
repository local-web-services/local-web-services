@s3tables @generated
Feature: S3tables - Compaction Is Started On A Table

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @start_compaction
  Scenario: compaction is started on a table
    Given the table exists
    And the table is "ACTIVE"
    And compaction is enabled for the table
    When compaction is started on a table
    Then the table enters "MAINTENANCE" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @start_compaction
  Scenario: compaction is started on a table fails when the table does not exist
    Given the table does not exist
    When compaction is started on a table
    Then the operation is rejected

  @standard @negative @start_compaction @lifecycle
  Scenario: compaction is started on a table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When compaction is started on a table
    Then the operation is rejected

  @standard @negative @start_compaction
  Scenario: compaction is started on a table fails when compaction is not enabled for the table
    Given the table exists
    And the table is "ACTIVE"
    And compaction is not enabled for the table
    When compaction is started on a table
    Then the operation is rejected
