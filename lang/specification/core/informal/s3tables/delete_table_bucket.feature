@s3tables @generated
Feature: S3tables - A Table Bucket Is Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @delete_table_bucket
  Scenario: a table bucket is deleted
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket has no active namespaces
    When a table bucket is deleted
    Then the bucket enters "DELETING" state
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @delete_table_bucket
  Scenario: a table bucket is deleted fails when the bucket does not exist
    Given the bucket does not exist
    When a table bucket is deleted
    Then the operation is rejected

  @standard @negative @delete_table_bucket @lifecycle
  Scenario: a table bucket is deleted fails when the bucket is not "ACTIVE"
    Given the bucket exists
    And the bucket is not "ACTIVE"
    When a table bucket is deleted
    Then the operation is rejected

  @standard @negative @delete_table_bucket
  Scenario: a table bucket is deleted fails when the bucket has active namespaces
    Given the bucket exists
    And the bucket is "ACTIVE"
    And the bucket has active namespaces
    When a table bucket is deleted
    Then the operation is rejected
