@s3tables @generated
Feature: S3tables - A Table Bucket Finishes Being Deleted

  # Generated from FizzBee spec: s3tables.fizz
  # Safety invariants: BucketDeletionRequiresNoNamespaces, NamespaceDeletionRequiresNoTables, SnapshotCountNonNegative, SchemaVersionAtLeastOne

  Background:
    Given the system is initialized

  @minimal @happy @finish_deleting_table_bucket @internal
  Scenario: a table bucket finishes being deleted
    Given the bucket exists
    And the bucket is "DELETING"
    When a table bucket finishes being deleted
    Then the bucket is "DELETED" and all its namespaces and tables are "DELETED"
    And a bucket in "DELETING" state has no "ACTIVE" namespaces
    And a namespace in "DELETING" state has no "ACTIVE" tables
    And snapshot count is never negative
    And schema version is always at least one

  @standard @negative @finish_deleting_table_bucket @internal
  Scenario: a table bucket finishes being deleted fails when the bucket does not exist
    Given the bucket does not exist
    When a table bucket finishes being deleted
    Then the operation is rejected

  @standard @negative @finish_deleting_table_bucket @internal
  Scenario: a table bucket finishes being deleted fails when the bucket is not "DELETING"
    Given the bucket exists
    And the bucket is not "DELETING"
    When a table bucket finishes being deleted
    Then the operation is rejected
