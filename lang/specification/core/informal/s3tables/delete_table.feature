@s3tables @generated
Feature: S3tables - A "S3 Tables" "Table" Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table
  Scenario: a "s3 tables" "table" is deleted
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was "ACTIVE"
    When a "s3 tables" "table" is deleted
    Then the "s3 tables" "table" will be in "DELETING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @delete_table
  Scenario: a "s3 tables" "table" is deleted fails when the "s3 tables" "table" did not exist
    Given the "s3 tables" "table" did not exist
    When a "s3 tables" "table" is deleted
    Then the operation is rejected

  @guard @negative @delete_table @lifecycle
  Scenario: a "s3 tables" "table" is deleted fails when the "s3 tables" "table" was not "ACTIVE"
    Given the "s3 tables" "table" existed
    And the "s3 tables" "table" was not "ACTIVE"
    When a "s3 tables" "table" is deleted
    Then the operation is rejected
