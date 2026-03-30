@s3tables @generated
Feature: S3tables - A Table Bucket Is Created

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @create_table_bucket
  Scenario: a table bucket is created
    Given the bucket does not already exist
    When a table bucket is created
    Then the bucket is in "CREATING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @guard @negative @create_table_bucket
  Scenario: a table bucket is created fails when the bucket already exists
    Given the bucket already exists
    When a table bucket is created
    Then the operation is rejected
