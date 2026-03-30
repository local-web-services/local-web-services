@s3tables @generated
Feature: S3tables - A Table Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a table is deleted
    Given the table exists
    And the table is "ACTIVE"
    When a table is deleted
    Then the table enters "DELETING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @delete_table
  Scenario: a table is deleted fails when the table does not exist
    Given the table does not exist
    When a table is deleted
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a table is deleted fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a table is deleted
    Then the operation is rejected
