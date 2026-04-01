@s3tables @generated
Feature: S3tables - A "S3 Tables" "Namespace" Is Created In A "S3 Tables" "Table" S3 Tables Bucket

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_namespace
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" did not already exist
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Then the "s3 tables" "namespace" will be "ACTIVE"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a "s3 tables" "namespace" in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @create_namespace
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket fails when the "s3 tables" "bucket" did not exist
    Given the "s3 tables" "bucket" did not exist
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Then the operation is rejected

  @guard @negative @create_namespace @lifecycle
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket fails when the "s3 tables" "bucket" was not "ACTIVE"
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was not "ACTIVE"
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Then the operation is rejected

  @guard @negative @create_namespace
  Scenario: a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket fails when the "s3 tables" "namespace" already existed
    Given the "s3 tables" "bucket" existed
    And the "s3 tables" "bucket" was "ACTIVE"
    And the "s3 tables" "namespace" already existed
    When a "s3 tables" "namespace" is created in a "s3 tables" "table" s3 tables bucket
    Then the operation is rejected
