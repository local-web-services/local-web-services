@s3tables @generated
Feature: S3tables - A "S3 Tables" "Bucket" Is Created

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_table_bucket
  Scenario: a "s3 tables" "bucket" is created
    Given the "s3 tables" "bucket" did not already exist
    When a "s3 tables" "bucket" is created
    Then the "s3 tables" "bucket" will be in "CREATING" state
    And a "s3 tables" "bucket" in "DELETING" state has no "ACTIVE" "s3 tables" "namespace"s
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" "s3 tables" "table"s
    And "s3 tables" "table" snapshot count is never negative
    And "s3 tables" "table" schema version is always at least one

  @guard @negative @create_table_bucket
  Scenario: a "s3 tables" "bucket" is created fails when the "s3 tables" "bucket" already existed
    Given the "s3 tables" "bucket" already existed
    When a "s3 tables" "bucket" is created
    Then the operation is rejected
