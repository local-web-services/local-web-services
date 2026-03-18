@s3tables @generated
Feature: S3tables - An Expired Snapshot Is Removed From A Table

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @expire_snapshot
  Scenario: an expired snapshot is removed from a table
    Given the table exists
    And the table is "ACTIVE"
    And the table has more than one snapshot
    And the snapshot exists
    And the snapshot is "ACTIVE"
    When an expired snapshot is removed from a table
    Then the snapshot is "DELETED" and the table snapshot count decreases
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @expire_snapshot
  Scenario: an expired snapshot is removed from a table fails when the table does not exist
    Given the table does not exist
    When an expired snapshot is removed from a table
    Then the operation is rejected

  @standard @negative @expire_snapshot @lifecycle
  Scenario: an expired snapshot is removed from a table fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When an expired snapshot is removed from a table
    Then the operation is rejected

  @standard @negative @expire_snapshot
  Scenario: an expired snapshot is removed from a table fails when the table has one or fewer snapshots
    Given the table exists
    And the table is "ACTIVE"
    And the table has one or fewer snapshots
    When an expired snapshot is removed from a table
    Then the operation is rejected

  @standard @negative @expire_snapshot
  Scenario: an expired snapshot is removed from a table fails when the snapshot does not exist
    Given the table exists
    And the table is "ACTIVE"
    And the table has more than one snapshot
    And the snapshot does not exist
    When an expired snapshot is removed from a table
    Then the operation is rejected

  @standard @negative @expire_snapshot
  Scenario: an expired snapshot is removed from a table fails when the snapshot is not "ACTIVE"
    Given the table exists
    And the table is "ACTIVE"
    And the table has more than one snapshot
    And the snapshot exists
    And the snapshot is not "ACTIVE"
    When an expired snapshot is removed from a table
    Then the operation is rejected
