@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table" Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_table @internal
  Scenario: a "s3 tables" "table" finishes being deleted
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "DELETING"
    When a "s3 tables" "table" finishes being deleted
    Then the "s3 tables" "table" will be "DELETED" and all its snapshots will be deleted
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @finish_deleting_table @internal
  Scenario: a "s3 tables" "table" finishes being deleted fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_deleting_table @internal
  Scenario: a "s3 tables" "table" finishes being deleted fails when the "s3 tables" "table" was not "DELETING"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "DELETING"
    When a "s3 tables" "table" finishes being deleted
    Then the operation is rejected
