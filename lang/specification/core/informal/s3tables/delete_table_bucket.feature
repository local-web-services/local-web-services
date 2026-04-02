@s3tables @generated
Feature: S3tables - A "S3 Tables" "Bucket" Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table_bucket
  Scenario: a "s3 tables" "bucket" is deleted
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "bucket" had no active namespaces
    When a "s3 tables" "bucket" is deleted
    Then the "s3 tables" "bucket" will be in "DELETING" state
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @delete_table_bucket
  Scenario: a "s3 tables" "bucket" is deleted fails when the "s3 tables" "bucket" did not exist
    Given the "s3 tables" "bucket" did not exist
    When a "s3 tables" "bucket" is deleted
    Then the operation is rejected

  @guard @negative @delete_table_bucket @lifecycle
  Scenario: a "s3 tables" "bucket" is deleted fails when the "s3 tables" "bucket" was not "ACTIVE"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was not "ACTIVE"
    When a "s3 tables" "bucket" is deleted
    Then the operation is rejected

  @guard @negative @delete_table_bucket
  Scenario: a "s3 tables" "bucket" is deleted fails when the "s3 tables" "bucket" had active namespaces
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "bucket" had active namespaces
    When a "s3 tables" "bucket" is deleted
    Then the operation is rejected
