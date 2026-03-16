@s3tables @generated
Feature: S3tables - A Snapshot Is Created For A Table

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_snapshot
  Scenario: a snapshot is created for a table
    Given the table exists
    And the table is "ACTIVE"
    And the snapshot does not already exist
    When a snapshot is created for a table
    Then the snapshot is "ACTIVE" and the table snapshot count increases
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @create_snapshot
  Scenario: a snapshot is created for a table fails when the table does not exist
    Given the table does not exist
    When a snapshot is created for a table
    Then the operation is rejected

  @standard @negative @create_snapshot @lifecycle
  Scenario: a snapshot is created for a table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a snapshot is created for a table
    Then the operation is rejected

  @standard @negative @create_snapshot
  Scenario: a snapshot is created for a table fails when the snapshot already exists
    Given the table exists
    And the table is "ACTIVE"
    And the snapshot already exists
    When a snapshot is created for a table
    Then the operation is rejected
