@s3tables @generated
Feature: S3tables - A Table Finishes Creating

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_table @internal
  Scenario: a table finishes creating
    Given the table exists
    And the table is "CREATING"
    When a table finishes creating
    Then the table is "ACTIVE"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @finish_creating_table @internal
  Scenario: a table finishes creating fails when the table does not exist
    Given the table does not exist
    When a table finishes creating
    Then the operation is rejected

  @standard @negative @finish_creating_table @internal
  Scenario: a table finishes creating fails when the table is not "CREATING"
    Given the table exists
    And the table is not "CREATING"
    When a table finishes creating
    Then the operation is rejected
