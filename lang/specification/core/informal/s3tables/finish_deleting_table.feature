@s3tables @generated
Feature: S3tables - A Table Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_table @internal
  Scenario: a table finishes being deleted
    Given the table exists
    And the table is "DELETING"
    When a table finishes being deleted
    Then the table is "DELETED" and all its snapshots are "DELETED"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @finish_deleting_table @internal
  Scenario: a table finishes being deleted fails when the table does not exist
    Given the table does not exist
    When a table finishes being deleted
    Then the operation is rejected

  @standard @negative @finish_deleting_table @internal
  Scenario: a table finishes being deleted fails when the table is not "DELETING"
    Given the table exists
    And the table is not "DELETING"
    When a table finishes being deleted
    Then the operation is rejected
