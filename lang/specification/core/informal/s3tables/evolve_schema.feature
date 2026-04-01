@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table"'S Schema Is Evolved

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @evolve_schema
  Scenario: a "s3 tables" "table"'s schema is evolved
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When a "s3 tables" "table"'s schema is evolved
    Then the "s3 tables" "table" schema version will be incremented
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @evolve_schema
  Scenario: a "s3 tables" "table"'s schema is evolved fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table"'s schema is evolved
    Then the operation is rejected

  @guard @negative @evolve_schema @lifecycle
  Scenario: a "s3 tables" "table"'s schema is evolved fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When a "s3 tables" "table"'s schema is evolved
    Then the operation is rejected
