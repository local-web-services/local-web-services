@s3tables @generated
Feature: S3tables - A Table'S Schema Is Evolved

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @evolve_schema
  Scenario: a table's schema is evolved
    Given the table exists
    And the table is "ACTIVE"
    When a table's schema is evolved
    Then the schema version is incremented
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @evolve_schema
  Scenario: a table's schema is evolved fails when the table does not exist
    Given the table does not exist
    When a table's schema is evolved
    Then the operation is rejected

  @standard @negative @evolve_schema @lifecycle
  Scenario: a table's schema is evolved fails when the table is not "ACTIVE"
    Given the table exists
    And the table is not "ACTIVE"
    When a table's schema is evolved
    Then the operation is rejected
