@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table" Finishes Creating

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_creating_table @internal
  Scenario: a "s3 tables" "table" finishes creating
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "CREATING"
    When a "s3 tables" "table" finishes creating
    Then the "s3 tables" "table" will be "ACTIVE"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @finish_creating_table @internal
  Scenario: a "s3 tables" "table" finishes creating fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table" finishes creating
    Then the operation is rejected

  @guard @negative @finish_creating_table @internal
  Scenario: a "s3 tables" "table" finishes creating fails when the "s3 tables" "table" was not "CREATING"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "CREATING"
    When a "s3 tables" "table" finishes creating
    Then the operation is rejected
