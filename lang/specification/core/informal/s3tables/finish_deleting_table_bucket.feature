@s3tables @generated
Feature: S3tables - A "S3 Tables" "Bucket" Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_table_bucket @internal
  Scenario: a "s3 tables" "bucket" finishes being deleted
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "DELETING"
    When a "s3 tables" "bucket" finishes being deleted
    Then the "s3 tables" "bucket" will be "DELETED" and all its namespaces and tables will be deleted
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @finish_deleting_table_bucket @internal
  Scenario: a "s3 tables" "bucket" finishes being deleted fails when the "s3 tables" "bucket" did not exist
    Given the "s3 tables" "bucket" did not exist
    When a "s3 tables" "bucket" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_deleting_table_bucket @internal
  Scenario: a "s3 tables" "bucket" finishes being deleted fails when the "s3 tables" "bucket" was not "DELETING"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was not "DELETING"
    When a "s3 tables" "bucket" finishes being deleted
    Then the operation is rejected
